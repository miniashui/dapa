{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE RecordWildCards #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
{-# OPTIONS_GHC -fno-warn-unused-matches #-}
module SMACCMPilot.Comm.Tower.Interface.ControllableVehicle.Server where
import SMACCMPilot.Comm.Tower.Attr
import SMACCMPilot.Comm.Tower.Interface.ControllableVehicle.Producer
import SMACCMPilot.Comm.Tower.Interface.ControllableVehicle.Consumer
import Ivory.Language
import Ivory.Tower
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
data ControllableVehicleAttrs (p :: Area * -> *) =
  ControllableVehicleAttrs
    { rebootReq :: p ('Struct "reboot_req")
    , nominalThrottle :: p ('Stored IFloat)
    , altitudeRatePid :: p ('Struct "pid_config")
    , altitudePositionPid :: p ('Struct "pid_config")
    , throttleUi :: p ('Struct "throttle_ui")
    , attitudeRollStab :: p ('Struct "stab_config")
    , attitudePitchStab :: p ('Struct "stab_config")
    , yawRatePid :: p ('Struct "pid_config")
    , yawPositionPid :: p ('Struct "pid_config")
    , armingRequest :: p ('Stored Tristate.Tristate)
    , controlModesRequest :: p ('Struct "control_modes")
    , userInputRequest :: p ('Struct "user_input")
    , rgbLed :: p ('Struct "rgb_led_setting")
    , cameraTargetInput :: p ('Struct "camera_target")
    , packedStatus :: p ('Struct "packed_status")
    , controlLaw :: p ('Struct "control_law")
    , rcInput :: p ('Struct "rc_input")
    , userInput :: p ('Struct "user_input_result")
    , sensorsOutput :: p ('Struct "sensors_result")
    , gyroOutput :: p ('Struct "gyroscope_sample")
    , accelOutput :: p ('Struct "accelerometer_sample")
    , baroOutput :: p ('Struct "barometer_sample")
    , lidarliteOutput :: p ('Struct "lidarlite_sample")
    , magOutput :: p ('Struct "magnetometer_sample")
    , px4flowIntOutput :: p ('Struct "px4flow_integral_sample")
    , px4flowOutput :: p ('Struct "px4flow_sample")
    , gpsOutput :: p ('Struct "position_sample")
    , controlSetpoint :: p ('Struct "control_setpoint")
    , controlOutput :: p ('Struct "control_output")
    , motorOutput :: p ('Struct "quadcopter_motors")
    , attControlDebug :: p ('Struct "att_control_debug")
    , altControlDebug :: p ('Struct "alt_control_debug")
    , px4ioState :: p ('Struct "px4io_state")
    , armingStatus :: p ('Struct "arming_status")
    , batteryVoltage :: p ('Stored IFloat)
    }
towerControllableVehicleAttrs :: ControllableVehicleAttrs Init -> Tower e (ControllableVehicleAttrs Attr)
towerControllableVehicleAttrs ivals = do
  rebootReq_p <- towerAttr "reboot_req_attr" (rebootReq ivals)
  nominalThrottle_p <- towerAttr "nominal_throttle_attr" (nominalThrottle ivals)
  altitudeRatePid_p <- towerAttr "altitude_rate_pid_attr" (altitudeRatePid ivals)
  altitudePositionPid_p <- towerAttr "altitude_position_pid_attr" (altitudePositionPid ivals)
  throttleUi_p <- towerAttr "throttle_ui_attr" (throttleUi ivals)
  attitudeRollStab_p <- towerAttr "attitude_roll_stab_attr" (attitudeRollStab ivals)
  attitudePitchStab_p <- towerAttr "attitude_pitch_stab_attr" (attitudePitchStab ivals)
  yawRatePid_p <- towerAttr "yaw_rate_pid_attr" (yawRatePid ivals)
  yawPositionPid_p <- towerAttr "yaw_position_pid_attr" (yawPositionPid ivals)
  armingRequest_p <- towerAttr "arming_request_attr" (armingRequest ivals)
  controlModesRequest_p <- towerAttr "control_modes_request_attr" (controlModesRequest ivals)
  userInputRequest_p <- towerAttr "user_input_request_attr" (userInputRequest ivals)
  rgbLed_p <- towerAttr "rgb_led_attr" (rgbLed ivals)
  cameraTargetInput_p <- towerAttr "camera_target_input_attr" (cameraTargetInput ivals)
  packedStatus_p <- towerAttr "packed_status_attr" (packedStatus ivals)
  controlLaw_p <- towerAttr "control_law_attr" (controlLaw ivals)
  rcInput_p <- towerAttr "rc_input_attr" (rcInput ivals)
  userInput_p <- towerAttr "user_input_attr" (userInput ivals)
  sensorsOutput_p <- towerAttr "sensors_output_attr" (sensorsOutput ivals)
  gyroOutput_p <- towerAttr "gyro_output_attr" (gyroOutput ivals)
  accelOutput_p <- towerAttr "accel_output_attr" (accelOutput ivals)
  baroOutput_p <- towerAttr "baro_output_attr" (baroOutput ivals)
  lidarliteOutput_p <- towerAttr "lidarlite_output_attr" (lidarliteOutput ivals)
  magOutput_p <- towerAttr "mag_output_attr" (magOutput ivals)
  px4flowIntOutput_p <- towerAttr "px4flow_int_output_attr" (px4flowIntOutput ivals)
  px4flowOutput_p <- towerAttr "px4flow_output_attr" (px4flowOutput ivals)
  gpsOutput_p <- towerAttr "gps_output_attr" (gpsOutput ivals)
  controlSetpoint_p <- towerAttr "control_setpoint_attr" (controlSetpoint ivals)
  controlOutput_p <- towerAttr "control_output_attr" (controlOutput ivals)
  motorOutput_p <- towerAttr "motor_output_attr" (motorOutput ivals)
  attControlDebug_p <- towerAttr "att_control_debug_attr" (attControlDebug ivals)
  altControlDebug_p <- towerAttr "alt_control_debug_attr" (altControlDebug ivals)
  px4ioState_p <- towerAttr "px4io_state_attr" (px4ioState ivals)
  armingStatus_p <- towerAttr "arming_status_attr" (armingStatus ivals)
  batteryVoltage_p <- towerAttr "battery_voltage_attr" (batteryVoltage ivals)
  return ControllableVehicleAttrs { rebootReq = rebootReq_p
                                  , nominalThrottle = nominalThrottle_p
                                  , altitudeRatePid = altitudeRatePid_p
                                  , altitudePositionPid = altitudePositionPid_p
                                  , throttleUi = throttleUi_p
                                  , attitudeRollStab = attitudeRollStab_p
                                  , attitudePitchStab = attitudePitchStab_p
                                  , yawRatePid = yawRatePid_p
                                  , yawPositionPid = yawPositionPid_p
                                  , armingRequest = armingRequest_p
                                  , controlModesRequest = controlModesRequest_p
                                  , userInputRequest = userInputRequest_p
                                  , rgbLed = rgbLed_p
                                  , cameraTargetInput = cameraTargetInput_p
                                  , packedStatus = packedStatus_p
                                  , controlLaw = controlLaw_p
                                  , rcInput = rcInput_p
                                  , userInput = userInput_p
                                  , sensorsOutput = sensorsOutput_p
                                  , gyroOutput = gyroOutput_p
                                  , accelOutput = accelOutput_p
                                  , baroOutput = baroOutput_p
                                  , lidarliteOutput = lidarliteOutput_p
                                  , magOutput = magOutput_p
                                  , px4flowIntOutput = px4flowIntOutput_p
                                  , px4flowOutput = px4flowOutput_p
                                  , gpsOutput = gpsOutput_p
                                  , controlSetpoint = controlSetpoint_p
                                  , controlOutput = controlOutput_p
                                  , motorOutput = motorOutput_p
                                  , attControlDebug = attControlDebug_p
                                  , altControlDebug = altControlDebug_p
                                  , px4ioState = px4ioState_p
                                  , armingStatus = armingStatus_p
                                  , batteryVoltage = batteryVoltage_p
                                  }
initControllableVehicleAttrs :: ControllableVehicleAttrs Init
initControllableVehicleAttrs = ControllableVehicleAttrs
  { rebootReq = izero
  , nominalThrottle = izero
  , altitudeRatePid = izero
  , altitudePositionPid = izero
  , throttleUi = izero
  , attitudeRollStab = izero
  , attitudePitchStab = izero
  , yawRatePid = izero
  , yawPositionPid = izero
  , armingRequest = izero
  , controlModesRequest = izero
  , userInputRequest = izero
  , rgbLed = izero
  , cameraTargetInput = izero
  , packedStatus = izero
  , controlLaw = izero
  , rcInput = izero
  , userInput = izero
  , sensorsOutput = izero
  , gyroOutput = izero
  , accelOutput = izero
  , baroOutput = izero
  , lidarliteOutput = izero
  , magOutput = izero
  , px4flowIntOutput = izero
  , px4flowOutput = izero
  , gpsOutput = izero
  , controlSetpoint = izero
  , controlOutput = izero
  , motorOutput = izero
  , attControlDebug = izero
  , altControlDebug = izero
  , px4ioState = izero
  , armingStatus = izero
  , batteryVoltage = izero
  }
data ControllableVehicleStreams (p :: Area * -> *) =
  ControllableVehicleStreams
    { heartbeat :: p ('Struct "heartbeat")
    }
towerControllableVehicleStreams :: Tower e (ControllableVehicleStreams ChanInput, ControllableVehicleStreams ChanOutput)
towerControllableVehicleStreams = do
  heartbeat_c <- channel
  return ( ControllableVehicleStreams
           { heartbeat = fst heartbeat_c
           }
         , ControllableVehicleStreams
           { heartbeat = snd heartbeat_c
           }
         )
towerControllableVehicleServer :: ControllableVehicleConsumer
                               -> ControllableVehicleAttrs Attr
                               -> ControllableVehicleStreams ChanOutput
                               -> Tower e ControllableVehicleProducer
towerControllableVehicleServer ControllableVehicleConsumer{..} ControllableVehicleAttrs{..} ControllableVehicleStreams{..} = do
  rebootReqSetRespProducer <- writableAttrServer SequenceNumberedRebootReq.val SequenceNumberedRebootReq.seqnum rebootReq rebootReqSetReqConsumer
  (nominalThrottleGetRespProducer, nominalThrottleSetRespProducer) <- readwritableAttrServer SequenceNumberedFloat.val SequenceNumberedFloat.seqnum nominalThrottle nominalThrottleGetReqConsumer nominalThrottleSetReqConsumer
  (altitudeRatePidGetRespProducer, altitudeRatePidSetRespProducer) <- readwritableAttrServer SequenceNumberedPidConfig.val SequenceNumberedPidConfig.seqnum altitudeRatePid altitudeRatePidGetReqConsumer altitudeRatePidSetReqConsumer
  (altitudePositionPidGetRespProducer, altitudePositionPidSetRespProducer) <- readwritableAttrServer SequenceNumberedPidConfig.val SequenceNumberedPidConfig.seqnum altitudePositionPid altitudePositionPidGetReqConsumer altitudePositionPidSetReqConsumer
  (throttleUiGetRespProducer, throttleUiSetRespProducer) <- readwritableAttrServer SequenceNumberedThrottleUi.val SequenceNumberedThrottleUi.seqnum throttleUi throttleUiGetReqConsumer throttleUiSetReqConsumer
  (attitudeRollStabGetRespProducer, attitudeRollStabSetRespProducer) <- readwritableAttrServer SequenceNumberedStabConfig.val SequenceNumberedStabConfig.seqnum attitudeRollStab attitudeRollStabGetReqConsumer attitudeRollStabSetReqConsumer
  (attitudePitchStabGetRespProducer, attitudePitchStabSetRespProducer) <- readwritableAttrServer SequenceNumberedStabConfig.val SequenceNumberedStabConfig.seqnum attitudePitchStab attitudePitchStabGetReqConsumer attitudePitchStabSetReqConsumer
  (yawRatePidGetRespProducer, yawRatePidSetRespProducer) <- readwritableAttrServer SequenceNumberedPidConfig.val SequenceNumberedPidConfig.seqnum yawRatePid yawRatePidGetReqConsumer yawRatePidSetReqConsumer
  (yawPositionPidGetRespProducer, yawPositionPidSetRespProducer) <- readwritableAttrServer SequenceNumberedPidConfig.val SequenceNumberedPidConfig.seqnum yawPositionPid yawPositionPidGetReqConsumer yawPositionPidSetReqConsumer
  (armingRequestGetRespProducer, armingRequestSetRespProducer) <- readwritableAttrServer SequenceNumberedTristate.val SequenceNumberedTristate.seqnum armingRequest armingRequestGetReqConsumer armingRequestSetReqConsumer
  (controlModesRequestGetRespProducer, controlModesRequestSetRespProducer) <- readwritableAttrServer SequenceNumberedControlModes.val SequenceNumberedControlModes.seqnum controlModesRequest controlModesRequestGetReqConsumer controlModesRequestSetReqConsumer
  (userInputRequestGetRespProducer, userInputRequestSetRespProducer) <- readwritableAttrServer SequenceNumberedUserInput.val SequenceNumberedUserInput.seqnum userInputRequest userInputRequestGetReqConsumer userInputRequestSetReqConsumer
  (rgbLedGetRespProducer, rgbLedSetRespProducer) <- readwritableAttrServer SequenceNumberedRgbLedSetting.val SequenceNumberedRgbLedSetting.seqnum rgbLed rgbLedGetReqConsumer rgbLedSetReqConsumer
  cameraTargetInputGetRespProducer <- readableAttrServer SequenceNumberedCameraTarget.val SequenceNumberedCameraTarget.seqnum cameraTargetInput cameraTargetInputGetReqConsumer
  let heartbeatProducer = heartbeat
  packedStatusGetRespProducer <- readableAttrServer SequenceNumberedPackedStatus.val SequenceNumberedPackedStatus.seqnum packedStatus packedStatusGetReqConsumer
  controlLawGetRespProducer <- readableAttrServer SequenceNumberedControlLaw.val SequenceNumberedControlLaw.seqnum controlLaw controlLawGetReqConsumer
  rcInputGetRespProducer <- readableAttrServer SequenceNumberedRcInput.val SequenceNumberedRcInput.seqnum rcInput rcInputGetReqConsumer
  userInputGetRespProducer <- readableAttrServer SequenceNumberedUserInputResult.val SequenceNumberedUserInputResult.seqnum userInput userInputGetReqConsumer
  sensorsOutputGetRespProducer <- readableAttrServer SequenceNumberedSensorsResult.val SequenceNumberedSensorsResult.seqnum sensorsOutput sensorsOutputGetReqConsumer
  gyroOutputGetRespProducer <- readableAttrServer SequenceNumberedGyroscopeSample.val SequenceNumberedGyroscopeSample.seqnum gyroOutput gyroOutputGetReqConsumer
  accelOutputGetRespProducer <- readableAttrServer SequenceNumberedAccelerometerSample.val SequenceNumberedAccelerometerSample.seqnum accelOutput accelOutputGetReqConsumer
  baroOutputGetRespProducer <- readableAttrServer SequenceNumberedBarometerSample.val SequenceNumberedBarometerSample.seqnum baroOutput baroOutputGetReqConsumer
  lidarliteOutputGetRespProducer <- readableAttrServer SequenceNumberedLidarliteSample.val SequenceNumberedLidarliteSample.seqnum lidarliteOutput lidarliteOutputGetReqConsumer
  magOutputGetRespProducer <- readableAttrServer SequenceNumberedMagnetometerSample.val SequenceNumberedMagnetometerSample.seqnum magOutput magOutputGetReqConsumer
  px4flowIntOutputGetRespProducer <- readableAttrServer SequenceNumberedPx4flowIntegralSample.val SequenceNumberedPx4flowIntegralSample.seqnum px4flowIntOutput px4flowIntOutputGetReqConsumer
  px4flowOutputGetRespProducer <- readableAttrServer SequenceNumberedPx4flowSample.val SequenceNumberedPx4flowSample.seqnum px4flowOutput px4flowOutputGetReqConsumer
  gpsOutputGetRespProducer <- readableAttrServer SequenceNumberedPositionSample.val SequenceNumberedPositionSample.seqnum gpsOutput gpsOutputGetReqConsumer
  controlSetpointGetRespProducer <- readableAttrServer SequenceNumberedControlSetpoint.val SequenceNumberedControlSetpoint.seqnum controlSetpoint controlSetpointGetReqConsumer
  controlOutputGetRespProducer <- readableAttrServer SequenceNumberedControlOutput.val SequenceNumberedControlOutput.seqnum controlOutput controlOutputGetReqConsumer
  motorOutputGetRespProducer <- readableAttrServer SequenceNumberedQuadcopterMotors.val SequenceNumberedQuadcopterMotors.seqnum motorOutput motorOutputGetReqConsumer
  attControlDebugGetRespProducer <- readableAttrServer SequenceNumberedAttControlDebug.val SequenceNumberedAttControlDebug.seqnum attControlDebug attControlDebugGetReqConsumer
  altControlDebugGetRespProducer <- readableAttrServer SequenceNumberedAltControlDebug.val SequenceNumberedAltControlDebug.seqnum altControlDebug altControlDebugGetReqConsumer
  px4ioStateGetRespProducer <- readableAttrServer SequenceNumberedPx4ioState.val SequenceNumberedPx4ioState.seqnum px4ioState px4ioStateGetReqConsumer
  armingStatusGetRespProducer <- readableAttrServer SequenceNumberedArmingStatus.val SequenceNumberedArmingStatus.seqnum armingStatus armingStatusGetReqConsumer
  batteryVoltageGetRespProducer <- readableAttrServer SequenceNumberedFloat.val SequenceNumberedFloat.seqnum batteryVoltage batteryVoltageGetReqConsumer
  return ControllableVehicleProducer{..}