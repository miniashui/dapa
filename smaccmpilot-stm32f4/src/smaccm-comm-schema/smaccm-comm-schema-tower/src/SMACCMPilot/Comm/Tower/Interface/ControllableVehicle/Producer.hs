{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
module SMACCMPilot.Comm.Tower.Interface.ControllableVehicle.Producer where
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
import qualified SMACCMPilot.Comm.Ivory.Interface.ControllableVehicle.Producer as I
import Ivory.Language
import Ivory.Stdlib
import Ivory.Tower
import Ivory.Serialize
-- Define Producer schema for ControllableVehicle interface
data ControllableVehicleProducer = ControllableVehicleProducer
  { rebootReqSetRespProducer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , nominalThrottleSetRespProducer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , nominalThrottleGetRespProducer :: ChanOutput ('Struct "sequence_numbered_float")
  , altitudeRatePidSetRespProducer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , altitudeRatePidGetRespProducer :: ChanOutput ('Struct "sequence_numbered_pid_config")
  , altitudePositionPidSetRespProducer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , altitudePositionPidGetRespProducer :: ChanOutput ('Struct "sequence_numbered_pid_config")
  , throttleUiSetRespProducer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , throttleUiGetRespProducer :: ChanOutput ('Struct "sequence_numbered_throttle_ui")
  , attitudeRollStabSetRespProducer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , attitudeRollStabGetRespProducer :: ChanOutput ('Struct "sequence_numbered_stab_config")
  , attitudePitchStabSetRespProducer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , attitudePitchStabGetRespProducer :: ChanOutput ('Struct "sequence_numbered_stab_config")
  , yawRatePidSetRespProducer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , yawRatePidGetRespProducer :: ChanOutput ('Struct "sequence_numbered_pid_config")
  , yawPositionPidSetRespProducer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , yawPositionPidGetRespProducer :: ChanOutput ('Struct "sequence_numbered_pid_config")
  , armingRequestSetRespProducer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , armingRequestGetRespProducer :: ChanOutput ('Struct "sequence_numbered_tristate")
  , controlModesRequestSetRespProducer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , controlModesRequestGetRespProducer :: ChanOutput ('Struct "sequence_numbered_control_modes")
  , userInputRequestSetRespProducer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , userInputRequestGetRespProducer :: ChanOutput ('Struct "sequence_numbered_user_input")
  , rgbLedSetRespProducer :: ChanOutput ('Stored SequenceNum.SequenceNum)
  , rgbLedGetRespProducer :: ChanOutput ('Struct "sequence_numbered_rgb_led_setting")
  , cameraTargetInputGetRespProducer :: ChanOutput ('Struct "sequence_numbered_camera_target")
  , heartbeatProducer :: ChanOutput ('Struct "heartbeat")
  , packedStatusGetRespProducer :: ChanOutput ('Struct "sequence_numbered_packed_status")
  , controlLawGetRespProducer :: ChanOutput ('Struct "sequence_numbered_control_law")
  , rcInputGetRespProducer :: ChanOutput ('Struct "sequence_numbered_rc_input")
  , userInputGetRespProducer :: ChanOutput ('Struct "sequence_numbered_user_input_result")
  , sensorsOutputGetRespProducer :: ChanOutput ('Struct "sequence_numbered_sensors_result")
  , gyroOutputGetRespProducer :: ChanOutput ('Struct "sequence_numbered_gyroscope_sample")
  , accelOutputGetRespProducer :: ChanOutput ('Struct "sequence_numbered_accelerometer_sample")
  , baroOutputGetRespProducer :: ChanOutput ('Struct "sequence_numbered_barometer_sample")
  , lidarliteOutputGetRespProducer :: ChanOutput ('Struct "sequence_numbered_lidarlite_sample")
  , magOutputGetRespProducer :: ChanOutput ('Struct "sequence_numbered_magnetometer_sample")
  , px4flowIntOutputGetRespProducer :: ChanOutput ('Struct "sequence_numbered_px4flow_integral_sample")
  , px4flowOutputGetRespProducer :: ChanOutput ('Struct "sequence_numbered_px4flow_sample")
  , gpsOutputGetRespProducer :: ChanOutput ('Struct "sequence_numbered_position_sample")
  , controlSetpointGetRespProducer :: ChanOutput ('Struct "sequence_numbered_control_setpoint")
  , controlOutputGetRespProducer :: ChanOutput ('Struct "sequence_numbered_control_output")
  , motorOutputGetRespProducer :: ChanOutput ('Struct "sequence_numbered_quadcopter_motors")
  , attControlDebugGetRespProducer :: ChanOutput ('Struct "sequence_numbered_att_control_debug")
  , altControlDebugGetRespProducer :: ChanOutput ('Struct "sequence_numbered_alt_control_debug")
  , px4ioStateGetRespProducer :: ChanOutput ('Struct "sequence_numbered_px4io_state")
  , armingStatusGetRespProducer :: ChanOutput ('Struct "sequence_numbered_arming_status")
  , batteryVoltageGetRespProducer :: ChanOutput ('Struct "sequence_numbered_float")
  }
controllableVehicleProducerInput :: (ANat n)
                                 => ChanOutput ('Array n ('Stored Uint8))
                                 -> Tower e ControllableVehicleProducer
controllableVehicleProducerInput frame_ch = do
  towerModule serializeModule
  mapM_ towerArtifact serializeArtifacts
  mapM_ towerModule typeModules
  mapM_ towerDepends typeModules
  ch_reboot_req_set_resp <- channel
  ch_nominal_throttle_set_resp <- channel
  ch_nominal_throttle_get_resp <- channel
  ch_altitude_rate_pid_set_resp <- channel
  ch_altitude_rate_pid_get_resp <- channel
  ch_altitude_position_pid_set_resp <- channel
  ch_altitude_position_pid_get_resp <- channel
  ch_throttle_ui_set_resp <- channel
  ch_throttle_ui_get_resp <- channel
  ch_attitude_roll_stab_set_resp <- channel
  ch_attitude_roll_stab_get_resp <- channel
  ch_attitude_pitch_stab_set_resp <- channel
  ch_attitude_pitch_stab_get_resp <- channel
  ch_yaw_rate_pid_set_resp <- channel
  ch_yaw_rate_pid_get_resp <- channel
  ch_yaw_position_pid_set_resp <- channel
  ch_yaw_position_pid_get_resp <- channel
  ch_arming_request_set_resp <- channel
  ch_arming_request_get_resp <- channel
  ch_control_modes_request_set_resp <- channel
  ch_control_modes_request_get_resp <- channel
  ch_user_input_request_set_resp <- channel
  ch_user_input_request_get_resp <- channel
  ch_rgb_led_set_resp <- channel
  ch_rgb_led_get_resp <- channel
  ch_camera_target_input_get_resp <- channel
  ch_heartbeat <- channel
  ch_packed_status_get_resp <- channel
  ch_control_law_get_resp <- channel
  ch_rc_input_get_resp <- channel
  ch_user_input_get_resp <- channel
  ch_sensors_output_get_resp <- channel
  ch_gyro_output_get_resp <- channel
  ch_accel_output_get_resp <- channel
  ch_baro_output_get_resp <- channel
  ch_lidarlite_output_get_resp <- channel
  ch_mag_output_get_resp <- channel
  ch_px4flow_int_output_get_resp <- channel
  ch_px4flow_output_get_resp <- channel
  ch_gps_output_get_resp <- channel
  ch_control_setpoint_get_resp <- channel
  ch_control_output_get_resp <- channel
  ch_motor_output_get_resp <- channel
  ch_att_control_debug_get_resp <- channel
  ch_alt_control_debug_get_resp <- channel
  ch_px4io_state_get_resp <- channel
  ch_arming_status_get_resp <- channel
  ch_battery_voltage_get_resp <- channel
  monitor "controllableVehicleProducerOutput" $ do
    handler frame_ch "parse_frame" $ do
      emitter_reboot_req_set_resp <- emitter (fst ch_reboot_req_set_resp) 1
      emitter_nominal_throttle_set_resp <- emitter (fst ch_nominal_throttle_set_resp) 1
      emitter_nominal_throttle_get_resp <- emitter (fst ch_nominal_throttle_get_resp) 1
      emitter_altitude_rate_pid_set_resp <- emitter (fst ch_altitude_rate_pid_set_resp) 1
      emitter_altitude_rate_pid_get_resp <- emitter (fst ch_altitude_rate_pid_get_resp) 1
      emitter_altitude_position_pid_set_resp <- emitter (fst ch_altitude_position_pid_set_resp) 1
      emitter_altitude_position_pid_get_resp <- emitter (fst ch_altitude_position_pid_get_resp) 1
      emitter_throttle_ui_set_resp <- emitter (fst ch_throttle_ui_set_resp) 1
      emitter_throttle_ui_get_resp <- emitter (fst ch_throttle_ui_get_resp) 1
      emitter_attitude_roll_stab_set_resp <- emitter (fst ch_attitude_roll_stab_set_resp) 1
      emitter_attitude_roll_stab_get_resp <- emitter (fst ch_attitude_roll_stab_get_resp) 1
      emitter_attitude_pitch_stab_set_resp <- emitter (fst ch_attitude_pitch_stab_set_resp) 1
      emitter_attitude_pitch_stab_get_resp <- emitter (fst ch_attitude_pitch_stab_get_resp) 1
      emitter_yaw_rate_pid_set_resp <- emitter (fst ch_yaw_rate_pid_set_resp) 1
      emitter_yaw_rate_pid_get_resp <- emitter (fst ch_yaw_rate_pid_get_resp) 1
      emitter_yaw_position_pid_set_resp <- emitter (fst ch_yaw_position_pid_set_resp) 1
      emitter_yaw_position_pid_get_resp <- emitter (fst ch_yaw_position_pid_get_resp) 1
      emitter_arming_request_set_resp <- emitter (fst ch_arming_request_set_resp) 1
      emitter_arming_request_get_resp <- emitter (fst ch_arming_request_get_resp) 1
      emitter_control_modes_request_set_resp <- emitter (fst ch_control_modes_request_set_resp) 1
      emitter_control_modes_request_get_resp <- emitter (fst ch_control_modes_request_get_resp) 1
      emitter_user_input_request_set_resp <- emitter (fst ch_user_input_request_set_resp) 1
      emitter_user_input_request_get_resp <- emitter (fst ch_user_input_request_get_resp) 1
      emitter_rgb_led_set_resp <- emitter (fst ch_rgb_led_set_resp) 1
      emitter_rgb_led_get_resp <- emitter (fst ch_rgb_led_get_resp) 1
      emitter_camera_target_input_get_resp <- emitter (fst ch_camera_target_input_get_resp) 1
      emitter_heartbeat <- emitter (fst ch_heartbeat) 1
      emitter_packed_status_get_resp <- emitter (fst ch_packed_status_get_resp) 1
      emitter_control_law_get_resp <- emitter (fst ch_control_law_get_resp) 1
      emitter_rc_input_get_resp <- emitter (fst ch_rc_input_get_resp) 1
      emitter_user_input_get_resp <- emitter (fst ch_user_input_get_resp) 1
      emitter_sensors_output_get_resp <- emitter (fst ch_sensors_output_get_resp) 1
      emitter_gyro_output_get_resp <- emitter (fst ch_gyro_output_get_resp) 1
      emitter_accel_output_get_resp <- emitter (fst ch_accel_output_get_resp) 1
      emitter_baro_output_get_resp <- emitter (fst ch_baro_output_get_resp) 1
      emitter_lidarlite_output_get_resp <- emitter (fst ch_lidarlite_output_get_resp) 1
      emitter_mag_output_get_resp <- emitter (fst ch_mag_output_get_resp) 1
      emitter_px4flow_int_output_get_resp <- emitter (fst ch_px4flow_int_output_get_resp) 1
      emitter_px4flow_output_get_resp <- emitter (fst ch_px4flow_output_get_resp) 1
      emitter_gps_output_get_resp <- emitter (fst ch_gps_output_get_resp) 1
      emitter_control_setpoint_get_resp <- emitter (fst ch_control_setpoint_get_resp) 1
      emitter_control_output_get_resp <- emitter (fst ch_control_output_get_resp) 1
      emitter_motor_output_get_resp <- emitter (fst ch_motor_output_get_resp) 1
      emitter_att_control_debug_get_resp <- emitter (fst ch_att_control_debug_get_resp) 1
      emitter_alt_control_debug_get_resp <- emitter (fst ch_alt_control_debug_get_resp) 1
      emitter_px4io_state_get_resp <- emitter (fst ch_px4io_state_get_resp) 1
      emitter_arming_status_get_resp <- emitter (fst ch_arming_status_get_resp) 1
      emitter_battery_voltage_get_resp <- emitter (fst ch_battery_voltage_get_resp) 1
      callback $ \f -> do
        offs <- local izero
        _ <- I.controllableVehicleProducerParser f offs $ I.ControllableVehicleProducer
          { I.rebootReqSetRespProducer = \v -> emit emitter_reboot_req_set_resp v >> return true
          , I.nominalThrottleSetRespProducer = \v -> emit emitter_nominal_throttle_set_resp v >> return true
          , I.nominalThrottleGetRespProducer = \v -> emit emitter_nominal_throttle_get_resp v >> return true
          , I.altitudeRatePidSetRespProducer = \v -> emit emitter_altitude_rate_pid_set_resp v >> return true
          , I.altitudeRatePidGetRespProducer = \v -> emit emitter_altitude_rate_pid_get_resp v >> return true
          , I.altitudePositionPidSetRespProducer = \v -> emit emitter_altitude_position_pid_set_resp v >> return true
          , I.altitudePositionPidGetRespProducer = \v -> emit emitter_altitude_position_pid_get_resp v >> return true
          , I.throttleUiSetRespProducer = \v -> emit emitter_throttle_ui_set_resp v >> return true
          , I.throttleUiGetRespProducer = \v -> emit emitter_throttle_ui_get_resp v >> return true
          , I.attitudeRollStabSetRespProducer = \v -> emit emitter_attitude_roll_stab_set_resp v >> return true
          , I.attitudeRollStabGetRespProducer = \v -> emit emitter_attitude_roll_stab_get_resp v >> return true
          , I.attitudePitchStabSetRespProducer = \v -> emit emitter_attitude_pitch_stab_set_resp v >> return true
          , I.attitudePitchStabGetRespProducer = \v -> emit emitter_attitude_pitch_stab_get_resp v >> return true
          , I.yawRatePidSetRespProducer = \v -> emit emitter_yaw_rate_pid_set_resp v >> return true
          , I.yawRatePidGetRespProducer = \v -> emit emitter_yaw_rate_pid_get_resp v >> return true
          , I.yawPositionPidSetRespProducer = \v -> emit emitter_yaw_position_pid_set_resp v >> return true
          , I.yawPositionPidGetRespProducer = \v -> emit emitter_yaw_position_pid_get_resp v >> return true
          , I.armingRequestSetRespProducer = \v -> emit emitter_arming_request_set_resp v >> return true
          , I.armingRequestGetRespProducer = \v -> emit emitter_arming_request_get_resp v >> return true
          , I.controlModesRequestSetRespProducer = \v -> emit emitter_control_modes_request_set_resp v >> return true
          , I.controlModesRequestGetRespProducer = \v -> emit emitter_control_modes_request_get_resp v >> return true
          , I.userInputRequestSetRespProducer = \v -> emit emitter_user_input_request_set_resp v >> return true
          , I.userInputRequestGetRespProducer = \v -> emit emitter_user_input_request_get_resp v >> return true
          , I.rgbLedSetRespProducer = \v -> emit emitter_rgb_led_set_resp v >> return true
          , I.rgbLedGetRespProducer = \v -> emit emitter_rgb_led_get_resp v >> return true
          , I.cameraTargetInputGetRespProducer = \v -> emit emitter_camera_target_input_get_resp v >> return true
          , I.heartbeatProducer = \v -> emit emitter_heartbeat v >> return true
          , I.packedStatusGetRespProducer = \v -> emit emitter_packed_status_get_resp v >> return true
          , I.controlLawGetRespProducer = \v -> emit emitter_control_law_get_resp v >> return true
          , I.rcInputGetRespProducer = \v -> emit emitter_rc_input_get_resp v >> return true
          , I.userInputGetRespProducer = \v -> emit emitter_user_input_get_resp v >> return true
          , I.sensorsOutputGetRespProducer = \v -> emit emitter_sensors_output_get_resp v >> return true
          , I.gyroOutputGetRespProducer = \v -> emit emitter_gyro_output_get_resp v >> return true
          , I.accelOutputGetRespProducer = \v -> emit emitter_accel_output_get_resp v >> return true
          , I.baroOutputGetRespProducer = \v -> emit emitter_baro_output_get_resp v >> return true
          , I.lidarliteOutputGetRespProducer = \v -> emit emitter_lidarlite_output_get_resp v >> return true
          , I.magOutputGetRespProducer = \v -> emit emitter_mag_output_get_resp v >> return true
          , I.px4flowIntOutputGetRespProducer = \v -> emit emitter_px4flow_int_output_get_resp v >> return true
          , I.px4flowOutputGetRespProducer = \v -> emit emitter_px4flow_output_get_resp v >> return true
          , I.gpsOutputGetRespProducer = \v -> emit emitter_gps_output_get_resp v >> return true
          , I.controlSetpointGetRespProducer = \v -> emit emitter_control_setpoint_get_resp v >> return true
          , I.controlOutputGetRespProducer = \v -> emit emitter_control_output_get_resp v >> return true
          , I.motorOutputGetRespProducer = \v -> emit emitter_motor_output_get_resp v >> return true
          , I.attControlDebugGetRespProducer = \v -> emit emitter_att_control_debug_get_resp v >> return true
          , I.altControlDebugGetRespProducer = \v -> emit emitter_alt_control_debug_get_resp v >> return true
          , I.px4ioStateGetRespProducer = \v -> emit emitter_px4io_state_get_resp v >> return true
          , I.armingStatusGetRespProducer = \v -> emit emitter_arming_status_get_resp v >> return true
          , I.batteryVoltageGetRespProducer = \v -> emit emitter_battery_voltage_get_resp v >> return true
          }
        return ()
  return ControllableVehicleProducer { rebootReqSetRespProducer = (snd ch_reboot_req_set_resp)
                                     , nominalThrottleSetRespProducer = (snd ch_nominal_throttle_set_resp)
                                     , nominalThrottleGetRespProducer = (snd ch_nominal_throttle_get_resp)
                                     , altitudeRatePidSetRespProducer = (snd ch_altitude_rate_pid_set_resp)
                                     , altitudeRatePidGetRespProducer = (snd ch_altitude_rate_pid_get_resp)
                                     , altitudePositionPidSetRespProducer = (snd ch_altitude_position_pid_set_resp)
                                     , altitudePositionPidGetRespProducer = (snd ch_altitude_position_pid_get_resp)
                                     , throttleUiSetRespProducer = (snd ch_throttle_ui_set_resp)
                                     , throttleUiGetRespProducer = (snd ch_throttle_ui_get_resp)
                                     , attitudeRollStabSetRespProducer = (snd ch_attitude_roll_stab_set_resp)
                                     , attitudeRollStabGetRespProducer = (snd ch_attitude_roll_stab_get_resp)
                                     , attitudePitchStabSetRespProducer = (snd ch_attitude_pitch_stab_set_resp)
                                     , attitudePitchStabGetRespProducer = (snd ch_attitude_pitch_stab_get_resp)
                                     , yawRatePidSetRespProducer = (snd ch_yaw_rate_pid_set_resp)
                                     , yawRatePidGetRespProducer = (snd ch_yaw_rate_pid_get_resp)
                                     , yawPositionPidSetRespProducer = (snd ch_yaw_position_pid_set_resp)
                                     , yawPositionPidGetRespProducer = (snd ch_yaw_position_pid_get_resp)
                                     , armingRequestSetRespProducer = (snd ch_arming_request_set_resp)
                                     , armingRequestGetRespProducer = (snd ch_arming_request_get_resp)
                                     , controlModesRequestSetRespProducer = (snd ch_control_modes_request_set_resp)
                                     , controlModesRequestGetRespProducer = (snd ch_control_modes_request_get_resp)
                                     , userInputRequestSetRespProducer = (snd ch_user_input_request_set_resp)
                                     , userInputRequestGetRespProducer = (snd ch_user_input_request_get_resp)
                                     , rgbLedSetRespProducer = (snd ch_rgb_led_set_resp)
                                     , rgbLedGetRespProducer = (snd ch_rgb_led_get_resp)
                                     , cameraTargetInputGetRespProducer = (snd ch_camera_target_input_get_resp)
                                     , heartbeatProducer = (snd ch_heartbeat)
                                     , packedStatusGetRespProducer = (snd ch_packed_status_get_resp)
                                     , controlLawGetRespProducer = (snd ch_control_law_get_resp)
                                     , rcInputGetRespProducer = (snd ch_rc_input_get_resp)
                                     , userInputGetRespProducer = (snd ch_user_input_get_resp)
                                     , sensorsOutputGetRespProducer = (snd ch_sensors_output_get_resp)
                                     , gyroOutputGetRespProducer = (snd ch_gyro_output_get_resp)
                                     , accelOutputGetRespProducer = (snd ch_accel_output_get_resp)
                                     , baroOutputGetRespProducer = (snd ch_baro_output_get_resp)
                                     , lidarliteOutputGetRespProducer = (snd ch_lidarlite_output_get_resp)
                                     , magOutputGetRespProducer = (snd ch_mag_output_get_resp)
                                     , px4flowIntOutputGetRespProducer = (snd ch_px4flow_int_output_get_resp)
                                     , px4flowOutputGetRespProducer = (snd ch_px4flow_output_get_resp)
                                     , gpsOutputGetRespProducer = (snd ch_gps_output_get_resp)
                                     , controlSetpointGetRespProducer = (snd ch_control_setpoint_get_resp)
                                     , controlOutputGetRespProducer = (snd ch_control_output_get_resp)
                                     , motorOutputGetRespProducer = (snd ch_motor_output_get_resp)
                                     , attControlDebugGetRespProducer = (snd ch_att_control_debug_get_resp)
                                     , altControlDebugGetRespProducer = (snd ch_alt_control_debug_get_resp)
                                     , px4ioStateGetRespProducer = (snd ch_px4io_state_get_resp)
                                     , armingStatusGetRespProducer = (snd ch_arming_status_get_resp)
                                     , batteryVoltageGetRespProducer = (snd ch_battery_voltage_get_resp)
                                     }
controllableVehicleProducerOutput:: (ANat n)
                                 => ControllableVehicleProducer
                                 -> Tower e (ChanOutput ('Array n ('Stored Uint8)))
controllableVehicleProducerOutput a = do
  towerModule serializeModule
  mapM_ towerArtifact serializeArtifacts
  mapM_ towerModule typeModules
  mapM_ towerDepends typeModules
  frame_ch <- channel
  monitor "controllableVehicleProducerInput" $ do
    handler (rebootReqSetRespProducer a) "rebootReqSetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.rebootReqSetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (nominalThrottleSetRespProducer a) "nominalThrottleSetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.nominalThrottleSetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (nominalThrottleGetRespProducer a) "nominalThrottleGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.nominalThrottleGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (altitudeRatePidSetRespProducer a) "altitudeRatePidSetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.altitudeRatePidSetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (altitudeRatePidGetRespProducer a) "altitudeRatePidGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.altitudeRatePidGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (altitudePositionPidSetRespProducer a) "altitudePositionPidSetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.altitudePositionPidSetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (altitudePositionPidGetRespProducer a) "altitudePositionPidGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.altitudePositionPidGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (throttleUiSetRespProducer a) "throttleUiSetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.throttleUiSetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (throttleUiGetRespProducer a) "throttleUiGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.throttleUiGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (attitudeRollStabSetRespProducer a) "attitudeRollStabSetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.attitudeRollStabSetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (attitudeRollStabGetRespProducer a) "attitudeRollStabGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.attitudeRollStabGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (attitudePitchStabSetRespProducer a) "attitudePitchStabSetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.attitudePitchStabSetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (attitudePitchStabGetRespProducer a) "attitudePitchStabGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.attitudePitchStabGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (yawRatePidSetRespProducer a) "yawRatePidSetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.yawRatePidSetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (yawRatePidGetRespProducer a) "yawRatePidGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.yawRatePidGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (yawPositionPidSetRespProducer a) "yawPositionPidSetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.yawPositionPidSetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (yawPositionPidGetRespProducer a) "yawPositionPidGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.yawPositionPidGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (armingRequestSetRespProducer a) "armingRequestSetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.armingRequestSetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (armingRequestGetRespProducer a) "armingRequestGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.armingRequestGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (controlModesRequestSetRespProducer a) "controlModesRequestSetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.controlModesRequestSetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (controlModesRequestGetRespProducer a) "controlModesRequestGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.controlModesRequestGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (userInputRequestSetRespProducer a) "userInputRequestSetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.userInputRequestSetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (userInputRequestGetRespProducer a) "userInputRequestGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.userInputRequestGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (rgbLedSetRespProducer a) "rgbLedSetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.rgbLedSetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (rgbLedGetRespProducer a) "rgbLedGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.rgbLedGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (cameraTargetInputGetRespProducer a) "cameraTargetInputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.cameraTargetInputGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (heartbeatProducer a) "heartbeatProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.heartbeatProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (packedStatusGetRespProducer a) "packedStatusGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.packedStatusGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (controlLawGetRespProducer a) "controlLawGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.controlLawGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (rcInputGetRespProducer a) "rcInputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.rcInputGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (userInputGetRespProducer a) "userInputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.userInputGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (sensorsOutputGetRespProducer a) "sensorsOutputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.sensorsOutputGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (gyroOutputGetRespProducer a) "gyroOutputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.gyroOutputGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (accelOutputGetRespProducer a) "accelOutputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.accelOutputGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (baroOutputGetRespProducer a) "baroOutputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.baroOutputGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (lidarliteOutputGetRespProducer a) "lidarliteOutputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.lidarliteOutputGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (magOutputGetRespProducer a) "magOutputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.magOutputGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (px4flowIntOutputGetRespProducer a) "px4flowIntOutputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.px4flowIntOutputGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (px4flowOutputGetRespProducer a) "px4flowOutputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.px4flowOutputGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (gpsOutputGetRespProducer a) "gpsOutputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.gpsOutputGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (controlSetpointGetRespProducer a) "controlSetpointGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.controlSetpointGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (controlOutputGetRespProducer a) "controlOutputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.controlOutputGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (motorOutputGetRespProducer a) "motorOutputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.motorOutputGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (attControlDebugGetRespProducer a) "attControlDebugGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.attControlDebugGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (altControlDebugGetRespProducer a) "altControlDebugGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.altControlDebugGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (px4ioStateGetRespProducer a) "px4ioStateGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.px4ioStateGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (armingStatusGetRespProducer a) "armingStatusGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.armingStatusGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (batteryVoltageGetRespProducer a) "batteryVoltageGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.batteryVoltageGetRespProducer (I.controllableVehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
  return (snd frame_ch)