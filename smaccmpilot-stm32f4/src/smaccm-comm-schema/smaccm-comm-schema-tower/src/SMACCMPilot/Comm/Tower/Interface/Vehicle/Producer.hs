{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
module SMACCMPilot.Comm.Tower.Interface.Vehicle.Producer where
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
import SMACCMPilot.Comm.Ivory.Types
import qualified SMACCMPilot.Comm.Ivory.Interface.Vehicle.Producer as I
import Ivory.Language
import Ivory.Stdlib
import Ivory.Tower
import Ivory.Serialize
-- Define Producer schema for Vehicle interface
data VehicleProducer = VehicleProducer
  { heartbeatProducer :: ChanOutput ('Struct "heartbeat")
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
vehicleProducerInput :: (ANat n)
                     => ChanOutput ('Array n ('Stored Uint8))
                     -> Tower e VehicleProducer
vehicleProducerInput frame_ch = do
  towerModule serializeModule
  mapM_ towerArtifact serializeArtifacts
  mapM_ towerModule typeModules
  mapM_ towerDepends typeModules
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
  monitor "vehicleProducerOutput" $ do
    handler frame_ch "parse_frame" $ do
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
        _ <- I.vehicleProducerParser f offs $ I.VehicleProducer
          { I.heartbeatProducer = \v -> emit emitter_heartbeat v >> return true
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
  return VehicleProducer { heartbeatProducer = (snd ch_heartbeat)
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
vehicleProducerOutput:: (ANat n)
                     => VehicleProducer
                     -> Tower e (ChanOutput ('Array n ('Stored Uint8)))
vehicleProducerOutput a = do
  towerModule serializeModule
  mapM_ towerArtifact serializeArtifacts
  mapM_ towerModule typeModules
  mapM_ towerDepends typeModules
  frame_ch <- channel
  monitor "vehicleProducerInput" $ do
    handler (heartbeatProducer a) "heartbeatProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.heartbeatProducer (I.vehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (packedStatusGetRespProducer a) "packedStatusGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.packedStatusGetRespProducer (I.vehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (controlLawGetRespProducer a) "controlLawGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.controlLawGetRespProducer (I.vehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (rcInputGetRespProducer a) "rcInputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.rcInputGetRespProducer (I.vehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (userInputGetRespProducer a) "userInputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.userInputGetRespProducer (I.vehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (sensorsOutputGetRespProducer a) "sensorsOutputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.sensorsOutputGetRespProducer (I.vehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (gyroOutputGetRespProducer a) "gyroOutputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.gyroOutputGetRespProducer (I.vehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (accelOutputGetRespProducer a) "accelOutputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.accelOutputGetRespProducer (I.vehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (baroOutputGetRespProducer a) "baroOutputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.baroOutputGetRespProducer (I.vehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (lidarliteOutputGetRespProducer a) "lidarliteOutputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.lidarliteOutputGetRespProducer (I.vehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (magOutputGetRespProducer a) "magOutputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.magOutputGetRespProducer (I.vehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (px4flowIntOutputGetRespProducer a) "px4flowIntOutputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.px4flowIntOutputGetRespProducer (I.vehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (px4flowOutputGetRespProducer a) "px4flowOutputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.px4flowOutputGetRespProducer (I.vehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (gpsOutputGetRespProducer a) "gpsOutputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.gpsOutputGetRespProducer (I.vehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (controlSetpointGetRespProducer a) "controlSetpointGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.controlSetpointGetRespProducer (I.vehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (controlOutputGetRespProducer a) "controlOutputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.controlOutputGetRespProducer (I.vehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (motorOutputGetRespProducer a) "motorOutputGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.motorOutputGetRespProducer (I.vehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (attControlDebugGetRespProducer a) "attControlDebugGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.attControlDebugGetRespProducer (I.vehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (altControlDebugGetRespProducer a) "altControlDebugGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.altControlDebugGetRespProducer (I.vehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (px4ioStateGetRespProducer a) "px4ioStateGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.px4ioStateGetRespProducer (I.vehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (armingStatusGetRespProducer a) "armingStatusGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.armingStatusGetRespProducer (I.vehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (batteryVoltageGetRespProducer a) "batteryVoltageGetRespProducer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.batteryVoltageGetRespProducer (I.vehicleProducerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
  return (snd frame_ch)