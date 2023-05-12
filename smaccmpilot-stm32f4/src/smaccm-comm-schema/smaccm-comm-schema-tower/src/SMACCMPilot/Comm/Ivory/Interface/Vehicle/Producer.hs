{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
module SMACCMPilot.Comm.Ivory.Interface.Vehicle.Producer where
import qualified SMACCMPilot.Comm.Ivory.Types.Heartbeat as Heartbeat
import qualified SMACCMPilot.Comm.Ivory.Types.TimeMicros as TimeMicros
import qualified SMACCMPilot.Comm.Ivory.Types.ArmingMode as ArmingMode
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedPackedStatus as SequenceNumberedPackedStatus
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.PackedStatus as PackedStatus
import qualified SMACCMPilot.Comm.Ivory.Types.GpsFix as GpsFix
import qualified SMACCMPilot.Comm.Ivory.Types.Tristate as Tristate
import qualified SMACCMPilot.Comm.Ivory.Types.ControlModes as ControlModes
import qualified SMACCMPilot.Comm.Ivory.Types.ControlSource as ControlSource
import qualified SMACCMPilot.Comm.Ivory.Types.YawMode as YawMode
import qualified SMACCMPilot.Comm.Ivory.Types.ThrottleMode as ThrottleMode
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedControlLaw as SequenceNumberedControlLaw
import qualified SMACCMPilot.Comm.Ivory.Types.ControlLaw as ControlLaw
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedRcInput as SequenceNumberedRcInput
import qualified SMACCMPilot.Comm.Ivory.Types.RcInput as RcInput
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedUserInputResult as SequenceNumberedUserInputResult
import qualified SMACCMPilot.Comm.Ivory.Types.UserInputResult as UserInputResult
import qualified SMACCMPilot.Comm.Ivory.Types.UserInput as UserInput
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedSensorsResult as SequenceNumberedSensorsResult
import qualified SMACCMPilot.Comm.Ivory.Types.SensorsResult as SensorsResult
import qualified SMACCMPilot.Comm.Ivory.Types.Xyz as Xyz
import qualified SMACCMPilot.Comm.Ivory.Types.Quaternion as Quaternion
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedGyroscopeSample as SequenceNumberedGyroscopeSample
import qualified SMACCMPilot.Comm.Ivory.Types.GyroscopeSample as GyroscopeSample
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedAccelerometerSample as SequenceNumberedAccelerometerSample
import qualified SMACCMPilot.Comm.Ivory.Types.AccelerometerSample as AccelerometerSample
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedBarometerSample as SequenceNumberedBarometerSample
import qualified SMACCMPilot.Comm.Ivory.Types.BarometerSample as BarometerSample
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedLidarliteSample as SequenceNumberedLidarliteSample
import qualified SMACCMPilot.Comm.Ivory.Types.LidarliteSample as LidarliteSample
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedMagnetometerSample as SequenceNumberedMagnetometerSample
import qualified SMACCMPilot.Comm.Ivory.Types.MagnetometerSample as MagnetometerSample
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedPx4flowIntegralSample as SequenceNumberedPx4flowIntegralSample
import qualified SMACCMPilot.Comm.Ivory.Types.Px4flowIntegralSample as Px4flowIntegralSample
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedPx4flowSample as SequenceNumberedPx4flowSample
import qualified SMACCMPilot.Comm.Ivory.Types.Px4flowSample as Px4flowSample
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedPositionSample as SequenceNumberedPositionSample
import qualified SMACCMPilot.Comm.Ivory.Types.PositionSample as PositionSample
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedControlSetpoint as SequenceNumberedControlSetpoint
import qualified SMACCMPilot.Comm.Ivory.Types.ControlSetpoint as ControlSetpoint
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedControlOutput as SequenceNumberedControlOutput
import qualified SMACCMPilot.Comm.Ivory.Types.ControlOutput as ControlOutput
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedQuadcopterMotors as SequenceNumberedQuadcopterMotors
import qualified SMACCMPilot.Comm.Ivory.Types.QuadcopterMotors as QuadcopterMotors
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedAttControlDebug as SequenceNumberedAttControlDebug
import qualified SMACCMPilot.Comm.Ivory.Types.AttControlDebug as AttControlDebug
import qualified SMACCMPilot.Comm.Ivory.Types.PidState as PidState
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedAltControlDebug as SequenceNumberedAltControlDebug
import qualified SMACCMPilot.Comm.Ivory.Types.AltControlDebug as AltControlDebug
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedPx4ioState as SequenceNumberedPx4ioState
import qualified SMACCMPilot.Comm.Ivory.Types.Px4ioState as Px4ioState
import qualified SMACCMPilot.Comm.Ivory.Types.Px4ioStatus as Px4ioStatus
import qualified SMACCMPilot.Comm.Ivory.Types.Px4ioAlarms as Px4ioAlarms
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedArmingStatus as SequenceNumberedArmingStatus
import qualified SMACCMPilot.Comm.Ivory.Types.ArmingStatus as ArmingStatus
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedFloat as SequenceNumberedFloat
import SMACCMPilot.Comm.Ivory.Unpack
import Ivory.Language
import Ivory.Serialize
import Ivory.Stdlib
-- Define Producer schema for Vehicle interface
data VehicleProducer = VehicleProducer
  { heartbeatProducer :: (forall s r b s' . ConstRef s' ('Struct "heartbeat") -> Ivory ('Effects r b ('Scope s)) IBool)
  , packedStatusGetRespProducer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_packed_status") -> Ivory ('Effects r b ('Scope s)) IBool)
  , controlLawGetRespProducer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_control_law") -> Ivory ('Effects r b ('Scope s)) IBool)
  , rcInputGetRespProducer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_rc_input") -> Ivory ('Effects r b ('Scope s)) IBool)
  , userInputGetRespProducer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_user_input_result") -> Ivory ('Effects r b ('Scope s)) IBool)
  , sensorsOutputGetRespProducer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_sensors_result") -> Ivory ('Effects r b ('Scope s)) IBool)
  , gyroOutputGetRespProducer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_gyroscope_sample") -> Ivory ('Effects r b ('Scope s)) IBool)
  , accelOutputGetRespProducer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_accelerometer_sample") -> Ivory ('Effects r b ('Scope s)) IBool)
  , baroOutputGetRespProducer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_barometer_sample") -> Ivory ('Effects r b ('Scope s)) IBool)
  , lidarliteOutputGetRespProducer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_lidarlite_sample") -> Ivory ('Effects r b ('Scope s)) IBool)
  , magOutputGetRespProducer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_magnetometer_sample") -> Ivory ('Effects r b ('Scope s)) IBool)
  , px4flowIntOutputGetRespProducer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_px4flow_integral_sample") -> Ivory ('Effects r b ('Scope s)) IBool)
  , px4flowOutputGetRespProducer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_px4flow_sample") -> Ivory ('Effects r b ('Scope s)) IBool)
  , gpsOutputGetRespProducer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_position_sample") -> Ivory ('Effects r b ('Scope s)) IBool)
  , controlSetpointGetRespProducer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_control_setpoint") -> Ivory ('Effects r b ('Scope s)) IBool)
  , controlOutputGetRespProducer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_control_output") -> Ivory ('Effects r b ('Scope s)) IBool)
  , motorOutputGetRespProducer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_quadcopter_motors") -> Ivory ('Effects r b ('Scope s)) IBool)
  , attControlDebugGetRespProducer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_att_control_debug") -> Ivory ('Effects r b ('Scope s)) IBool)
  , altControlDebugGetRespProducer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_alt_control_debug") -> Ivory ('Effects r b ('Scope s)) IBool)
  , px4ioStateGetRespProducer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_px4io_state") -> Ivory ('Effects r b ('Scope s)) IBool)
  , armingStatusGetRespProducer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_arming_status") -> Ivory ('Effects r b ('Scope s)) IBool)
  , batteryVoltageGetRespProducer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_float") -> Ivory ('Effects r b ('Scope s)) IBool)
  }
vehicleProducerParser :: forall s0 r b s2 s3 n
                       . (ANat n)
                      => ConstRef s2 ('Array n ('Stored Uint8))
                      -> Ref s3 ('Stored Uint32)
                      -> VehicleProducer
                      -> Ivory ('Effects r b ('Scope s0)) IBool
vehicleProducerParser arr offs iface = do
  unpackWithCallback arr offs $ \tag_ref -> do
    (tag :: Uint32) <- deref tag_ref
    cond [ (tag ==? 1509716040) ==> unpackWithCallback arr offs (heartbeatProducer iface)
         , (tag ==? 1735600494) ==> unpackWithCallback arr offs (packedStatusGetRespProducer iface)
         , (tag ==? 3876556457) ==> unpackWithCallback arr offs (controlLawGetRespProducer iface)
         , (tag ==? 1446573644) ==> unpackWithCallback arr offs (rcInputGetRespProducer iface)
         , (tag ==? 1335290396) ==> unpackWithCallback arr offs (userInputGetRespProducer iface)
         , (tag ==? 1667182401) ==> unpackWithCallback arr offs (sensorsOutputGetRespProducer iface)
         , (tag ==? 1997727756) ==> unpackWithCallback arr offs (gyroOutputGetRespProducer iface)
         , (tag ==? 1378612854) ==> unpackWithCallback arr offs (accelOutputGetRespProducer iface)
         , (tag ==? 1073672794) ==> unpackWithCallback arr offs (baroOutputGetRespProducer iface)
         , (tag ==? 2422378638) ==> unpackWithCallback arr offs (lidarliteOutputGetRespProducer iface)
         , (tag ==? 3699308949) ==> unpackWithCallback arr offs (magOutputGetRespProducer iface)
         , (tag ==? 1473571804) ==> unpackWithCallback arr offs (px4flowIntOutputGetRespProducer iface)
         , (tag ==? 4276912125) ==> unpackWithCallback arr offs (px4flowOutputGetRespProducer iface)
         , (tag ==? 3319765549) ==> unpackWithCallback arr offs (gpsOutputGetRespProducer iface)
         , (tag ==? 271213343) ==> unpackWithCallback arr offs (controlSetpointGetRespProducer iface)
         , (tag ==? 2547029879) ==> unpackWithCallback arr offs (controlOutputGetRespProducer iface)
         , (tag ==? 3888088172) ==> unpackWithCallback arr offs (motorOutputGetRespProducer iface)
         , (tag ==? 2996876726) ==> unpackWithCallback arr offs (attControlDebugGetRespProducer iface)
         , (tag ==? 1833368932) ==> unpackWithCallback arr offs (altControlDebugGetRespProducer iface)
         , (tag ==? 725470924) ==> unpackWithCallback arr offs (px4ioStateGetRespProducer iface)
         , (tag ==? 1795869700) ==> unpackWithCallback arr offs (armingStatusGetRespProducer iface)
         , (tag ==? 976778984) ==> unpackWithCallback arr offs (batteryVoltageGetRespProducer iface)
         ]
vehicleProducerSender :: forall n s1 s2
                       . (ANat n)
                      => Ref s1 ('Array n ('Stored Uint8))
                      -> Ref s2 ('Stored Uint32)
                      -> VehicleProducer
vehicleProducerSender arr offs = VehicleProducer
  { heartbeatProducer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "heartbeat") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 1509716040 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , packedStatusGetRespProducer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_packed_status") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 1735600494 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , controlLawGetRespProducer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_control_law") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 3876556457 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , rcInputGetRespProducer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_rc_input") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 1446573644 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , userInputGetRespProducer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_user_input_result") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 1335290396 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , sensorsOutputGetRespProducer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_sensors_result") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 1667182401 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , gyroOutputGetRespProducer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_gyroscope_sample") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 1997727756 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , accelOutputGetRespProducer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_accelerometer_sample") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 1378612854 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , baroOutputGetRespProducer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_barometer_sample") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 1073672794 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , lidarliteOutputGetRespProducer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_lidarlite_sample") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 2422378638 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , magOutputGetRespProducer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_magnetometer_sample") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 3699308949 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , px4flowIntOutputGetRespProducer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_px4flow_integral_sample") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 1473571804 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , px4flowOutputGetRespProducer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_px4flow_sample") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 4276912125 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , gpsOutputGetRespProducer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_position_sample") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 3319765549 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , controlSetpointGetRespProducer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_control_setpoint") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 271213343 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , controlOutputGetRespProducer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_control_output") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 2547029879 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , motorOutputGetRespProducer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_quadcopter_motors") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 3888088172 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , attControlDebugGetRespProducer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_att_control_debug") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 2996876726 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , altControlDebugGetRespProducer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_alt_control_debug") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 1833368932 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , px4ioStateGetRespProducer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_px4io_state") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 725470924 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , armingStatusGetRespProducer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_arming_status") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 1795869700 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , batteryVoltageGetRespProducer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_float") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 976778984 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  }