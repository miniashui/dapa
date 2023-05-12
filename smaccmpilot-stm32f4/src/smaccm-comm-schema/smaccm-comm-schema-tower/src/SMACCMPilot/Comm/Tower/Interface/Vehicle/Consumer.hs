{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
module SMACCMPilot.Comm.Tower.Interface.Vehicle.Consumer where
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
import qualified SMACCMPilot.Comm.Ivory.Interface.Vehicle.Consumer as I
import Ivory.Language
import Ivory.Stdlib
import Ivory.Tower
import Ivory.Serialize
-- Define Consumer schema for Vehicle interface
data VehicleConsumer = VehicleConsumer
  { packedStatusGetReqConsumer :: ChanOutput ('Stored SequenceNum.SequenceNum)
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
vehicleConsumerInput :: (ANat n)
                     => ChanOutput ('Array n ('Stored Uint8))
                     -> Tower e VehicleConsumer
vehicleConsumerInput frame_ch = do
  towerModule serializeModule
  mapM_ towerArtifact serializeArtifacts
  mapM_ towerModule typeModules
  mapM_ towerDepends typeModules
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
  monitor "vehicleConsumerOutput" $ do
    handler frame_ch "parse_frame" $ do
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
        _ <- I.vehicleConsumerParser f offs $ I.VehicleConsumer
          { I.packedStatusGetReqConsumer = \v -> emit emitter_packed_status_get_req v >> return true
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
  return VehicleConsumer { packedStatusGetReqConsumer = (snd ch_packed_status_get_req)
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
vehicleConsumerOutput:: (ANat n)
                     => VehicleConsumer
                     -> Tower e (ChanOutput ('Array n ('Stored Uint8)))
vehicleConsumerOutput a = do
  towerModule serializeModule
  mapM_ towerArtifact serializeArtifacts
  mapM_ towerModule typeModules
  mapM_ towerDepends typeModules
  frame_ch <- channel
  monitor "vehicleConsumerInput" $ do
    handler (packedStatusGetReqConsumer a) "packedStatusGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.packedStatusGetReqConsumer (I.vehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (controlLawGetReqConsumer a) "controlLawGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.controlLawGetReqConsumer (I.vehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (rcInputGetReqConsumer a) "rcInputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.rcInputGetReqConsumer (I.vehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (userInputGetReqConsumer a) "userInputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.userInputGetReqConsumer (I.vehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (sensorsOutputGetReqConsumer a) "sensorsOutputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.sensorsOutputGetReqConsumer (I.vehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (gyroOutputGetReqConsumer a) "gyroOutputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.gyroOutputGetReqConsumer (I.vehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (accelOutputGetReqConsumer a) "accelOutputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.accelOutputGetReqConsumer (I.vehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (baroOutputGetReqConsumer a) "baroOutputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.baroOutputGetReqConsumer (I.vehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (lidarliteOutputGetReqConsumer a) "lidarliteOutputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.lidarliteOutputGetReqConsumer (I.vehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (magOutputGetReqConsumer a) "magOutputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.magOutputGetReqConsumer (I.vehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (px4flowIntOutputGetReqConsumer a) "px4flowIntOutputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.px4flowIntOutputGetReqConsumer (I.vehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (px4flowOutputGetReqConsumer a) "px4flowOutputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.px4flowOutputGetReqConsumer (I.vehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (gpsOutputGetReqConsumer a) "gpsOutputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.gpsOutputGetReqConsumer (I.vehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (controlSetpointGetReqConsumer a) "controlSetpointGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.controlSetpointGetReqConsumer (I.vehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (controlOutputGetReqConsumer a) "controlOutputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.controlOutputGetReqConsumer (I.vehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (motorOutputGetReqConsumer a) "motorOutputGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.motorOutputGetReqConsumer (I.vehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (attControlDebugGetReqConsumer a) "attControlDebugGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.attControlDebugGetReqConsumer (I.vehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (altControlDebugGetReqConsumer a) "altControlDebugGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.altControlDebugGetReqConsumer (I.vehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (px4ioStateGetReqConsumer a) "px4ioStateGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.px4ioStateGetReqConsumer (I.vehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (armingStatusGetReqConsumer a) "armingStatusGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.armingStatusGetReqConsumer (I.vehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
    handler (batteryVoltageGetReqConsumer a) "batteryVoltageGetReqConsumer" $ do
      e <- emitter (fst frame_ch) 1
      callback $ \w -> do
        f <- local izero
        o <- local izero
        ok <- I.batteryVoltageGetReqConsumer (I.vehicleConsumerSender f o) w
        ifte_ ok (emit e (constRef f)) (return ())
  return (snd frame_ch)