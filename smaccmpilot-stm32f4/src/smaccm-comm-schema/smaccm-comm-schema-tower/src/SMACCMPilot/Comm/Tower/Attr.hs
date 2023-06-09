{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RecordWildCards #-}

module SMACCMPilot.Comm.Tower.Attr where

import Ivory.Language
import Ivory.Tower
import SMACCMPilot.Comm.Ivory.Types.SequenceNum

data AttrWriter a =
  AttrWriter
    { aw_chan :: ChanInput a
    , aw_name :: String
    }

data AttrReader a =
  AttrReader
    { ar_chan :: ChanOutput a
    , ar_name :: String
    , ar_ival :: Init a
    }

data Attr a =
  Attr
    { attr_writer :: AttrWriter a
    , attr_reader :: AttrReader a
    }

attrReaderState :: (IvoryArea a, IvoryZero a)
                => AttrReader a -> Monitor e (Ref 'Global a)
attrReaderState ar@AttrReader{..} = do
  s <- stateInit ar_name ar_ival
  attrReaderHandler ar $ do
    callback $ \v -> refCopy s v
  return s

attrReaderHandler :: (IvoryArea a, IvoryZero a)
                  => AttrReader a -> Handler a e () -> Monitor e ()
attrReaderHandler AttrReader{..} k =
  handler ar_chan (ar_name ++ "_update") k

attrWriterEmitter :: (IvoryArea a, IvoryZero a) 
                  => AttrWriter a -> Handler b e (Emitter a)
attrWriterEmitter AttrWriter{..} = emitter aw_chan 1

towerAttr :: (IvoryArea a) => String -> Init a -> Tower e (Attr a)
towerAttr n i = do
  c <- channel
  return Attr
    { attr_writer = AttrWriter
      { aw_chan = fst c
      , aw_name = n
      }
    , attr_reader = AttrReader
      { ar_chan = snd c
      , ar_name = n
      , ar_ival = i
      }
    }

class AttrNamed p where
  attrName :: (IvoryArea a) => p a -> String

instance AttrNamed AttrReader where
  attrName = ar_name

instance AttrNamed AttrWriter where
  attrName = aw_name

instance AttrNamed Attr where
  attrName = attrName . attr_reader

class AttrReadable p where
  attrState   :: (IvoryArea a, IvoryZero a) => p a -> Monitor e (Ref 'Global a)
  attrHandler :: (IvoryArea a, IvoryZero a) => p a -> Handler a e () -> Monitor e ()
  attrReaderChan :: p a -> ChanOutput a

instance AttrReadable AttrReader where
  attrState = attrReaderState
  attrHandler = attrReaderHandler
  attrReaderChan = ar_chan

instance AttrReadable Attr where
  attrState = attrReaderState . attr_reader
  attrHandler p k = attrReaderHandler (attr_reader p) k
  attrReaderChan = attrReaderChan . attr_reader

class AttrWritable p where
  attrEmitter :: (IvoryArea a, IvoryZero a) => p a -> Handler b e (Emitter a)

instance AttrWritable AttrWriter where
  attrEmitter = attrWriterEmitter

instance AttrWritable Attr where
  attrEmitter = attrWriterEmitter . attr_writer


readableAttrServer :: ( IvoryArea a, IvoryZero a
                      , IvoryArea ('Struct b), IvoryZero ('Struct b), IvoryStruct b)
                   => Label b a
                   -> Label b ('Stored SequenceNum)
                   -> Attr a
                   -> ChanOutput ('Stored SequenceNum)
                   -> Tower e (ChanOutput ('Struct b))
readableAttrServer val_lbl snum_lbl p get = do
  get_response <- channel
  monitor (named "Server") $ do
    s <- attrState p
    handler get (named "Get") $ do
      e <- emitter (fst get_response) 1
      callbackV $ \snum -> do
        v <- local izero
        refCopy (v ~> val_lbl) s
        store (v ~> snum_lbl) snum
        emit e (constRef v)
  return (snd get_response)
  where
  named n = attrName p ++ n

writableAttrServer :: (IvoryArea a, IvoryZero a
                      , IvoryArea ('Struct b), IvoryZero ('Struct b), IvoryStruct b)
                   => Label b a
                   -> Label b ('Stored SequenceNum)
                   -> Attr a
                   -> ChanOutput ('Struct b)
                   -> Tower e (ChanOutput ('Stored SequenceNum))
writableAttrServer val_lbl snum_lbl p set = do
  set_response <- channel
  monitor (named "Server") $ do
    handler set (named "Set") $ do
      e <- attrEmitter p
      r <- emitter (fst set_response) 1
      callback $ \v -> do
        emit e (v ~> val_lbl)
        emit r (v ~> snum_lbl)
  return (snd set_response)
  where
  named n = attrName p ++ n

readwritableAttrServer :: ( IvoryArea a, IvoryZero a
                          , IvoryArea ('Struct b), IvoryZero ('Struct b), IvoryStruct b)
                       => Label b a
                       -> Label b ('Stored SequenceNum)
                       -> Attr a
                       -> ChanOutput ('Stored SequenceNum)
                       -> ChanOutput ('Struct b)
                       -> Tower e (ChanOutput ('Struct b), ChanOutput ('Stored SequenceNum))
readwritableAttrServer val_lbl snum_lbl p get set = do
  get_response <- channel
  set_response <- channel
  monitor (named "Server") $ do
    s <- attrState p
    handler get (named "Get") $ do
      e <- emitter (fst get_response) 1
      callbackV $ \snum -> do
        v <- local izero
        refCopy (v ~> val_lbl) s
        store (v ~> snum_lbl) snum
        emit e (constRef v)
    handler set (named "Set") $ do
      e <- attrEmitter p
      r <- emitter (fst set_response) 1
      callback $ \v -> do
        emit e (v ~> val_lbl)
        emit r (v ~> snum_lbl)
  return (snd get_response, snd set_response)
  where
  named n = attrName p ++ n

attrProxy :: (AttrWritable w, AttrNamed w, IvoryArea a, IvoryZero a)
          => w a
          -> ChanOutput a
          -> Tower e ()
attrProxy attr chan = do
  monitor (attrName attr ++ "Proxy") $ do
    handler chan ("write_" ++ attrName attr) $ do
      e <- attrEmitter attr
      callback $ \v -> emit e v