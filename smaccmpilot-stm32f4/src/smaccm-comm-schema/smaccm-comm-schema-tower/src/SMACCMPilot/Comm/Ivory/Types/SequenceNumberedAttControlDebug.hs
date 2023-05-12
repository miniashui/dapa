{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedAttControlDebug where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.AttControlDebug as AttControlDebug
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_att_control_debug
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct att_control_debug
  }
|]
packSequenceNumberedAttControlDebug :: WrappedPackRep ('Struct "sequence_numbered_att_control_debug")
packSequenceNumberedAttControlDebug = wrapPackRep "sequence_numbered_att_control_debug" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_att_control_debug") where
  packRep = wrappedPackRep packSequenceNumberedAttControlDebug
sequenceNumberedAttControlDebugTypesModule :: Module
sequenceNumberedAttControlDebugTypesModule = package "sequence_numbered_att_control_debug_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_att_control_debug")
  depend serializeModule
  wrappedPackMod packSequenceNumberedAttControlDebug
  depend SequenceNum.sequenceNumTypesModule
  depend AttControlDebug.attControlDebugTypesModule