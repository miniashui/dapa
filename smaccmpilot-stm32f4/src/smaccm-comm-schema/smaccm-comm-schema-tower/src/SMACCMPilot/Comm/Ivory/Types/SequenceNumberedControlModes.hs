{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedControlModes where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.ControlModes as ControlModes
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_control_modes
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct control_modes
  }
|]
packSequenceNumberedControlModes :: WrappedPackRep ('Struct "sequence_numbered_control_modes")
packSequenceNumberedControlModes = wrapPackRep "sequence_numbered_control_modes" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_control_modes") where
  packRep = wrappedPackRep packSequenceNumberedControlModes
sequenceNumberedControlModesTypesModule :: Module
sequenceNumberedControlModesTypesModule = package "sequence_numbered_control_modes_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_control_modes")
  depend serializeModule
  wrappedPackMod packSequenceNumberedControlModes
  depend SequenceNum.sequenceNumTypesModule
  depend ControlModes.controlModesTypesModule