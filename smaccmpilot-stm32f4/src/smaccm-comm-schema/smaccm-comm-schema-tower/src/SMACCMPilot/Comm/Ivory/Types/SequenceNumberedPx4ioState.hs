{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedPx4ioState where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.Px4ioState as Px4ioState
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_px4io_state
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct px4io_state
  }
|]
packSequenceNumberedPx4ioState :: WrappedPackRep ('Struct "sequence_numbered_px4io_state")
packSequenceNumberedPx4ioState = wrapPackRep "sequence_numbered_px4io_state" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_px4io_state") where
  packRep = wrappedPackRep packSequenceNumberedPx4ioState
sequenceNumberedPx4ioStateTypesModule :: Module
sequenceNumberedPx4ioStateTypesModule = package "sequence_numbered_px4io_state_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_px4io_state")
  depend serializeModule
  wrappedPackMod packSequenceNumberedPx4ioState
  depend SequenceNum.sequenceNumTypesModule
  depend Px4ioState.px4ioStateTypesModule