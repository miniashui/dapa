{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module SMACCMPilot.Comm.Ivory.Types.SequenceNumberedControlSetpoint where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.ControlSetpoint as ControlSetpoint
import Ivory.Language
import Ivory.Serialize
[ivory|
struct sequence_numbered_control_setpoint
  { seqnum :: (Stored SequenceNum.SequenceNum)
  ; val :: Struct control_setpoint
  }
|]
packSequenceNumberedControlSetpoint :: WrappedPackRep ('Struct "sequence_numbered_control_setpoint")
packSequenceNumberedControlSetpoint = wrapPackRep "sequence_numbered_control_setpoint" $
  packStruct [ packLabel seqnum
             , packLabel val
             ]
instance Packable ('Struct "sequence_numbered_control_setpoint") where
  packRep = wrappedPackRep packSequenceNumberedControlSetpoint
sequenceNumberedControlSetpointTypesModule :: Module
sequenceNumberedControlSetpointTypesModule = package "sequence_numbered_control_setpoint_types" $ do
  defStruct (Proxy :: Proxy "sequence_numbered_control_setpoint")
  depend serializeModule
  wrappedPackMod packSequenceNumberedControlSetpoint
  depend SequenceNum.sequenceNumTypesModule
  depend ControlSetpoint.controlSetpointTypesModule