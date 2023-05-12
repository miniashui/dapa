{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
module SMACCMPilot.Comm.Ivory.Interface.ControllableVehicle.Consumer where
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNum as SequenceNum
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedFloat as SequenceNumberedFloat
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedPidConfig as SequenceNumberedPidConfig
import qualified SMACCMPilot.Comm.Ivory.Types.PidConfig as PidConfig
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedThrottleUi as SequenceNumberedThrottleUi
import qualified SMACCMPilot.Comm.Ivory.Types.ThrottleUi as ThrottleUi
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedStabConfig as SequenceNumberedStabConfig
import qualified SMACCMPilot.Comm.Ivory.Types.StabConfig as StabConfig
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedTristate as SequenceNumberedTristate
import qualified SMACCMPilot.Comm.Ivory.Types.Tristate as Tristate
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedControlModes as SequenceNumberedControlModes
import qualified SMACCMPilot.Comm.Ivory.Types.ControlModes as ControlModes
import qualified SMACCMPilot.Comm.Ivory.Types.ControlSource as ControlSource
import qualified SMACCMPilot.Comm.Ivory.Types.YawMode as YawMode
import qualified SMACCMPilot.Comm.Ivory.Types.ThrottleMode as ThrottleMode
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedUserInput as SequenceNumberedUserInput
import qualified SMACCMPilot.Comm.Ivory.Types.UserInput as UserInput
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedRgbLedSetting as SequenceNumberedRgbLedSetting
import qualified SMACCMPilot.Comm.Ivory.Types.RgbLedSetting as RgbLedSetting
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedCameraTarget as SequenceNumberedCameraTarget
import qualified SMACCMPilot.Comm.Ivory.Types.CameraTarget as CameraTarget
import qualified SMACCMPilot.Comm.Ivory.Types.Heartbeat as Heartbeat
import qualified SMACCMPilot.Comm.Ivory.Types.TimeMicros as TimeMicros
import qualified SMACCMPilot.Comm.Ivory.Types.ArmingMode as ArmingMode
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedPackedStatus as SequenceNumberedPackedStatus
import qualified SMACCMPilot.Comm.Ivory.Types.PackedStatus as PackedStatus
import qualified SMACCMPilot.Comm.Ivory.Types.GpsFix as GpsFix
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedControlLaw as SequenceNumberedControlLaw
import qualified SMACCMPilot.Comm.Ivory.Types.ControlLaw as ControlLaw
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedRcInput as SequenceNumberedRcInput
import qualified SMACCMPilot.Comm.Ivory.Types.RcInput as RcInput
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedUserInputResult as SequenceNumberedUserInputResult
import qualified SMACCMPilot.Comm.Ivory.Types.UserInputResult as UserInputResult
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
import qualified SMACCMPilot.Comm.Ivory.Types.SequenceNumberedRebootReq as SequenceNumberedRebootReq
import qualified SMACCMPilot.Comm.Ivory.Types.RebootReq as RebootReq
import qualified SMACCMPilot.Comm.Ivory.Types.RebootMagic as RebootMagic
import SMACCMPilot.Comm.Ivory.Unpack
import Ivory.Language
import Ivory.Serialize
import Ivory.Stdlib
-- Define Consumer schema for ControllableVehicle interface
data ControllableVehicleConsumer = ControllableVehicleConsumer
  { rebootReqSetReqConsumer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_reboot_req") -> Ivory ('Effects r b ('Scope s)) IBool)
  , nominalThrottleSetReqConsumer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_float") -> Ivory ('Effects r b ('Scope s)) IBool)
  , nominalThrottleGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , altitudeRatePidSetReqConsumer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_pid_config") -> Ivory ('Effects r b ('Scope s)) IBool)
  , altitudeRatePidGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , altitudePositionPidSetReqConsumer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_pid_config") -> Ivory ('Effects r b ('Scope s)) IBool)
  , altitudePositionPidGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , throttleUiSetReqConsumer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_throttle_ui") -> Ivory ('Effects r b ('Scope s)) IBool)
  , throttleUiGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , attitudeRollStabSetReqConsumer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_stab_config") -> Ivory ('Effects r b ('Scope s)) IBool)
  , attitudeRollStabGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , attitudePitchStabSetReqConsumer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_stab_config") -> Ivory ('Effects r b ('Scope s)) IBool)
  , attitudePitchStabGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , yawRatePidSetReqConsumer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_pid_config") -> Ivory ('Effects r b ('Scope s)) IBool)
  , yawRatePidGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , yawPositionPidSetReqConsumer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_pid_config") -> Ivory ('Effects r b ('Scope s)) IBool)
  , yawPositionPidGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , armingRequestSetReqConsumer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_tristate") -> Ivory ('Effects r b ('Scope s)) IBool)
  , armingRequestGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , controlModesRequestSetReqConsumer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_control_modes") -> Ivory ('Effects r b ('Scope s)) IBool)
  , controlModesRequestGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , userInputRequestSetReqConsumer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_user_input") -> Ivory ('Effects r b ('Scope s)) IBool)
  , userInputRequestGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , rgbLedSetReqConsumer :: (forall s r b s' . ConstRef s' ('Struct "sequence_numbered_rgb_led_setting") -> Ivory ('Effects r b ('Scope s)) IBool)
  , rgbLedGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , cameraTargetInputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , packedStatusGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , controlLawGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , rcInputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , userInputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , sensorsOutputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , gyroOutputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , accelOutputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , baroOutputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , lidarliteOutputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , magOutputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , px4flowIntOutputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , px4flowOutputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , gpsOutputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , controlSetpointGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , controlOutputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , motorOutputGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , attControlDebugGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , altControlDebugGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , px4ioStateGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , armingStatusGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  , batteryVoltageGetReqConsumer :: (forall s r b s' . ConstRef s' ('Stored SequenceNum.SequenceNum) -> Ivory ('Effects r b ('Scope s)) IBool)
  }
controllableVehicleConsumerParser :: forall s0 r b s2 s3 n
                                   . (ANat n)
                                  => ConstRef s2 ('Array n ('Stored Uint8))
                                  -> Ref s3 ('Stored Uint32)
                                  -> ControllableVehicleConsumer
                                  -> Ivory ('Effects r b ('Scope s0)) IBool
controllableVehicleConsumerParser arr offs iface = do
  unpackWithCallback arr offs $ \tag_ref -> do
    (tag :: Uint32) <- deref tag_ref
    cond [ (tag ==? 2653177294) ==> unpackWithCallback arr offs (rebootReqSetReqConsumer iface)
         , (tag ==? 902408967) ==> unpackWithCallback arr offs (nominalThrottleSetReqConsumer iface)
         , (tag ==? 900547145) ==> unpackWithCallback arr offs (nominalThrottleGetReqConsumer iface)
         , (tag ==? 2277441295) ==> unpackWithCallback arr offs (altitudeRatePidSetReqConsumer iface)
         , (tag ==? 875324090) ==> unpackWithCallback arr offs (altitudeRatePidGetReqConsumer iface)
         , (tag ==? 1796873384) ==> unpackWithCallback arr offs (altitudePositionPidSetReqConsumer iface)
         , (tag ==? 2977840359) ==> unpackWithCallback arr offs (altitudePositionPidGetReqConsumer iface)
         , (tag ==? 2223647017) ==> unpackWithCallback arr offs (throttleUiSetReqConsumer iface)
         , (tag ==? 1993123068) ==> unpackWithCallback arr offs (throttleUiGetReqConsumer iface)
         , (tag ==? 1965596194) ==> unpackWithCallback arr offs (attitudeRollStabSetReqConsumer iface)
         , (tag ==? 3014795959) ==> unpackWithCallback arr offs (attitudeRollStabGetReqConsumer iface)
         , (tag ==? 1981014966) ==> unpackWithCallback arr offs (attitudePitchStabSetReqConsumer iface)
         , (tag ==? 1987435407) ==> unpackWithCallback arr offs (attitudePitchStabGetReqConsumer iface)
         , (tag ==? 358476597) ==> unpackWithCallback arr offs (yawRatePidSetReqConsumer iface)
         , (tag ==? 2269087216) ==> unpackWithCallback arr offs (yawRatePidGetReqConsumer iface)
         , (tag ==? 2133908270) ==> unpackWithCallback arr offs (yawPositionPidSetReqConsumer iface)
         , (tag ==? 3220216729) ==> unpackWithCallback arr offs (yawPositionPidGetReqConsumer iface)
         , (tag ==? 734318043) ==> unpackWithCallback arr offs (armingRequestSetReqConsumer iface)
         , (tag ==? 2927838066) ==> unpackWithCallback arr offs (armingRequestGetReqConsumer iface)
         , (tag ==? 4125087790) ==> unpackWithCallback arr offs (controlModesRequestSetReqConsumer iface)
         , (tag ==? 2571639185) ==> unpackWithCallback arr offs (controlModesRequestGetReqConsumer iface)
         , (tag ==? 1007683408) ==> unpackWithCallback arr offs (userInputRequestSetReqConsumer iface)
         , (tag ==? 3283842892) ==> unpackWithCallback arr offs (userInputRequestGetReqConsumer iface)
         , (tag ==? 2121216375) ==> unpackWithCallback arr offs (rgbLedSetReqConsumer iface)
         , (tag ==? 58884490) ==> unpackWithCallback arr offs (rgbLedGetReqConsumer iface)
         , (tag ==? 3442022133) ==> unpackWithCallback arr offs (cameraTargetInputGetReqConsumer iface)
         , (tag ==? 3156344986) ==> unpackWithCallback arr offs (packedStatusGetReqConsumer iface)
         , (tag ==? 301568917) ==> unpackWithCallback arr offs (controlLawGetReqConsumer iface)
         , (tag ==? 296944620) ==> unpackWithCallback arr offs (rcInputGetReqConsumer iface)
         , (tag ==? 399143934) ==> unpackWithCallback arr offs (userInputGetReqConsumer iface)
         , (tag ==? 26185883) ==> unpackWithCallback arr offs (sensorsOutputGetReqConsumer iface)
         , (tag ==? 82693526) ==> unpackWithCallback arr offs (gyroOutputGetReqConsumer iface)
         , (tag ==? 1941058076) ==> unpackWithCallback arr offs (accelOutputGetReqConsumer iface)
         , (tag ==? 3344129961) ==> unpackWithCallback arr offs (baroOutputGetReqConsumer iface)
         , (tag ==? 991289502) ==> unpackWithCallback arr offs (lidarliteOutputGetReqConsumer iface)
         , (tag ==? 143343139) ==> unpackWithCallback arr offs (magOutputGetReqConsumer iface)
         , (tag ==? 2862321756) ==> unpackWithCallback arr offs (px4flowIntOutputGetReqConsumer iface)
         , (tag ==? 359304658) ==> unpackWithCallback arr offs (px4flowOutputGetReqConsumer iface)
         , (tag ==? 3642047882) ==> unpackWithCallback arr offs (gpsOutputGetReqConsumer iface)
         , (tag ==? 1168870388) ==> unpackWithCallback arr offs (controlSetpointGetReqConsumer iface)
         , (tag ==? 2165647949) ==> unpackWithCallback arr offs (controlOutputGetReqConsumer iface)
         , (tag ==? 2700215595) ==> unpackWithCallback arr offs (motorOutputGetReqConsumer iface)
         , (tag ==? 1652180384) ==> unpackWithCallback arr offs (attControlDebugGetReqConsumer iface)
         , (tag ==? 3488192856) ==> unpackWithCallback arr offs (altControlDebugGetReqConsumer iface)
         , (tag ==? 3679040117) ==> unpackWithCallback arr offs (px4ioStateGetReqConsumer iface)
         , (tag ==? 1829088284) ==> unpackWithCallback arr offs (armingStatusGetReqConsumer iface)
         , (tag ==? 3999854279) ==> unpackWithCallback arr offs (batteryVoltageGetReqConsumer iface)
         ]
controllableVehicleConsumerSender :: forall n s1 s2
                                   . (ANat n)
                                  => Ref s1 ('Array n ('Stored Uint8))
                                  -> Ref s2 ('Stored Uint32)
                                  -> ControllableVehicleConsumer
controllableVehicleConsumerSender arr offs = ControllableVehicleConsumer
  { rebootReqSetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_reboot_req") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 2653177294 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , nominalThrottleSetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_float") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 902408967 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , nominalThrottleGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 900547145 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , altitudeRatePidSetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_pid_config") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 2277441295 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , altitudeRatePidGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 875324090 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , altitudePositionPidSetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_pid_config") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 1796873384 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , altitudePositionPidGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 2977840359 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , throttleUiSetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_throttle_ui") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 2223647017 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , throttleUiGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 1993123068 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , attitudeRollStabSetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_stab_config") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 1965596194 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , attitudeRollStabGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 3014795959 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , attitudePitchStabSetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_stab_config") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 1981014966 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , attitudePitchStabGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 1987435407 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , yawRatePidSetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_pid_config") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 358476597 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , yawRatePidGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 2269087216 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , yawPositionPidSetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_pid_config") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 2133908270 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , yawPositionPidGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 3220216729 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , armingRequestSetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_tristate") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 734318043 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , armingRequestGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 2927838066 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , controlModesRequestSetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_control_modes") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 4125087790 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , controlModesRequestGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 2571639185 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , userInputRequestSetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_user_input") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 1007683408 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , userInputRequestGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 3283842892 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , rgbLedSetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Struct "sequence_numbered_rgb_led_setting") ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 2121216375 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , rgbLedGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 58884490 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , cameraTargetInputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 3442022133 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , packedStatusGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 3156344986 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , controlLawGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 301568917 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , rcInputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 296944620 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , userInputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 399143934 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , sensorsOutputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 26185883 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , gyroOutputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 82693526 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , accelOutputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 1941058076 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , baroOutputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 3344129961 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , lidarliteOutputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 991289502 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , magOutputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 143343139 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , px4flowIntOutputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 2862321756 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , px4flowOutputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 359304658 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , gpsOutputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 3642047882 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , controlSetpointGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 1168870388 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , controlOutputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 2165647949 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , motorOutputGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 2700215595 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , attControlDebugGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 1652180384 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , altControlDebugGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 3488192856 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , px4ioStateGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 3679040117 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , armingStatusGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 1829088284 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  , batteryVoltageGetReqConsumer = \m -> do
      o <- deref offs
      let required_size = fromInteger (packSize (packRep :: PackRep ('Stored SequenceNum.SequenceNum) ) + packSize (packRep :: PackRep ('Stored Uint32)))
          sufficient_space = (o + required_size) <? arrayLen arr
      when sufficient_space $ do
        ident <- local (ival ( 3999854279 :: Uint32))
        packInto arr o (constRef ident)
        packInto arr (o + fromInteger (packSize (packRep :: PackRep ('Stored Uint32)))) m
        offs += required_size
      return sufficient_space
  }