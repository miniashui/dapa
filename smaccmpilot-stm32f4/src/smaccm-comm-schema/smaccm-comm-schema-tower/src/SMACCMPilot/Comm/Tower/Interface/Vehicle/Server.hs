{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE RecordWildCards #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
{-# OPTIONS_GHC -fno-warn-unused-matches #-}
module SMACCMPilot.Comm.Tower.Interface.Vehicle.Server where
import SMACCMPilot.Comm.Tower.Attr
import SMACCMPilot.Comm.Tower.Interface.Vehicle.Producer
import SMACCMPilot.Comm.Tower.Interface.Vehicle.Consumer
import Ivory.Language
import Ivory.Tower
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
data VehicleAttrs (p :: Area * -> *) =
  VehicleAttrs
    { packedStatus :: p ('Struct "packed_status")
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
towerVehicleAttrs :: VehicleAttrs Init -> Tower e (VehicleAttrs Attr)
towerVehicleAttrs ivals = do
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
  return VehicleAttrs { packedStatus = packedStatus_p
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
initVehicleAttrs :: VehicleAttrs Init
initVehicleAttrs = VehicleAttrs
  { packedStatus = izero
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
data VehicleStreams (p :: Area * -> *) =
  VehicleStreams
    { heartbeat :: p ('Struct "heartbeat")
    }
towerVehicleStreams :: Tower e (VehicleStreams ChanInput, VehicleStreams ChanOutput)
towerVehicleStreams = do
  heartbeat_c <- channel
  return ( VehicleStreams
           { heartbeat = fst heartbeat_c
           }
         , VehicleStreams
           { heartbeat = snd heartbeat_c
           }
         )
towerVehicleServer :: VehicleConsumer
                   -> VehicleAttrs Attr
                   -> VehicleStreams ChanOutput
                   -> Tower e VehicleProducer
towerVehicleServer VehicleConsumer{..} VehicleAttrs{..} VehicleStreams{..} = do
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
  return VehicleProducer{..}