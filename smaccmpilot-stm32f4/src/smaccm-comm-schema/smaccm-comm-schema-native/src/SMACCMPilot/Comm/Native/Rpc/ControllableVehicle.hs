{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
module SMACCMPilot.Comm.Native.Rpc.ControllableVehicle (rpcServer, Config(..)) where


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
import qualified SMACCMPilot.Comm.Native.Types.CameraTarget as CameraTarget
import qualified SMACCMPilot.Comm.Native.Types.RgbLedSetting as RgbLedSetting
import qualified SMACCMPilot.Comm.Native.Types.UserInput as UserInput
import qualified SMACCMPilot.Comm.Native.Types.ControlModes as ControlModes
import qualified SMACCMPilot.Comm.Native.Types.Tristate as Tristate
import qualified SMACCMPilot.Comm.Native.Types.PidConfig as PidConfig
import qualified SMACCMPilot.Comm.Native.Types.StabConfig as StabConfig
import qualified SMACCMPilot.Comm.Native.Types.ThrottleUi as ThrottleUi
import qualified SMACCMPilot.Comm.Native.Types.RebootReq as RebootReq
import qualified SMACCMPilot.Comm.Native.Types.SequenceNum as SequenceNum
import Data.Word
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedFloat as SequenceNumberedFloat
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedPidConfig as SequenceNumberedPidConfig
import qualified SMACCMPilot.Comm.Native.Types.PidConfig as PidConfig
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedThrottleUi as SequenceNumberedThrottleUi
import qualified SMACCMPilot.Comm.Native.Types.ThrottleUi as ThrottleUi
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedStabConfig as SequenceNumberedStabConfig
import qualified SMACCMPilot.Comm.Native.Types.StabConfig as StabConfig
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedTristate as SequenceNumberedTristate
import qualified SMACCMPilot.Comm.Native.Types.Tristate as Tristate
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedControlModes as SequenceNumberedControlModes
import qualified SMACCMPilot.Comm.Native.Types.ControlModes as ControlModes
import qualified SMACCMPilot.Comm.Native.Types.ControlSource as ControlSource
import qualified SMACCMPilot.Comm.Native.Types.YawMode as YawMode
import qualified SMACCMPilot.Comm.Native.Types.ThrottleMode as ThrottleMode
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedUserInput as SequenceNumberedUserInput
import qualified SMACCMPilot.Comm.Native.Types.UserInput as UserInput
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedRgbLedSetting as SequenceNumberedRgbLedSetting
import qualified SMACCMPilot.Comm.Native.Types.RgbLedSetting as RgbLedSetting
import Data.Word
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedCameraTarget as SequenceNumberedCameraTarget
import qualified SMACCMPilot.Comm.Native.Types.CameraTarget as CameraTarget
import Data.Word
import qualified SMACCMPilot.Comm.Native.Types.Heartbeat as Heartbeat
import qualified SMACCMPilot.Comm.Native.Types.TimeMicros as TimeMicros
import Data.Int
import qualified SMACCMPilot.Comm.Native.Types.ArmingMode as ArmingMode
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedPackedStatus as SequenceNumberedPackedStatus
import qualified SMACCMPilot.Comm.Native.Types.PackedStatus as PackedStatus
import qualified SMACCMPilot.Comm.Native.Types.GpsFix as GpsFix
import Data.Int
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedControlLaw as SequenceNumberedControlLaw
import qualified SMACCMPilot.Comm.Native.Types.ControlLaw as ControlLaw
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedRcInput as SequenceNumberedRcInput
import qualified SMACCMPilot.Comm.Native.Types.RcInput as RcInput
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedUserInputResult as SequenceNumberedUserInputResult
import qualified SMACCMPilot.Comm.Native.Types.UserInputResult as UserInputResult
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
import qualified SMACCMPilot.Comm.Native.Types.SequenceNumberedRebootReq as SequenceNumberedRebootReq
import qualified SMACCMPilot.Comm.Native.Types.RebootReq as RebootReq
import qualified SMACCMPilot.Comm.Native.Types.RebootMagic as RebootMagic
import SMACCMPilot.Comm.Native.Interface.ControllableVehicle


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
manager :: State-> TQueue ControllableVehicleProducer-> TQueue ControllableVehicleProducer-> IO ()
manager state input filtered = forever $
  do msg <- atomically (readTQueue input)
     case msg of
         HeartbeatProducer x -> atomically (writeTSampleVar (stream_heartbeat state) x)
         notStream -> atomically (writeTQueue filtered notStream)
rpcServer :: TQueue ControllableVehicleProducer-> TQueue ControllableVehicleConsumer-> Config-> IO ()
rpcServer input output cfg =
  do state <- mkState
     input' <- newTQueueIO
     _ <- forkIO (manager state input input' )
     conn <- newConn output input' (SequenceNum.unSequenceNum . seqNumGetterControllableVehicleProducer)
     logCtx <- initLogging (cfgLogSuffix cfg)
     runServer cfg $ Snap.route
       [("controllable_vehicle_i/heartbeat",
         Snap.method Snap.GET $
           do x <- liftIO (atomically (readTSampleVar (stream_heartbeat state)))
              let e = case x of Just v -> encode v; Nothing -> encode Null
              writeLoggingLBS logCtx e),
        ("controllable_vehicle_i/packed_status",
         Snap.method Snap.GET $ do (PackedStatusGetRespProducer (SequenceNumberedPackedStatus.SequenceNumberedPackedStatus _ resp)) <- liftIO $ sendRequest conn $ PackedStatusGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("controllable_vehicle_i/control_law",
         Snap.method Snap.GET $ do (ControlLawGetRespProducer (SequenceNumberedControlLaw.SequenceNumberedControlLaw _ resp)) <- liftIO $ sendRequest conn $ ControlLawGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("controllable_vehicle_i/rc_input",
         Snap.method Snap.GET $ do (RcInputGetRespProducer (SequenceNumberedRcInput.SequenceNumberedRcInput _ resp)) <- liftIO $ sendRequest conn $ RcInputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("controllable_vehicle_i/user_input",
         Snap.method Snap.GET $ do (UserInputGetRespProducer (SequenceNumberedUserInputResult.SequenceNumberedUserInputResult _ resp)) <- liftIO $ sendRequest conn $ UserInputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("controllable_vehicle_i/sensors_output",
         Snap.method Snap.GET $ do (SensorsOutputGetRespProducer (SequenceNumberedSensorsResult.SequenceNumberedSensorsResult _ resp)) <- liftIO $ sendRequest conn $ SensorsOutputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("controllable_vehicle_i/gyro_output",
         Snap.method Snap.GET $ do (GyroOutputGetRespProducer (SequenceNumberedGyroscopeSample.SequenceNumberedGyroscopeSample _ resp)) <- liftIO $ sendRequest conn $ GyroOutputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("controllable_vehicle_i/accel_output",
         Snap.method Snap.GET $ do (AccelOutputGetRespProducer (SequenceNumberedAccelerometerSample.SequenceNumberedAccelerometerSample _ resp)) <- liftIO $ sendRequest conn $ AccelOutputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("controllable_vehicle_i/baro_output",
         Snap.method Snap.GET $ do (BaroOutputGetRespProducer (SequenceNumberedBarometerSample.SequenceNumberedBarometerSample _ resp)) <- liftIO $ sendRequest conn $ BaroOutputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("controllable_vehicle_i/lidarlite_output",
         Snap.method Snap.GET $ do (LidarliteOutputGetRespProducer (SequenceNumberedLidarliteSample.SequenceNumberedLidarliteSample _ resp)) <- liftIO $ sendRequest conn $ LidarliteOutputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("controllable_vehicle_i/mag_output",
         Snap.method Snap.GET $ do (MagOutputGetRespProducer (SequenceNumberedMagnetometerSample.SequenceNumberedMagnetometerSample _ resp)) <- liftIO $ sendRequest conn $ MagOutputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("controllable_vehicle_i/px4flow_int_output",
         Snap.method Snap.GET $ do (Px4flowIntOutputGetRespProducer (SequenceNumberedPx4flowIntegralSample.SequenceNumberedPx4flowIntegralSample _ resp)) <- liftIO $ sendRequest conn $ Px4flowIntOutputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("controllable_vehicle_i/px4flow_output",
         Snap.method Snap.GET $ do (Px4flowOutputGetRespProducer (SequenceNumberedPx4flowSample.SequenceNumberedPx4flowSample _ resp)) <- liftIO $ sendRequest conn $ Px4flowOutputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("controllable_vehicle_i/gps_output",
         Snap.method Snap.GET $ do (GpsOutputGetRespProducer (SequenceNumberedPositionSample.SequenceNumberedPositionSample _ resp)) <- liftIO $ sendRequest conn $ GpsOutputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("controllable_vehicle_i/control_setpoint",
         Snap.method Snap.GET $ do (ControlSetpointGetRespProducer (SequenceNumberedControlSetpoint.SequenceNumberedControlSetpoint _ resp)) <- liftIO $ sendRequest conn $ ControlSetpointGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("controllable_vehicle_i/control_output",
         Snap.method Snap.GET $ do (ControlOutputGetRespProducer (SequenceNumberedControlOutput.SequenceNumberedControlOutput _ resp)) <- liftIO $ sendRequest conn $ ControlOutputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("controllable_vehicle_i/motor_output",
         Snap.method Snap.GET $ do (MotorOutputGetRespProducer (SequenceNumberedQuadcopterMotors.SequenceNumberedQuadcopterMotors _ resp)) <- liftIO $ sendRequest conn $ MotorOutputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("controllable_vehicle_i/att_control_debug",
         Snap.method Snap.GET $ do (AttControlDebugGetRespProducer (SequenceNumberedAttControlDebug.SequenceNumberedAttControlDebug _ resp)) <- liftIO $ sendRequest conn $ AttControlDebugGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("controllable_vehicle_i/alt_control_debug",
         Snap.method Snap.GET $ do (AltControlDebugGetRespProducer (SequenceNumberedAltControlDebug.SequenceNumberedAltControlDebug _ resp)) <- liftIO $ sendRequest conn $ AltControlDebugGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("controllable_vehicle_i/px4io_state",
         Snap.method Snap.GET $ do (Px4ioStateGetRespProducer (SequenceNumberedPx4ioState.SequenceNumberedPx4ioState _ resp)) <- liftIO $ sendRequest conn $ Px4ioStateGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("controllable_vehicle_i/arming_status",
         Snap.method Snap.GET $ do (ArmingStatusGetRespProducer (SequenceNumberedArmingStatus.SequenceNumberedArmingStatus _ resp)) <- liftIO $ sendRequest conn $ ArmingStatusGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("controllable_vehicle_i/battery_voltage",
         Snap.method Snap.GET $ do (BatteryVoltageGetRespProducer (SequenceNumberedFloat.SequenceNumberedFloat _ resp)) <- liftIO $ sendRequest conn $ BatteryVoltageGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp)),
        ("controllable_vehicle_i/reboot_req",
         Snap.method Snap.POST $ do bytes <- Snap.readRequestBody 32768
                                    case decode bytes of
                                      Just req -> liftIO $ do _ <- sendRequest conn $ \ snum -> RebootReqSetReqConsumer (SequenceNumberedRebootReq.SequenceNumberedRebootReq (SequenceNum.SequenceNum snum) req)
                                                              return ()
                                      Nothing  -> Snap.modifyResponse $ Snap.setResponseCode 400),
        ("controllable_vehicle_i/nominal_throttle",
         msum
           [Snap.method Snap.GET $ do (NominalThrottleGetRespProducer (SequenceNumberedFloat.SequenceNumberedFloat _ resp)) <- liftIO $ sendRequest conn $ NominalThrottleGetReqConsumer . SequenceNum.SequenceNum
                                      Snap.modifyResponse $ Snap.setContentType "application/json"
                                      writeLoggingLBS logCtx (encode resp),
            Snap.method Snap.POST $ do bytes <- Snap.readRequestBody 32768
                                       case decode bytes of
                                         Just req -> liftIO $ do _ <- sendRequest conn $ \ snum -> NominalThrottleSetReqConsumer (SequenceNumberedFloat.SequenceNumberedFloat (SequenceNum.SequenceNum snum) req)
                                                                 return ()
                                         Nothing  -> Snap.modifyResponse $ Snap.setResponseCode 400]),
        ("controllable_vehicle_i/altitude_rate_pid",
         msum
           [Snap.method Snap.GET $ do (AltitudeRatePidGetRespProducer (SequenceNumberedPidConfig.SequenceNumberedPidConfig _ resp)) <- liftIO $ sendRequest conn $ AltitudeRatePidGetReqConsumer . SequenceNum.SequenceNum
                                      Snap.modifyResponse $ Snap.setContentType "application/json"
                                      writeLoggingLBS logCtx (encode resp),
            Snap.method Snap.POST $ do bytes <- Snap.readRequestBody 32768
                                       case decode bytes of
                                         Just req -> liftIO $ do _ <- sendRequest conn $ \ snum -> AltitudeRatePidSetReqConsumer (SequenceNumberedPidConfig.SequenceNumberedPidConfig (SequenceNum.SequenceNum snum) req)
                                                                 return ()
                                         Nothing  -> Snap.modifyResponse $ Snap.setResponseCode 400]),
        ("controllable_vehicle_i/altitude_position_pid",
         msum
           [Snap.method Snap.GET $ do (AltitudePositionPidGetRespProducer (SequenceNumberedPidConfig.SequenceNumberedPidConfig _ resp)) <- liftIO $ sendRequest conn $ AltitudePositionPidGetReqConsumer . SequenceNum.SequenceNum
                                      Snap.modifyResponse $ Snap.setContentType "application/json"
                                      writeLoggingLBS logCtx (encode resp),
            Snap.method Snap.POST $ do bytes <- Snap.readRequestBody 32768
                                       case decode bytes of
                                         Just req -> liftIO $ do _ <- sendRequest conn $ \ snum -> AltitudePositionPidSetReqConsumer (SequenceNumberedPidConfig.SequenceNumberedPidConfig (SequenceNum.SequenceNum snum) req)
                                                                 return ()
                                         Nothing  -> Snap.modifyResponse $ Snap.setResponseCode 400]),
        ("controllable_vehicle_i/throttle_ui",
         msum
           [Snap.method Snap.GET $ do (ThrottleUiGetRespProducer (SequenceNumberedThrottleUi.SequenceNumberedThrottleUi _ resp)) <- liftIO $ sendRequest conn $ ThrottleUiGetReqConsumer . SequenceNum.SequenceNum
                                      Snap.modifyResponse $ Snap.setContentType "application/json"
                                      writeLoggingLBS logCtx (encode resp),
            Snap.method Snap.POST $ do bytes <- Snap.readRequestBody 32768
                                       case decode bytes of
                                         Just req -> liftIO $ do _ <- sendRequest conn $ \ snum -> ThrottleUiSetReqConsumer (SequenceNumberedThrottleUi.SequenceNumberedThrottleUi (SequenceNum.SequenceNum snum) req)
                                                                 return ()
                                         Nothing  -> Snap.modifyResponse $ Snap.setResponseCode 400]),
        ("controllable_vehicle_i/attitude_roll_stab",
         msum
           [Snap.method Snap.GET $ do (AttitudeRollStabGetRespProducer (SequenceNumberedStabConfig.SequenceNumberedStabConfig _ resp)) <- liftIO $ sendRequest conn $ AttitudeRollStabGetReqConsumer . SequenceNum.SequenceNum
                                      Snap.modifyResponse $ Snap.setContentType "application/json"
                                      writeLoggingLBS logCtx (encode resp),
            Snap.method Snap.POST $ do bytes <- Snap.readRequestBody 32768
                                       case decode bytes of
                                         Just req -> liftIO $ do _ <- sendRequest conn $ \ snum -> AttitudeRollStabSetReqConsumer (SequenceNumberedStabConfig.SequenceNumberedStabConfig (SequenceNum.SequenceNum snum) req)
                                                                 return ()
                                         Nothing  -> Snap.modifyResponse $ Snap.setResponseCode 400]),
        ("controllable_vehicle_i/attitude_pitch_stab",
         msum
           [Snap.method Snap.GET $ do (AttitudePitchStabGetRespProducer (SequenceNumberedStabConfig.SequenceNumberedStabConfig _ resp)) <- liftIO $ sendRequest conn $ AttitudePitchStabGetReqConsumer . SequenceNum.SequenceNum
                                      Snap.modifyResponse $ Snap.setContentType "application/json"
                                      writeLoggingLBS logCtx (encode resp),
            Snap.method Snap.POST $ do bytes <- Snap.readRequestBody 32768
                                       case decode bytes of
                                         Just req -> liftIO $ do _ <- sendRequest conn $ \ snum -> AttitudePitchStabSetReqConsumer (SequenceNumberedStabConfig.SequenceNumberedStabConfig (SequenceNum.SequenceNum snum) req)
                                                                 return ()
                                         Nothing  -> Snap.modifyResponse $ Snap.setResponseCode 400]),
        ("controllable_vehicle_i/yaw_rate_pid",
         msum
           [Snap.method Snap.GET $ do (YawRatePidGetRespProducer (SequenceNumberedPidConfig.SequenceNumberedPidConfig _ resp)) <- liftIO $ sendRequest conn $ YawRatePidGetReqConsumer . SequenceNum.SequenceNum
                                      Snap.modifyResponse $ Snap.setContentType "application/json"
                                      writeLoggingLBS logCtx (encode resp),
            Snap.method Snap.POST $ do bytes <- Snap.readRequestBody 32768
                                       case decode bytes of
                                         Just req -> liftIO $ do _ <- sendRequest conn $ \ snum -> YawRatePidSetReqConsumer (SequenceNumberedPidConfig.SequenceNumberedPidConfig (SequenceNum.SequenceNum snum) req)
                                                                 return ()
                                         Nothing  -> Snap.modifyResponse $ Snap.setResponseCode 400]),
        ("controllable_vehicle_i/yaw_position_pid",
         msum
           [Snap.method Snap.GET $ do (YawPositionPidGetRespProducer (SequenceNumberedPidConfig.SequenceNumberedPidConfig _ resp)) <- liftIO $ sendRequest conn $ YawPositionPidGetReqConsumer . SequenceNum.SequenceNum
                                      Snap.modifyResponse $ Snap.setContentType "application/json"
                                      writeLoggingLBS logCtx (encode resp),
            Snap.method Snap.POST $ do bytes <- Snap.readRequestBody 32768
                                       case decode bytes of
                                         Just req -> liftIO $ do _ <- sendRequest conn $ \ snum -> YawPositionPidSetReqConsumer (SequenceNumberedPidConfig.SequenceNumberedPidConfig (SequenceNum.SequenceNum snum) req)
                                                                 return ()
                                         Nothing  -> Snap.modifyResponse $ Snap.setResponseCode 400]),
        ("controllable_vehicle_i/arming_request",
         msum
           [Snap.method Snap.GET $ do (ArmingRequestGetRespProducer (SequenceNumberedTristate.SequenceNumberedTristate _ resp)) <- liftIO $ sendRequest conn $ ArmingRequestGetReqConsumer . SequenceNum.SequenceNum
                                      Snap.modifyResponse $ Snap.setContentType "application/json"
                                      writeLoggingLBS logCtx (encode resp),
            Snap.method Snap.POST $ do bytes <- Snap.readRequestBody 32768
                                       case decode bytes of
                                         Just req -> liftIO $ do _ <- sendRequest conn $ \ snum -> ArmingRequestSetReqConsumer (SequenceNumberedTristate.SequenceNumberedTristate (SequenceNum.SequenceNum snum) req)
                                                                 return ()
                                         Nothing  -> Snap.modifyResponse $ Snap.setResponseCode 400]),
        ("controllable_vehicle_i/control_modes_request",
         msum
           [Snap.method Snap.GET $ do (ControlModesRequestGetRespProducer (SequenceNumberedControlModes.SequenceNumberedControlModes _ resp)) <- liftIO $ sendRequest conn $ ControlModesRequestGetReqConsumer . SequenceNum.SequenceNum
                                      Snap.modifyResponse $ Snap.setContentType "application/json"
                                      writeLoggingLBS logCtx (encode resp),
            Snap.method Snap.POST $ do bytes <- Snap.readRequestBody 32768
                                       case decode bytes of
                                         Just req -> liftIO $ do _ <- sendRequest conn $ \ snum -> ControlModesRequestSetReqConsumer (SequenceNumberedControlModes.SequenceNumberedControlModes (SequenceNum.SequenceNum snum) req)
                                                                 return ()
                                         Nothing  -> Snap.modifyResponse $ Snap.setResponseCode 400]),
        ("controllable_vehicle_i/user_input_request",
         msum
           [Snap.method Snap.GET $ do (UserInputRequestGetRespProducer (SequenceNumberedUserInput.SequenceNumberedUserInput _ resp)) <- liftIO $ sendRequest conn $ UserInputRequestGetReqConsumer . SequenceNum.SequenceNum
                                      Snap.modifyResponse $ Snap.setContentType "application/json"
                                      writeLoggingLBS logCtx (encode resp),
            Snap.method Snap.POST $ do bytes <- Snap.readRequestBody 32768
                                       case decode bytes of
                                         Just req -> liftIO $ do _ <- sendRequest conn $ \ snum -> UserInputRequestSetReqConsumer (SequenceNumberedUserInput.SequenceNumberedUserInput (SequenceNum.SequenceNum snum) req)
                                                                 return ()
                                         Nothing  -> Snap.modifyResponse $ Snap.setResponseCode 400]),
        ("controllable_vehicle_i/rgb_led",
         msum
           [Snap.method Snap.GET $ do (RgbLedGetRespProducer (SequenceNumberedRgbLedSetting.SequenceNumberedRgbLedSetting _ resp)) <- liftIO $ sendRequest conn $ RgbLedGetReqConsumer . SequenceNum.SequenceNum
                                      Snap.modifyResponse $ Snap.setContentType "application/json"
                                      writeLoggingLBS logCtx (encode resp),
            Snap.method Snap.POST $ do bytes <- Snap.readRequestBody 32768
                                       case decode bytes of
                                         Just req -> liftIO $ do _ <- sendRequest conn $ \ snum -> RgbLedSetReqConsumer (SequenceNumberedRgbLedSetting.SequenceNumberedRgbLedSetting (SequenceNum.SequenceNum snum) req)
                                                                 return ()
                                         Nothing  -> Snap.modifyResponse $ Snap.setResponseCode 400]),
        ("controllable_vehicle_i/camera_target_input",
         Snap.method Snap.GET $ do (CameraTargetInputGetRespProducer (SequenceNumberedCameraTarget.SequenceNumberedCameraTarget _ resp)) <- liftIO $ sendRequest conn $ CameraTargetInputGetReqConsumer . SequenceNum.SequenceNum
                                   Snap.modifyResponse $ Snap.setContentType "application/json"
                                   writeLoggingLBS logCtx (encode resp))]