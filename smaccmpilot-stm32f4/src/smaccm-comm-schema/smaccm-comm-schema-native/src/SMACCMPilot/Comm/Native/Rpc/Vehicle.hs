{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
module SMACCMPilot.Comm.Native.Rpc.Vehicle (rpcServer, Config(..)) where


import SMACCMPilot.Comm.Native.Types.Heartbeat
import qualified SMACCMPilot.Comm.Native.Types.ArmingStatus as ArmingStatus
import qualified SMACCMPilot.Comm.Native.Types.Px4ioState as Px4ioState
import qualified SMACCMPilot.Comm.Native.Types.AltControlDebug as AltControlDebug
import qualified SMACCMPilot.Comm.Native.Types.AttControlDebug as AttControlDebug
import qualified SMACCMPilot.Comm.Native.Types.QuadcopterMotors as QuadcopterMotors
import qualified SMACCMPilot.Comm.Native.Types.ControlOutput as ControlOutput
import qualified SMACCMPilot.Comm.Native.Types.ControlSetpoint as ControlSetpoint
import qualified SMACCMPilot.Comm.Native.Types.PositionSample as PositionSample
import qualified SMACCMPilot.Comm.Native.Types.Px4flowSample as Px4flowSample
import qualified SMACCMPilot.Comm.Native.Types.Px4flowIntegralSample as Px4flowIntegralSample
import qualified SMACCMPilot.Comm.Native.Types.MagnetometerSample as MagnetometerSample
import qualified SMACCMPilot.Comm.Native.Types.LidarliteSample as LidarliteSample
import qualified SMACCMPilot.Comm.Native.Types.BarometerSample as BarometerSample
import qualified SMACCMPilot.Comm.Native.Types.AccelerometerSample as AccelerometerSample
import qualified SMACCMPilot.Comm.Native.Types.GyroscopeSample as GyroscopeSample
import qualified SMACCMPilot.Comm.Native.Types.SensorsResult as SensorsResult
import qualified SMACCMPilot.Comm.Native.Types.UserInputResult as UserInputResult
import qualified SMACCMPilot.Comm.Native.Types.RcInput as RcInput
import qualified SMACCMPilot.Comm.Native.Types.ControlLaw as ControlLaw
import qualified SMACCMPilot.Comm.Native.Types.PackedStatus as PackedStatus
import qualified SMACCMPilot.Comm.Native.Types.Heartbeat as Heartbeat
import qualified SMACCMPilot.Comm.Native.Types.TimeMicros as TimeMicros
import Data.Int
import qualified SMACCMPilot.Comm.Native.Types.ArmingMode as ArmingMode
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedPackedStatus as SequenceNumberedPackedStatus
import qualified SMACCMPilot.Comm.Native.Types.SequenceNum as SequenceNum
import Data.Word
import qualified SMACCMPilot.Comm.Native.Types.PackedStatus as PackedStatus
import qualified SMACCMPilot.Comm.Native.Types.GpsFix as GpsFix
import Data.Word
import Data.Int
import qualified SMACCMPilot.Comm.Native.Types.Tristate as Tristate
import qualified SMACCMPilot.Comm.Native.Types.ControlModes as ControlModes
import qualified SMACCMPilot.Comm.Native.Types.ControlSource as ControlSource
import qualified SMACCMPilot.Comm.Native.Types.YawMode as YawMode
import qualified SMACCMPilot.Comm.Native.Types.ThrottleMode as ThrottleMode
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedControlLaw as SequenceNumberedControlLaw
import qualified SMACCMPilot.Comm.Native.Types.ControlLaw as ControlLaw
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedRcInput as SequenceNumberedRcInput
import qualified SMACCMPilot.Comm.Native.Types.RcInput as RcInput
import Data.Word
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedUserInputResult as SequenceNumberedUserInputResult
import qualified SMACCMPilot.Comm.Native.Types.UserInputResult as UserInputResult
import qualified SMACCMPilot.Comm.Native.Types.UserInput as UserInput
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedSensorsResult as SequenceNumberedSensorsResult
import qualified SMACCMPilot.Comm.Native.Types.SensorsResult as SensorsResult
import qualified SMACCMPilot.Comm.Native.Types.Xyz as Xyz
import qualified SMACCMPilot.Comm.Native.Types.Quaternion as Quaternion
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedGyroscopeSample as SequenceNumberedGyroscopeSample
import qualified SMACCMPilot.Comm.Native.Types.GyroscopeSample as GyroscopeSample
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedAccelerometerSample as SequenceNumberedAccelerometerSample
import qualified SMACCMPilot.Comm.Native.Types.AccelerometerSample as AccelerometerSample
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedBarometerSample as SequenceNumberedBarometerSample
import qualified SMACCMPilot.Comm.Native.Types.BarometerSample as BarometerSample
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedLidarliteSample as SequenceNumberedLidarliteSample
import qualified SMACCMPilot.Comm.Native.Types.LidarliteSample as LidarliteSample
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedMagnetometerSample as SequenceNumberedMagnetometerSample
import qualified SMACCMPilot.Comm.Native.Types.MagnetometerSample as MagnetometerSample
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedPx4flowIntegralSample as SequenceNumberedPx4flowIntegralSample
import qualified SMACCMPilot.Comm.Native.Types.Px4flowIntegralSample as Px4flowIntegralSample
import Data.Int
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedPx4flowSample as SequenceNumberedPx4flowSample
import qualified SMACCMPilot.Comm.Native.Types.Px4flowSample as Px4flowSample
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedPositionSample as SequenceNumberedPositionSample
import qualified SMACCMPilot.Comm.Native.Types.PositionSample as PositionSample
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedControlSetpoint as SequenceNumberedControlSetpoint
import qualified SMACCMPilot.Comm.Native.Types.ControlSetpoint as ControlSetpoint
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedControlOutput as SequenceNumberedControlOutput
import qualified SMACCMPilot.Comm.Native.Types.ControlOutput as ControlOutput
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedQuadcopterMotors as SequenceNumberedQuadcopterMotors
import qualified SMACCMPilot.Comm.Native.Types.QuadcopterMotors as QuadcopterMotors
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedAttControlDebug as SequenceNumberedAttControlDebug
import qualified SMACCMPilot.Comm.Native.Types.AttControlDebug as AttControlDebug
import qualified SMACCMPilot.Comm.Native.Types.PidState as PidState
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedAltControlDebug as SequenceNumberedAltControlDebug
import qualified SMACCMPilot.Comm.Native.Types.AltControlDebug as AltControlDebug
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedPx4ioState as SequenceNumberedPx4ioState
import qualified SMACCMPilot.Comm.Native.Types.Px4ioState as Px4ioState
import qualified SMACCMPilot.Comm.Native.Types.Px4ioStatus as Px4ioStatus
import qualified SMACCMPilot.Comm.Native.Types.Px4ioAlarms as Px4ioAlarms
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedArmingStatus as SequenceNumberedArmingStatus
import qualified SMACCMPilot.Comm.Native.Types.ArmingStatus as ArmingStatus
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedFloat as SequenceNumberedFloat
import SMACCMPilot.Comm.Native.Interface.Vehicle


import SMACCMPilot.Comm.Native.Rpc.Base


import           Control.Monad (msum)
import           Data.Aeson (decode)
import qualified Snap.Core as Snap
import           Control.Concurrent (forkIO)
import           Control.Concurrent.STM
import           Control.Monad (forever)
import           Control.Monad.IO.Class (liftIO)
import           Data.Aeson (encode,Value(Null))




data State = State {stream_heartbeat :: TSampleVar Heartbeat}
mkState :: IO State
mkState  =
  do stream_heartbeat <- newTSampleVarIO
     return State { .. }
manager :: State-> TQueue VehicleProducer-> TQueue VehicleProducer-> IO ()
manager state input filtered = forever $
  do msg <- atomically (readTQueue input)
     case msg of
         HeartbeatProducer x -> atomically (writeTSampleVar (stream_heartbeat state) x)
         notStream -> atomically (writeTQueue filtered notStream)
rpcServer :: TQueue VehicleProducer-> TQueue VehicleConsumer-> Config-> IO ()
rpcServer input output cfg =
  do state <- mkState
     input' <- newTQueueIO
     _ <- forkIO (manager state input input' )
     conn <- newConn output input' (SequenceNum.unSequenceNum . seqNumGetterVehicleProducer)
     logCtx <- initLogging (cfgLogSuffix cfg)
     runServer cfg $ Snap.route
       [("vehicle_i/heartbeat",
         Snap.method Snap.GET $
           do x <- liftIO (atomically (readTSampleVar (stream_heartbeat state)))
              let e = case x of Just v -> encode v; Nothing -> encode Null
              writeLoggingLBS logCtx e),
        ("vehicle_i/packed_status",
         Snap.method Snap.GET $ do (PackedStatusGetRespProducer (SequenceNumberedPackedStatus.SequenceNumberedPackedStatus _ resp)) <- liftIO $ sendRequest conn $ PackedStatusGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("vehicle_i/control_law",
         Snap.method Snap.GET $ do (ControlLawGetRespProducer (SequenceNumberedControlLaw.SequenceNumberedControlLaw _ resp)) <- liftIO $ sendRequest conn $ ControlLawGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("vehicle_i/rc_input",
         Snap.method Snap.GET $ do (RcInputGetRespProducer (SequenceNumberedRcInput.SequenceNumberedRcInput _ resp)) <- liftIO $ sendRequest conn $ RcInputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("vehicle_i/user_input",
         Snap.method Snap.GET $ do (UserInputGetRespProducer (SequenceNumberedUserInputResult.SequenceNumberedUserInputResult _ resp)) <- liftIO $ sendRequest conn $ UserInputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("vehicle_i/sensors_output",
         Snap.method Snap.GET $ do (SensorsOutputGetRespProducer (SequenceNumberedSensorsResult.SequenceNumberedSensorsResult _ resp)) <- liftIO $ sendRequest conn $ SensorsOutputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("vehicle_i/gyro_output",
         Snap.method Snap.GET $ do (GyroOutputGetRespProducer (SequenceNumberedGyroscopeSample.SequenceNumberedGyroscopeSample _ resp)) <- liftIO $ sendRequest conn $ GyroOutputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("vehicle_i/accel_output",
         Snap.method Snap.GET $ do (AccelOutputGetRespProducer (SequenceNumberedAccelerometerSample.SequenceNumberedAccelerometerSample _ resp)) <- liftIO $ sendRequest conn $ AccelOutputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("vehicle_i/baro_output",
         Snap.method Snap.GET $ do (BaroOutputGetRespProducer (SequenceNumberedBarometerSample.SequenceNumberedBarometerSample _ resp)) <- liftIO $ sendRequest conn $ BaroOutputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("vehicle_i/lidarlite_output",
         Snap.method Snap.GET $ do (LidarliteOutputGetRespProducer (SequenceNumberedLidarliteSample.SequenceNumberedLidarliteSample _ resp)) <- liftIO $ sendRequest conn $ LidarliteOutputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("vehicle_i/mag_output",
         Snap.method Snap.GET $ do (MagOutputGetRespProducer (SequenceNumberedMagnetometerSample.SequenceNumberedMagnetometerSample _ resp)) <- liftIO $ sendRequest conn $ MagOutputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("vehicle_i/px4flow_int_output",
         Snap.method Snap.GET $ do (Px4flowIntOutputGetRespProducer (SequenceNumberedPx4flowIntegralSample.SequenceNumberedPx4flowIntegralSample _ resp)) <- liftIO $ sendRequest conn $ Px4flowIntOutputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("vehicle_i/px4flow_output",
         Snap.method Snap.GET $ do (Px4flowOutputGetRespProducer (SequenceNumberedPx4flowSample.SequenceNumberedPx4flowSample _ resp)) <- liftIO $ sendRequest conn $ Px4flowOutputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("vehicle_i/gps_output",
         Snap.method Snap.GET $ do (GpsOutputGetRespProducer (SequenceNumberedPositionSample.SequenceNumberedPositionSample _ resp)) <- liftIO $ sendRequest conn $ GpsOutputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("vehicle_i/control_setpoint",
         Snap.method Snap.GET $ do (ControlSetpointGetRespProducer (SequenceNumberedControlSetpoint.SequenceNumberedControlSetpoint _ resp)) <- liftIO $ sendRequest conn $ ControlSetpointGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("vehicle_i/control_output",
         Snap.method Snap.GET $ do (ControlOutputGetRespProducer (SequenceNumberedControlOutput.SequenceNumberedControlOutput _ resp)) <- liftIO $ sendRequest conn $ ControlOutputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("vehicle_i/motor_output",
         Snap.method Snap.GET $ do (MotorOutputGetRespProducer (SequenceNumberedQuadcopterMotors.SequenceNumberedQuadcopterMotors _ resp)) <- liftIO $ sendRequest conn $ MotorOutputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("vehicle_i/att_control_debug",
         Snap.method Snap.GET $ do (AttControlDebugGetRespProducer (SequenceNumberedAttControlDebug.SequenceNumberedAttControlDebug _ resp)) <- liftIO $ sendRequest conn $ AttControlDebugGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("vehicle_i/alt_control_debug",
         Snap.method Snap.GET $ do (AltControlDebugGetRespProducer (SequenceNumberedAltControlDebug.SequenceNumberedAltControlDebug _ resp)) <- liftIO $ sendRequest conn $ AltControlDebugGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("vehicle_i/px4io_state",
         Snap.method Snap.GET $ do (Px4ioStateGetRespProducer (SequenceNumberedPx4ioState.SequenceNumberedPx4ioState _ resp)) <- liftIO $ sendRequest conn $ Px4ioStateGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("vehicle_i/arming_status",
         Snap.method Snap.GET $ do (ArmingStatusGetRespProducer (SequenceNumberedArmingStatus.SequenceNumberedArmingStatus _ resp)) <- liftIO $ sendRequest conn $ ArmingStatusGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("vehicle_i/battery_voltage",
         Snap.method Snap.GET $ do (BatteryVoltageGetRespProducer (SequenceNumberedFloat.SequenceNumberedFloat _ resp)) <- liftIO $ sendRequest conn $ BatteryVoltageGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp))]