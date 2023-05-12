{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
module SMACCMPilot.Comm.Tower.Interface.ControllableVehicle.Consumer where
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
import SMACCMPilot.Comm.Ivory.Types
import qualified SMACCMPilot.Comm.Ivory.Interface.ControllableVehicle.Consumer as I
import Ivory.Language
import Ivory.Stdlib
import Ivory.Tower
import Ivory.Serialize
-- Define Consumer schema for ControllableVehicle interface
data ControllableVehicleConsumer = ControllableVehicleConsumer
  { rebootReqSetReqConsumer :: ChanOutput ('Struct "sequence_numbered_reboot_req")
  , nominalThrottleSetReqConsumer :: ChanOutput ('Struct "sequence_numbered_float")
  , nominalThrottleGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , altitudeRatePidSetReqConsumer :: ChanOutput ('Struct "sequence_numbered_pid_config")
  , altitudeRatePidGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , altitudePositionPidSetReqConsumer :: ChanOutput ('Struct "sequence_numbered_pid_config")
  , altitudePositionPidGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , throttleUiSetReqConsumer :: ChanOutput ('Struct "sequence_numbered_throttle_ui")
  , throttleUiGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , attitudeRollStabSetReqConsumer :: ChanOutput ('Struct "sequence_numbered_stab_config")
  , attitudeRollStabGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , attitudePitchStabSetReqConsumer :: ChanOutput ('Struct "sequence_numbered_stab_config")
  , attitudePitchStabGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , yawRatePidSetReqConsumer :: ChanOutput ('Struct "sequence_numbered_pid_config")
  , yawRatePidGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , yawPositionPidSetReqConsumer :: ChanOutput ('Struct "sequence_numbered_pid_config")
  , yawPositionPidGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , armingRequestSetReqConsumer :: ChanOutput ('Struct "sequence_numbered_tristate")
  , armingRequestGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , controlModesRequestSetReqConsumer :: ChanOutput ('Struct "sequence_numbered_control_modes")
  , controlModesRequestGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , userInputRequestSetReqConsumer :: ChanOutput ('Struct "sequence_numbered_user_input")
  , userInputRequestGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , rgbLedSetReqConsumer :: ChanOutput ('Struct "sequence_numbered_rgb_led_setting")
  , rgbLedGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , cameraTargetInputGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , packedStatusGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , controlLawGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , rcInputGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , userInputGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , sensorsOutputGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , gyroOutputGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , accelOutputGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , baroOutputGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , lidarliteOutputGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , magOutputGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , px4flowIntOutputGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , px4flowOutputGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , gpsOutputGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , controlSetpointGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , controlOutputGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , motorOutputGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , attControlDebugGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , altControlDebugGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , px4ioStateGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , armingStatusGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , batteryVoltageGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  }
controllableVehicleConsumerInput :: (ANat n)
                                 => ChanOutput ('Array n ('Stored Uint8))
                                 -> Tower e ControllableVehicleConsumer
controllableVehicleConsumerInput frame_ch = do
  towerModule serializeModule
  mapM_ towerArtifact serializeArtifacts
  mapM_ towerModule typeModules
  mapM_ towerDepends typeModules
  ch_reboot_req_set_req <- channel
  ch_nominal_throttle_set_req <- channel
  ch_nominal_throttle_get_req <- channel
  ch_altitude_rate_pid_set_req <- channel
  ch_altitude_rate_pid_get_req <- channel
  ch_altitude_position_pid_set_req <- channel
  ch_altitude_position_pid_get_req <- channel
  ch_throttle_ui_set_req <- channel
  ch_throttle_ui_get_req <- channel
  ch_attitude_roll_stab_set_req <- channel
  ch_attitude_roll_stab_get_req <- channel
  ch_attitude_pitch_stab_set_req <- channel
  ch_attitude_pitch_stab_get_req <- channel
  ch_yaw_rate_pid_set_req <- channel
  ch_yaw_rate_pid_get_req <- channel
  ch_yaw_position_pid_set_req <- channel
  ch_yaw_position_pid_get_req <- channel
  ch_arming_request_set_req <- channel
  ch_arming_request_get_req <- channel
  ch_control_modes_request_set_req <- channel
  ch_control_modes_request_get_req <- channel
  ch_user_input_request_set_req <- channel
  ch_user_input_request_get_req <- channel
  ch_rgb_led_set_req <- channel
  ch_rgb_led_get_req <- channel
  ch_camera_target_input_get_req <- channel
  ch_packed_status_get_req <- channel
  ch_control_law_get_req <- channel
  ch_rc_input_get_req <- channel
  ch_user_input_get_req <- channel
  ch_sensors_output_get_req <- channel
  ch_gyro_output_get_req <- channel
  ch_accel_output_get_req <- channel
  ch_baro_output_get_req <- channel
  ch_lidarlite_output_get_req <- channel
  ch_mag_output_get_req <- channel
  ch_px4flow_int_output_get_req <- channel
  ch_px4flow_output_get_req <- channel
  ch_gps_output_get_req <- channel
  ch_control_setpoint_get_req <- channel
  ch_control_output_get_req <- channel
  ch_motor_output_get_req <- channel
  ch_att_control_debug_get_req <- channel
  ch_alt_control_debug_get_req <- channel
  ch_px4io_state_get_req <- channel
  ch_arming_status_get_req <- channel
  ch_battery_voltage_get_req <- channel
  monitor "controllableVehicleConsumerOutput" $ do
    handler frame_ch "parse_frame" $ do
      emitter_reboot_req_set_req <- emitter (fst ch_reboot_req_set_req) 1
      emitter_nominal_throttle_set_req <- emitter (fst ch_nominal_throttle_set_req) 1
      emitter_nominal_throttle_get_req <- emitter (fst ch_nominal_throttle_get_req) 1
      emitter_altitude_rate_pid_set_req <- emitter (fst ch_altitude_rate_pid_set_req) 1
      emitter_altitude_rate_pid_get_req <- emitter (fst ch_altitude_rate_pid_get_req) 1
      emitter_altitude_position_pid_set_req <- emitter (fst ch_altitude_position_pid_set_req) 1
      emitter_altitude_position_pid_get_req <- emitter (fst ch_altitude_position_pid_get_req) 1
      emitter_throttle_ui_set_req <- emitter (fst ch_throttle_ui_set_req) 1
      emitter_throttle_ui_get_req <- emitter (fst ch_throttle_ui_get_req) 1
      emitter_attitude_roll_stab_set_req <- emitter (fst ch_attitude_roll_stab_set_req) 1
      emitter_attitude_roll_stab_get_req <- emitter (fst ch_attitude_roll_stab_get_req) 1
      emitter_attitude_pitch_stab_set_req <- emitter (fst ch_attitude_pitch_stab_set_req) 1
      emitter_attitude_pitch_stab_get_req <- emitter (fst ch_attitude_pitch_stab_get_req) 1
      emitter_yaw_rate_pid_set_req <- emitter (fst ch_yaw_rate_pid_set_req) 1
      emitter_yaw_rate_pid_get_req <- emitter (fst ch_yaw_rate_pid_get_req) 1
      emitter_yaw_position_pid_set_req <- emitter (fst ch_yaw_position_pid_set_req) 1
      emitter_yaw_position_pid_get_req <- emitter (fst ch_yaw_position_pid_get_req) 1
      emitter_arming_request_set_req <- emitter (fst ch_arming_request_set_req) 1
      emitter_arming_request_get_req <- emitter (fst ch_arming_request_get_req) 1
      emitter_control_modes_request_set_req <- emitter (fst ch_control_modes_request_set_req) 1
      emitter_control_modes_request_get_req <- emitter (fst ch_control_modes_request_get_req) 1
      emitter_user_input_request_set_req <- emitter (fst ch_user_input_request_set_req) 1
      emitter_user_input_request_get_req <- emitter (fst ch_user_input_request_get_req) 1
      emitter_rgb_led_set_req <- emitter (fst ch_rgb_led_set_req) 1
      emitter_rgb_led_get_req <- emitter (fst ch_rgb_led_get_req) 1
      emitter_camera_target_input_get_req <- emitter (fst ch_camera_target_input_get_req) 1
      emitter_packed_status_get_req <- emitter (fst ch_packed_status_get_req) 1
      emitter_control_law_get_req <- emitter (fst ch_control_law_get_req) 1
      emitter_rc_input_get_req <- emitter (fst ch_rc_input_get_req) 1
      emitter_user_input_get_req <- emitter (fst ch_user_input_get_req) 1
      emitter_sensors_output_get_req <- emitter (fst ch_sensors_output_get_req) 1
      emitter_gyro_output_get_req <- emitter (fst ch_gyro_output_get_req) 1
      emitter_accel_output_get_req <- emitter (fst ch_accel_output_get_req) 1
      emitter_baro_output_get_req <- emitter (fst ch_baro_output_get_req) 1
      emitter_lidarlite_output_get_req <- emitter (fst ch_lidarlite_output_get_req) 1
      emitter_mag_output_get_req <- emitter (fst ch_mag_output_get_req) 1
      emitter_px4flow_int_output_get_req <- emitter (fst ch_px4flow_int_output_get_req) 1
      emitter_px4flow_output_get_req <- emitter (fst ch_px4flow_output_get_req) 1
      emitter_gps_output_get_req <- emitter (fst ch_gps_output_get_req) 1
      emitter_control_setpoint_get_req <- emitter (fst ch_control_setpoint_get_req) 1
      emitter_control_output_get_req <- emitter (fst ch_control_output_get_req) 1
      emitter_motor_output_get_req <- emitter (fst ch_motor_output_get_req) 1
      emitter_att_control_debug_get_req <- emitter (fst ch_att_control_debug_get_req) 1
      emitter_alt_control_debug_get_req <- emitter (fst ch_alt_control_debug_get_req) 1
      emitter_px4io_state_get_req <- emitter (fst ch_px4io_state_get_req) 1
      emitter_arming_status_get_req <- emitter (fst ch_arming_status_get_req) 1
      emitter_battery_voltage_get_req <- emitter (fst ch_battery_voltage_get_req) 1
      callback $ \f -> do
        offs <- local izero
        _ <- I.controllableVehicleConsumerParser f offs $ I.ControllableVehicleConsumer
          { I.rebootReqSetReqConsumer = \v -> emit emitter_reboot_req_set_req v >> return true
          , I.nominalThrottleSetReqConsumer = \v -> emit emitter_nominal_throttle_set_req v >> return true
          , I.nominalThrottleGetReqConsumer = \v -> emit emitter_nominal_throttle_get_req v >> return true
          , I.altitudeRatePidSetReqConsumer = \v -> emit emitter_altitude_rate_pid_set_req v >> return true
          , I.altitudeRatePidGetReqConsumer = \v -> emit emitter_altitude_rate_pid_get_req v >> return true
          , I.altitudePositionPidSetReqConsumer = \v -> emit emitter_altitude_position_pid_set_req v >> return true
          , I.altitudePositionPidGetReqConsumer = \v -> emit emitter_altitude_position_pid_get_req v >> return true
          , I.throttleUiSetReqConsumer = \v -> emit emitter_throttle_ui_set_req v >> return true
          , I.throttleUiGetReqConsumer = \v -> emit emitter_throttle_ui_get_req v >> return true
          , I.attitudeRollStabSetReqConsumer = \v -> emit emitter_attitude_roll_stab_set_req v >> return true
          , I.attitudeRollStabGetReqConsumer = \v -> emit emitter_attitude_roll_stab_get_req v >> return true
          , I.attitudePitchStabSetReqConsumer = \v -> emit emitter_attitude_pitch_stab_set_req v >> return true
          , I.attitudePitchStabGetReqConsumer = \v -> emit emitter_attitude_pitch_stab_get_req v >> return true
          , I.yawRatePidSetReqConsumer = \v -> emit emitter_yaw_rate_pid_set_req v >> return true
          , I.yawRatePidGetReqConsumer = \v -> emit emitter_yaw_rate_pid_get_req v >> return true
          , I.yawPositionPidSetReqConsumer = \v -> emit emitter_yaw_position_pid_set_req v >> return true
          , I.yawPositionPidGetReqConsumer = \v -> emit emitter_yaw_position_pid_get_req v >> return true
          , I.armingRequestSetReqConsumer = \v -> emit emitter_arming_request_set_req v >> return true
          , I.armingRequestGetReqConsumer = \v -> emit emitter_arming_request_get_req v >> return true
          , I.controlModesRequestSetReqConsumer = \v -> emit emitter_control_modes_request_set_req v >> return true
          , I.controlModesRequestGetReqConsumer = \v -> emit emitter_control_modes_request_get_req v >> return true
          , I.userInputRequestSetReqConsumer = \v -> emit emitter_user_input_request_set_req v >> return true
          , I.userInputRequestGetReqConsumer = \v -> emit emitter_user_input_request_get_req v >> return true
          , I.rgbLedSetReqConsumer = \v -> emit emitter_rgb_led_set_req v >> return true
          , I.rgbLedGetReqConsumer = \v -> emit emitter_rgb_led_get_req v >> return true
          , I.cameraTargetInputGetReqConsumer = \v -> emit emitter_camera_target_input_get_req v >> return true
          , I.packedStatusGetReqConsumer = \v -> emit emitter_packed_status_get_req v >> return true
          , I.controlLawGetReqConsumer = \v -> emit emitter_control_law_get_req v >> return true
          , I.rcInputGetReqConsumer = \v -> emit emitter_rc_input_get_req v >> return true
          , I.userInputGetReqConsumer = \v -> emit emitter_user_input_get_req v >> return true
          , I.sensorsOutputGetReqConsumer = \v -> emit emitter_sensors_output_get_req v >> return true
          , I.gyroOutputGetReqConsumer = \v -> emit emitter_gyro_output_get_req v >> return true
          , I.accelOutputGetReqConsumer = \v -> emit emitter_accel_output_get_req v >> return true
          , I.baroOutputGetReqConsumer = \v -> emit emitter_baro_output_get_req v >> return true
          , I.lidarliteOutputGetReqConsumer = \v -> emit emitter_lidarlite_output_get_req v >> return true
          , I.magOutputGetReqConsumer = \v -> emit emitter_mag_output_get_req v >> return true
          , I.px4flowIntOutputGetReqConsumer = \v -> emit emitter_px4flow_int_output_get_req v >> return true
          , I.px4flowOutputGetReqConsumer = \v -> emit emitter_px4flow_output_get_req v >> return true
          , I.gpsOutputGetReqConsumer = \v -> emit emitter_gps_output_get_req v >> return true
          , I.controlSetpointGetReqConsumer = \v -> emit emitter_control_setpoint_get_req v >> return true
          , I.controlOutputGetReqConsumer = \v -> emit emitter_control_output_get_req v >> return true
          , I.motorOutputGetReqConsumer = \v -> emit emitter_motor_output_get_req v >> return true
          , I.attControlDebugGetReqConsumer = \v -> emit emitter_att_control_debug_get_req v >> return true
          , I.altControlDebugGetReqConsumer = \v -> emit emitter_alt_control_debug_get_req v >> return true
          , I.px4ioStateGetReqConsumer = \v -> emit emitter_px4io_state_get_req v >> return true
          , I.armingStatusGetReqConsumer = \v -> emit emitter_arming_status_get_req v >> return true
          , I.batteryVoltageGetReqConsumer = \v -> emit emitter_battery_voltage_get_req v >> return true
          }
        return ()
  return ControllableVehicleConsumer { rebootReqSetReqConsumer = (snd ch_reboot_req_set_req)
                                     , nominalThrottleSetReqConsumer = (snd ch_nominal_throttle_set_req)
                                     , nominalThrottleGetReqConsumer = (snd ch_nominal_throttle_get_req)
                                     , altitudeRatePidSetReqConsumer = (snd ch_altitude_rate_pid_set_req)
                                     , altitudeRatePidGetReqConsumer = (snd ch_altitude_rate_pid_get_req)
                                     , altitudePositionPidSetReqConsumer = (snd ch_altitude_position_pid_set_req)
                                     , altitudePositionPidGetReqConsumer = (snd ch_altitude_position_pid_get_req)
                                     , throttleUiSetReqConsumer = (snd ch_throttle_ui_set_req)
                                     , throttleUiGetReqConsumer = (snd ch_throttle_ui_get_req)
                                     , attitudeRollStabSetReqConsumer = (snd ch_attitude_roll_stab_set_req)
                                     , attitudeRollStabGetReqConsumer = (snd ch_attitude_roll_stab_get_req)
                                     , attitudePitchStabSetReqConsumer = (snd ch_attitude_pitch_stab_set_req)
                                     , attitudePitchStabGetReqConsumer = (snd ch_attitude_pitch_stab_get_req)
                                     , yawRatePidSetReqConsumer = (snd ch_yaw_rate_pid_set_req)
                                     , yawRatePidGetReqConsumer = (snd ch_yaw_rate_pid_get_req)
                                     , yawPositionPidSetReqConsumer = (snd ch_yaw_position_pid_set_req)
                                     , yawPositionPidGetReqConsumer = (snd ch_yaw_position_pid_get_req)
                                     , armingRequestSetReqConsumer = (snd ch_arming_request_set_req)
                                     , armingRequestGetReqConsumer = (snd ch_arming_request_get_req)
                                     , controlModesRequestSetReqConsumer = (snd ch_control_modes_request_set_req)
                                     , controlModesRequestGetReqConsumer = (snd ch_control_modes_request_get_req)
                                     , userInputRequestSetReqConsumer = (snd ch_user_input_request_set_req)
                                     , userInputRequestGetReqConsumer = (snd ch_user_input_request_get_req)
                                     , rgbLedSetReqConsumer = (snd ch_rgb_led_set_req)
                                     , rgbLedGetReqConsumer = (snd ch_rgb_led_get_req)
                                     , cameraTargetInputGetReqConsumer = (snd ch_camera_target_input_get_req)
                                     , packedStatusGetReqConsumer = (snd ch_packed_status_get_req)
                                     , controlLawGetReqConsumer = (snd ch_control_law_get_req)
                                     , rcInputGetReqConsumer = (snd ch_rc_input_get_req)
                                     , userInputGetReqConsumer = (snd ch_user_input_get_req)
                                     , sensorsOutputGetReqConsumer = (snd ch_sensors_output_get_req)
                                     , gyroOutputGetReqConsumer = (snd ch_gyro_output_get_req)
                                     , accelOutputGetReqConsumer = (snd ch_accel_output_get_req)
                                     , baroOutputGetReqConsumer = (snd ch_baro_output_get_req)
                                     , lidarliteOutputGetReqConsumer = (snd ch_lidarlite_output_get_req)
                                     , magOutputGetReqConsumer = (snd ch_mag_output_get_req)
                                     , px4flowIntOutputGetReqConsumer = (snd ch_px4flow_int_output_get_req)
                                     , px4flowOutputGetReqConsumer = (snd ch_px4flow_output_get_req)
                                     , gpsOutputGetReqConsumer = (snd ch_gps_output_get_req)
                                     , controlSetpointGetReqConsumer = (snd ch_control_setpoint_get_req)
                                     , controlOutputGetReqConsumer = (snd ch_control_output_get_req)
                                     , motorOutputGetReqConsumer = (snd ch_motor_output_get_req)
                                     , attControlDebugGetReqConsumer = (snd ch_att_control_debug_get_req)
                                     , altControlDebugGetReqConsumer = (snd ch_alt_control_debug_get_req)
                                     , px4ioStateGetReqConsumer = (snd ch_px4io_state_get_req)
                                     , armingStatusGetReqConsumer = (snd ch_arming_status_get_req)
                                     , batteryVoltageGetReqConsumer = (snd ch_battery_voltage_get_req)
                                     }
controllableVehicleConsumerOutput:: (ANat n)
                                 => ControllableVehicleConsumer
                                 -> Tower e (ChanOutput ('Array n ('Stored Uint8)))
controllableVehicleConsumerOutput a = do
  towerModule serializeModule
  mapM_ towerArtifact serializeArtifacts
  mapM_ towerModule typeModules
  mapM_ towerDepends typeModules
  frame_ch <- channel
  monitor "controllableVehicleConsumerInput" $ do
    handler (rebootReqSetReqConsumer a) "rebootReqSetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.rebootReqSetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (nominalThrottleSetReqConsumer a) "nominalThrottleSetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.nominalThrottleSetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (nominalThrottleGetReqConsumer a) "nominalThrottleGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.nominalThrottleGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (altitudeRatePidSetReqConsumer a) "altitudeRatePidSetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.altitudeRatePidSetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (altitudeRatePidGetReqConsumer a) "altitudeRatePidGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.altitudeRatePidGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (altitudePositionPidSetReqConsumer a) "altitudePositionPidSetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.altitudePositionPidSetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (altitudePositionPidGetReqConsumer a) "altitudePositionPidGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.altitudePositionPidGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (throttleUiSetReqConsumer a) "throttleUiSetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.throttleUiSetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (throttleUiGetReqConsumer a) "throttleUiGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.throttleUiGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (attitudeRollStabSetReqConsumer a) "attitudeRollStabSetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.attitudeRollStabSetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (attitudeRollStabGetReqConsumer a) "attitudeRollStabGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.attitudeRollStabGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (attitudePitchStabSetReqConsumer a) "attitudePitchStabSetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.attitudePitchStabSetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (attitudePitchStabGetReqConsumer a) "attitudePitchStabGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.attitudePitchStabGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (yawRatePidSetReqConsumer a) "yawRatePidSetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.yawRatePidSetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (yawRatePidGetReqConsumer a) "yawRatePidGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.yawRatePidGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (yawPositionPidSetReqConsumer a) "yawPositionPidSetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.yawPositionPidSetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (yawPositionPidGetReqConsumer a) "yawPositionPidGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.yawPositionPidGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (armingRequestSetReqConsumer a) "armingRequestSetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.armingRequestSetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (armingRequestGetReqConsumer a) "armingRequestGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.armingRequestGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (controlModesRequestSetReqConsumer a) "controlModesRequestSetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.controlModesRequestSetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (controlModesRequestGetReqConsumer a) "controlModesRequestGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.controlModesRequestGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (userInputRequestSetReqConsumer a) "userInputRequestSetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.userInputRequestSetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (userInputRequestGetReqConsumer a) "userInputRequestGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.userInputRequestGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (rgbLedSetReqConsumer a) "rgbLedSetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.rgbLedSetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (rgbLedGetReqConsumer a) "rgbLedGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.rgbLedGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (cameraTargetInputGetReqConsumer a) "cameraTargetInputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.cameraTargetInputGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (packedStatusGetReqConsumer a) "packedStatusGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.packedStatusGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (controlLawGetReqConsumer a) "controlLawGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.controlLawGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (rcInputGetReqConsumer a) "rcInputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.rcInputGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (userInputGetReqConsumer a) "userInputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.userInputGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (sensorsOutputGetReqConsumer a) "sensorsOutputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.sensorsOutputGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (gyroOutputGetReqConsumer a) "gyroOutputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.gyroOutputGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (accelOutputGetReqConsumer a) "accelOutputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.accelOutputGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (baroOutputGetReqConsumer a) "baroOutputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.baroOutputGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (lidarliteOutputGetReqConsumer a) "lidarliteOutputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.lidarliteOutputGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (magOutputGetReqConsumer a) "magOutputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.magOutputGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (px4flowIntOutputGetReqConsumer a) "px4flowIntOutputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.px4flowIntOutputGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (px4flowOutputGetReqConsumer a) "px4flowOutputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.px4flowOutputGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (gpsOutputGetReqConsumer a) "gpsOutputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.gpsOutputGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (controlSetpointGetReqConsumer a) "controlSetpointGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.controlSetpointGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (controlOutputGetReqConsumer a) "controlOutputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.controlOutputGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (motorOutputGetReqConsumer a) "motorOutputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.motorOutputGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (attControlDebugGetReqConsumer a) "attControlDebugGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.attControlDebugGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (altControlDebugGetReqConsumer a) "altControlDebugGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.altControlDebugGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (px4ioStateGetReqConsumer a) "px4ioStateGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.px4ioStateGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (armingStatusGetReqConsumer a) "armingStatusGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.armingStatusGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (batteryVoltageGetReqConsumer a) "batteryVoltageGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.batteryVoltageGetReqConsumer (I.controllableVehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
  return (snd frame_ch)