module SMACCMPilot.Comm.Interface.Vehicle exposing (..)
import SMACCMPilot.Comm.Types.PackedStatus
import SMACCMPilot.Comm.Types.ControlLaw
import SMACCMPilot.Comm.Types.RcInput
import SMACCMPilot.Comm.Types.UserInputResult
import SMACCMPilot.Comm.Types.SensorsResult
import SMACCMPilot.Comm.Types.GyroscopeSample
import SMACCMPilot.Comm.Types.AccelerometerSample
import SMACCMPilot.Comm.Types.BarometerSample
import SMACCMPilot.Comm.Types.LidarliteSample
import SMACCMPilot.Comm.Types.MagnetometerSample
import SMACCMPilot.Comm.Types.Px4flowIntegralSample
import SMACCMPilot.Comm.Types.Px4flowSample
import SMACCMPilot.Comm.Types.PositionSample
import SMACCMPilot.Comm.Types.ControlSetpoint
import SMACCMPilot.Comm.Types.ControlOutput
import SMACCMPilot.Comm.Types.QuadcopterMotors
import SMACCMPilot.Comm.Types.AttControlDebug
import SMACCMPilot.Comm.Types.AltControlDebug
import SMACCMPilot.Comm.Types.Px4ioState
import SMACCMPilot.Comm.Types.ArmingStatus
import SMACCMPilot.Comm.Utils as Utils
import Http
import Json.Decode
import Json.Encode
import Task
import Time exposing (Time)
{-| A type containing all of the fields and poll rates of the interface, useful for keeping state in a model -}
type alias Vehicle =
  { packedStatus : SMACCMPilot.Comm.Types.PackedStatus.PackedStatus
  , packedStatusPollRate : Maybe Time
  , controlLaw : SMACCMPilot.Comm.Types.ControlLaw.ControlLaw
  , controlLawPollRate : Maybe Time
  , rcInput : SMACCMPilot.Comm.Types.RcInput.RcInput
  , rcInputPollRate : Maybe Time
  , userInput : SMACCMPilot.Comm.Types.UserInputResult.UserInputResult
  , userInputPollRate : Maybe Time
  , sensorsOutput : SMACCMPilot.Comm.Types.SensorsResult.SensorsResult
  , sensorsOutputPollRate : Maybe Time
  , gyroOutput : SMACCMPilot.Comm.Types.GyroscopeSample.GyroscopeSample
  , gyroOutputPollRate : Maybe Time
  , accelOutput : SMACCMPilot.Comm.Types.AccelerometerSample.AccelerometerSample
  , accelOutputPollRate : Maybe Time
  , baroOutput : SMACCMPilot.Comm.Types.BarometerSample.BarometerSample
  , baroOutputPollRate : Maybe Time
  , lidarliteOutput : SMACCMPilot.Comm.Types.LidarliteSample.LidarliteSample
  , lidarliteOutputPollRate : Maybe Time
  , magOutput : SMACCMPilot.Comm.Types.MagnetometerSample.MagnetometerSample
  , magOutputPollRate : Maybe Time
  , px4flowIntOutput : SMACCMPilot.Comm.Types.Px4flowIntegralSample.Px4flowIntegralSample
  , px4flowIntOutputPollRate : Maybe Time
  , px4flowOutput : SMACCMPilot.Comm.Types.Px4flowSample.Px4flowSample
  , px4flowOutputPollRate : Maybe Time
  , gpsOutput : SMACCMPilot.Comm.Types.PositionSample.PositionSample
  , gpsOutputPollRate : Maybe Time
  , controlSetpoint : SMACCMPilot.Comm.Types.ControlSetpoint.ControlSetpoint
  , controlSetpointPollRate : Maybe Time
  , controlOutput : SMACCMPilot.Comm.Types.ControlOutput.ControlOutput
  , controlOutputPollRate : Maybe Time
  , motorOutput : SMACCMPilot.Comm.Types.QuadcopterMotors.QuadcopterMotors
  , motorOutputPollRate : Maybe Time
  , attControlDebug : SMACCMPilot.Comm.Types.AttControlDebug.AttControlDebug
  , attControlDebugPollRate : Maybe Time
  , altControlDebug : SMACCMPilot.Comm.Types.AltControlDebug.AltControlDebug
  , altControlDebugPollRate : Maybe Time
  , px4ioState : SMACCMPilot.Comm.Types.Px4ioState.Px4ioState
  , px4ioStatePollRate : Maybe Time
  , armingStatus : SMACCMPilot.Comm.Types.ArmingStatus.ArmingStatus
  , armingStatusPollRate : Maybe Time
  , batteryVoltage : Float
  , batteryVoltagePollRate : Maybe Time
  }
{-| Vehicle initialized with (arbitrary) default values -}
init : Vehicle
init =
  { packedStatus = SMACCMPilot.Comm.Types.PackedStatus.init
  , packedStatusPollRate = Nothing
  , controlLaw = SMACCMPilot.Comm.Types.ControlLaw.init
  , controlLawPollRate = Nothing
  , rcInput = SMACCMPilot.Comm.Types.RcInput.init
  , rcInputPollRate = Nothing
  , userInput = SMACCMPilot.Comm.Types.UserInputResult.init
  , userInputPollRate = Nothing
  , sensorsOutput = SMACCMPilot.Comm.Types.SensorsResult.init
  , sensorsOutputPollRate = Nothing
  , gyroOutput = SMACCMPilot.Comm.Types.GyroscopeSample.init
  , gyroOutputPollRate = Nothing
  , accelOutput = SMACCMPilot.Comm.Types.AccelerometerSample.init
  , accelOutputPollRate = Nothing
  , baroOutput = SMACCMPilot.Comm.Types.BarometerSample.init
  , baroOutputPollRate = Nothing
  , lidarliteOutput = SMACCMPilot.Comm.Types.LidarliteSample.init
  , lidarliteOutputPollRate = Nothing
  , magOutput = SMACCMPilot.Comm.Types.MagnetometerSample.init
  , magOutputPollRate = Nothing
  , px4flowIntOutput = SMACCMPilot.Comm.Types.Px4flowIntegralSample.init
  , px4flowIntOutputPollRate = Nothing
  , px4flowOutput = SMACCMPilot.Comm.Types.Px4flowSample.init
  , px4flowOutputPollRate = Nothing
  , gpsOutput = SMACCMPilot.Comm.Types.PositionSample.init
  , gpsOutputPollRate = Nothing
  , controlSetpoint = SMACCMPilot.Comm.Types.ControlSetpoint.init
  , controlSetpointPollRate = Nothing
  , controlOutput = SMACCMPilot.Comm.Types.ControlOutput.init
  , controlOutputPollRate = Nothing
  , motorOutput = SMACCMPilot.Comm.Types.QuadcopterMotors.init
  , motorOutputPollRate = Nothing
  , attControlDebug = SMACCMPilot.Comm.Types.AttControlDebug.init
  , attControlDebugPollRate = Nothing
  , altControlDebug = SMACCMPilot.Comm.Types.AltControlDebug.init
  , altControlDebugPollRate = Nothing
  , px4ioState = SMACCMPilot.Comm.Types.Px4ioState.init
  , px4ioStatePollRate = Nothing
  , armingStatus = SMACCMPilot.Comm.Types.ArmingStatus.init
  , armingStatusPollRate = Nothing
  , batteryVoltage = 0
  , batteryVoltagePollRate = Nothing
  }
{-| Client interface for Vehicle backed by a Gidl-generated RPC server -}
type alias Client msg =
  { getPackedStatus : Cmd msg
  , pollPackedStatus : Maybe Time -> Cmd msg
  , getControlLaw : Cmd msg
  , pollControlLaw : Maybe Time -> Cmd msg
  , getRcInput : Cmd msg
  , pollRcInput : Maybe Time -> Cmd msg
  , getUserInput : Cmd msg
  , pollUserInput : Maybe Time -> Cmd msg
  , getSensorsOutput : Cmd msg
  , pollSensorsOutput : Maybe Time -> Cmd msg
  , getGyroOutput : Cmd msg
  , pollGyroOutput : Maybe Time -> Cmd msg
  , getAccelOutput : Cmd msg
  , pollAccelOutput : Maybe Time -> Cmd msg
  , getBaroOutput : Cmd msg
  , pollBaroOutput : Maybe Time -> Cmd msg
  , getLidarliteOutput : Cmd msg
  , pollLidarliteOutput : Maybe Time -> Cmd msg
  , getMagOutput : Cmd msg
  , pollMagOutput : Maybe Time -> Cmd msg
  , getPx4flowIntOutput : Cmd msg
  , pollPx4flowIntOutput : Maybe Time -> Cmd msg
  , getPx4flowOutput : Cmd msg
  , pollPx4flowOutput : Maybe Time -> Cmd msg
  , getGpsOutput : Cmd msg
  , pollGpsOutput : Maybe Time -> Cmd msg
  , getControlSetpoint : Cmd msg
  , pollControlSetpoint : Maybe Time -> Cmd msg
  , getControlOutput : Cmd msg
  , pollControlOutput : Maybe Time -> Cmd msg
  , getMotorOutput : Cmd msg
  , pollMotorOutput : Maybe Time -> Cmd msg
  , getAttControlDebug : Cmd msg
  , pollAttControlDebug : Maybe Time -> Cmd msg
  , getAltControlDebug : Cmd msg
  , pollAltControlDebug : Maybe Time -> Cmd msg
  , getPx4ioState : Cmd msg
  , pollPx4ioState : Maybe Time -> Cmd msg
  , getArmingStatus : Cmd msg
  , pollArmingStatus : Maybe Time -> Cmd msg
  , getBatteryVoltage : Cmd msg
  , pollBatteryVoltage : Maybe Time -> Cmd msg
  }
{-| Msg variants. Not recommended for use directly, instead use the `Handler` interface -}
type Msg
  = GotPackedStatus SMACCMPilot.Comm.Types.PackedStatus.PackedStatus
  | PollPackedStatus
  | PollRatePackedStatus (Maybe Time)
  | GotControlLaw SMACCMPilot.Comm.Types.ControlLaw.ControlLaw
  | PollControlLaw
  | PollRateControlLaw (Maybe Time)
  | GotRcInput SMACCMPilot.Comm.Types.RcInput.RcInput
  | PollRcInput
  | PollRateRcInput (Maybe Time)
  | GotUserInput SMACCMPilot.Comm.Types.UserInputResult.UserInputResult
  | PollUserInput
  | PollRateUserInput (Maybe Time)
  | GotSensorsOutput SMACCMPilot.Comm.Types.SensorsResult.SensorsResult
  | PollSensorsOutput
  | PollRateSensorsOutput (Maybe Time)
  | GotGyroOutput SMACCMPilot.Comm.Types.GyroscopeSample.GyroscopeSample
  | PollGyroOutput
  | PollRateGyroOutput (Maybe Time)
  | GotAccelOutput SMACCMPilot.Comm.Types.AccelerometerSample.AccelerometerSample
  | PollAccelOutput
  | PollRateAccelOutput (Maybe Time)
  | GotBaroOutput SMACCMPilot.Comm.Types.BarometerSample.BarometerSample
  | PollBaroOutput
  | PollRateBaroOutput (Maybe Time)
  | GotLidarliteOutput SMACCMPilot.Comm.Types.LidarliteSample.LidarliteSample
  | PollLidarliteOutput
  | PollRateLidarliteOutput (Maybe Time)
  | GotMagOutput SMACCMPilot.Comm.Types.MagnetometerSample.MagnetometerSample
  | PollMagOutput
  | PollRateMagOutput (Maybe Time)
  | GotPx4flowIntOutput SMACCMPilot.Comm.Types.Px4flowIntegralSample.Px4flowIntegralSample
  | PollPx4flowIntOutput
  | PollRatePx4flowIntOutput (Maybe Time)
  | GotPx4flowOutput SMACCMPilot.Comm.Types.Px4flowSample.Px4flowSample
  | PollPx4flowOutput
  | PollRatePx4flowOutput (Maybe Time)
  | GotGpsOutput SMACCMPilot.Comm.Types.PositionSample.PositionSample
  | PollGpsOutput
  | PollRateGpsOutput (Maybe Time)
  | GotControlSetpoint SMACCMPilot.Comm.Types.ControlSetpoint.ControlSetpoint
  | PollControlSetpoint
  | PollRateControlSetpoint (Maybe Time)
  | GotControlOutput SMACCMPilot.Comm.Types.ControlOutput.ControlOutput
  | PollControlOutput
  | PollRateControlOutput (Maybe Time)
  | GotMotorOutput SMACCMPilot.Comm.Types.QuadcopterMotors.QuadcopterMotors
  | PollMotorOutput
  | PollRateMotorOutput (Maybe Time)
  | GotAttControlDebug SMACCMPilot.Comm.Types.AttControlDebug.AttControlDebug
  | PollAttControlDebug
  | PollRateAttControlDebug (Maybe Time)
  | GotAltControlDebug SMACCMPilot.Comm.Types.AltControlDebug.AltControlDebug
  | PollAltControlDebug
  | PollRateAltControlDebug (Maybe Time)
  | GotPx4ioState SMACCMPilot.Comm.Types.Px4ioState.Px4ioState
  | PollPx4ioState
  | PollRatePx4ioState (Maybe Time)
  | GotArmingStatus SMACCMPilot.Comm.Types.ArmingStatus.ArmingStatus
  | PollArmingStatus
  | PollRateArmingStatus (Maybe Time)
  | GotBatteryVoltage Float
  | PollBatteryVoltage
  | PollRateBatteryVoltage (Maybe Time)
{-| Determine whether a `Msg` arose from a network call -}
networkMsg : Msg -> Bool
networkMsg msg =
  case msg of
    GotPackedStatus _ -> True
    GotControlLaw _ -> True
    GotRcInput _ -> True
    GotUserInput _ -> True
    GotSensorsOutput _ -> True
    GotGyroOutput _ -> True
    GotAccelOutput _ -> True
    GotBaroOutput _ -> True
    GotLidarliteOutput _ -> True
    GotMagOutput _ -> True
    GotPx4flowIntOutput _ -> True
    GotPx4flowOutput _ -> True
    GotGpsOutput _ -> True
    GotControlSetpoint _ -> True
    GotControlOutput _ -> True
    GotMotorOutput _ -> True
    GotAttControlDebug _ -> True
    GotAltControlDebug _ -> True
    GotPx4ioState _ -> True
    GotArmingStatus _ -> True
    GotBatteryVoltage _ -> True
    _ -> False
{-| Given an error handler, a builder for your `msg` type, and a base URL for the RPC server, build a `Client` -}
client : Time.Time -> (Http.Error -> msg) -> (Msg -> msg) -> String -> Client msg
client to err ok url =
  { getPackedStatus = Utils.send_ err (ok << GotPackedStatus) (Utils.get_ to (url ++ "/vehicle_i/packed_status") SMACCMPilot.Comm.Types.PackedStatus.decode)
  , getControlLaw = Utils.send_ err (ok << GotControlLaw) (Utils.get_ to (url ++ "/vehicle_i/control_law") SMACCMPilot.Comm.Types.ControlLaw.decode)
  , getRcInput = Utils.send_ err (ok << GotRcInput) (Utils.get_ to (url ++ "/vehicle_i/rc_input") SMACCMPilot.Comm.Types.RcInput.decode)
  , getUserInput = Utils.send_ err (ok << GotUserInput) (Utils.get_ to (url ++ "/vehicle_i/user_input") SMACCMPilot.Comm.Types.UserInputResult.decode)
  , getSensorsOutput = Utils.send_ err (ok << GotSensorsOutput) (Utils.get_ to (url ++ "/vehicle_i/sensors_output") SMACCMPilot.Comm.Types.SensorsResult.decode)
  , getGyroOutput = Utils.send_ err (ok << GotGyroOutput) (Utils.get_ to (url ++ "/vehicle_i/gyro_output") SMACCMPilot.Comm.Types.GyroscopeSample.decode)
  , getAccelOutput = Utils.send_ err (ok << GotAccelOutput) (Utils.get_ to (url ++ "/vehicle_i/accel_output") SMACCMPilot.Comm.Types.AccelerometerSample.decode)
  , getBaroOutput = Utils.send_ err (ok << GotBaroOutput) (Utils.get_ to (url ++ "/vehicle_i/baro_output") SMACCMPilot.Comm.Types.BarometerSample.decode)
  , getLidarliteOutput = Utils.send_ err (ok << GotLidarliteOutput) (Utils.get_ to (url ++ "/vehicle_i/lidarlite_output") SMACCMPilot.Comm.Types.LidarliteSample.decode)
  , getMagOutput = Utils.send_ err (ok << GotMagOutput) (Utils.get_ to (url ++ "/vehicle_i/mag_output") SMACCMPilot.Comm.Types.MagnetometerSample.decode)
  , getPx4flowIntOutput = Utils.send_ err (ok << GotPx4flowIntOutput) (Utils.get_ to (url ++ "/vehicle_i/px4flow_int_output") SMACCMPilot.Comm.Types.Px4flowIntegralSample.decode)
  , getPx4flowOutput = Utils.send_ err (ok << GotPx4flowOutput) (Utils.get_ to (url ++ "/vehicle_i/px4flow_output") SMACCMPilot.Comm.Types.Px4flowSample.decode)
  , getGpsOutput = Utils.send_ err (ok << GotGpsOutput) (Utils.get_ to (url ++ "/vehicle_i/gps_output") SMACCMPilot.Comm.Types.PositionSample.decode)
  , getControlSetpoint = Utils.send_ err (ok << GotControlSetpoint) (Utils.get_ to (url ++ "/vehicle_i/control_setpoint") SMACCMPilot.Comm.Types.ControlSetpoint.decode)
  , getControlOutput = Utils.send_ err (ok << GotControlOutput) (Utils.get_ to (url ++ "/vehicle_i/control_output") SMACCMPilot.Comm.Types.ControlOutput.decode)
  , getMotorOutput = Utils.send_ err (ok << GotMotorOutput) (Utils.get_ to (url ++ "/vehicle_i/motor_output") SMACCMPilot.Comm.Types.QuadcopterMotors.decode)
  , getAttControlDebug = Utils.send_ err (ok << GotAttControlDebug) (Utils.get_ to (url ++ "/vehicle_i/att_control_debug") SMACCMPilot.Comm.Types.AttControlDebug.decode)
  , getAltControlDebug = Utils.send_ err (ok << GotAltControlDebug) (Utils.get_ to (url ++ "/vehicle_i/alt_control_debug") SMACCMPilot.Comm.Types.AltControlDebug.decode)
  , getPx4ioState = Utils.send_ err (ok << GotPx4ioState) (Utils.get_ to (url ++ "/vehicle_i/px4io_state") SMACCMPilot.Comm.Types.Px4ioState.decode)
  , getArmingStatus = Utils.send_ err (ok << GotArmingStatus) (Utils.get_ to (url ++ "/vehicle_i/arming_status") SMACCMPilot.Comm.Types.ArmingStatus.decode)
  , getBatteryVoltage = Utils.send_ err (ok << GotBatteryVoltage) (Utils.get_ to (url ++ "/vehicle_i/battery_voltage") Json.Decode.float)
  , pollPackedStatus = \mt -> Task.perform (always (ok (PollRatePackedStatus mt))) (Task.succeed ())
  , pollControlLaw = \mt -> Task.perform (always (ok (PollRateControlLaw mt))) (Task.succeed ())
  , pollRcInput = \mt -> Task.perform (always (ok (PollRateRcInput mt))) (Task.succeed ())
  , pollUserInput = \mt -> Task.perform (always (ok (PollRateUserInput mt))) (Task.succeed ())
  , pollSensorsOutput = \mt -> Task.perform (always (ok (PollRateSensorsOutput mt))) (Task.succeed ())
  , pollGyroOutput = \mt -> Task.perform (always (ok (PollRateGyroOutput mt))) (Task.succeed ())
  , pollAccelOutput = \mt -> Task.perform (always (ok (PollRateAccelOutput mt))) (Task.succeed ())
  , pollBaroOutput = \mt -> Task.perform (always (ok (PollRateBaroOutput mt))) (Task.succeed ())
  , pollLidarliteOutput = \mt -> Task.perform (always (ok (PollRateLidarliteOutput mt))) (Task.succeed ())
  , pollMagOutput = \mt -> Task.perform (always (ok (PollRateMagOutput mt))) (Task.succeed ())
  , pollPx4flowIntOutput = \mt -> Task.perform (always (ok (PollRatePx4flowIntOutput mt))) (Task.succeed ())
  , pollPx4flowOutput = \mt -> Task.perform (always (ok (PollRatePx4flowOutput mt))) (Task.succeed ())
  , pollGpsOutput = \mt -> Task.perform (always (ok (PollRateGpsOutput mt))) (Task.succeed ())
  , pollControlSetpoint = \mt -> Task.perform (always (ok (PollRateControlSetpoint mt))) (Task.succeed ())
  , pollControlOutput = \mt -> Task.perform (always (ok (PollRateControlOutput mt))) (Task.succeed ())
  , pollMotorOutput = \mt -> Task.perform (always (ok (PollRateMotorOutput mt))) (Task.succeed ())
  , pollAttControlDebug = \mt -> Task.perform (always (ok (PollRateAttControlDebug mt))) (Task.succeed ())
  , pollAltControlDebug = \mt -> Task.perform (always (ok (PollRateAltControlDebug mt))) (Task.succeed ())
  , pollPx4ioState = \mt -> Task.perform (always (ok (PollRatePx4ioState mt))) (Task.succeed ())
  , pollArmingStatus = \mt -> Task.perform (always (ok (PollRateArmingStatus mt))) (Task.succeed ())
  , pollBatteryVoltage = \mt -> Task.perform (always (ok (PollRateBatteryVoltage mt))) (Task.succeed ())
  }
{-| The `Handler` is how the client should integrate with your Elm Architecture `update` function -}
type alias Handler model msg =
  { handleGotPackedStatus : SMACCMPilot.Comm.Types.PackedStatus.PackedStatus -> model -> (model, Cmd msg)
  , handleGotControlLaw : SMACCMPilot.Comm.Types.ControlLaw.ControlLaw -> model -> (model, Cmd msg)
  , handleGotRcInput : SMACCMPilot.Comm.Types.RcInput.RcInput -> model -> (model, Cmd msg)
  , handleGotUserInput : SMACCMPilot.Comm.Types.UserInputResult.UserInputResult -> model -> (model, Cmd msg)
  , handleGotSensorsOutput : SMACCMPilot.Comm.Types.SensorsResult.SensorsResult -> model -> (model, Cmd msg)
  , handleGotGyroOutput : SMACCMPilot.Comm.Types.GyroscopeSample.GyroscopeSample -> model -> (model, Cmd msg)
  , handleGotAccelOutput : SMACCMPilot.Comm.Types.AccelerometerSample.AccelerometerSample -> model -> (model, Cmd msg)
  , handleGotBaroOutput : SMACCMPilot.Comm.Types.BarometerSample.BarometerSample -> model -> (model, Cmd msg)
  , handleGotLidarliteOutput : SMACCMPilot.Comm.Types.LidarliteSample.LidarliteSample -> model -> (model, Cmd msg)
  , handleGotMagOutput : SMACCMPilot.Comm.Types.MagnetometerSample.MagnetometerSample -> model -> (model, Cmd msg)
  , handleGotPx4flowIntOutput : SMACCMPilot.Comm.Types.Px4flowIntegralSample.Px4flowIntegralSample -> model -> (model, Cmd msg)
  , handleGotPx4flowOutput : SMACCMPilot.Comm.Types.Px4flowSample.Px4flowSample -> model -> (model, Cmd msg)
  , handleGotGpsOutput : SMACCMPilot.Comm.Types.PositionSample.PositionSample -> model -> (model, Cmd msg)
  , handleGotControlSetpoint : SMACCMPilot.Comm.Types.ControlSetpoint.ControlSetpoint -> model -> (model, Cmd msg)
  , handleGotControlOutput : SMACCMPilot.Comm.Types.ControlOutput.ControlOutput -> model -> (model, Cmd msg)
  , handleGotMotorOutput : SMACCMPilot.Comm.Types.QuadcopterMotors.QuadcopterMotors -> model -> (model, Cmd msg)
  , handleGotAttControlDebug : SMACCMPilot.Comm.Types.AttControlDebug.AttControlDebug -> model -> (model, Cmd msg)
  , handleGotAltControlDebug : SMACCMPilot.Comm.Types.AltControlDebug.AltControlDebug -> model -> (model, Cmd msg)
  , handleGotPx4ioState : SMACCMPilot.Comm.Types.Px4ioState.Px4ioState -> model -> (model, Cmd msg)
  , handleGotArmingStatus : SMACCMPilot.Comm.Types.ArmingStatus.ArmingStatus -> model -> (model, Cmd msg)
  , handleGotBatteryVoltage : Float -> model -> (model, Cmd msg)
  , handlePollPackedStatus : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollControlLaw : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollRcInput : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollUserInput : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollSensorsOutput : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollGyroOutput : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollAccelOutput : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollBaroOutput : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollLidarliteOutput : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollMagOutput : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollPx4flowIntOutput : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollPx4flowOutput : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollGpsOutput : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollControlSetpoint : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollControlOutput : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollMotorOutput : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollAttControlDebug : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollAltControlDebug : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollPx4ioState : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollArmingStatus : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollBatteryVoltage : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollRatePackedStatus : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateControlLaw : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateRcInput : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateUserInput : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateSensorsOutput : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateGyroOutput : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateAccelOutput : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateBaroOutput : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateLidarliteOutput : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateMagOutput : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRatePx4flowIntOutput : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRatePx4flowOutput : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateGpsOutput : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateControlSetpoint : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateControlOutput : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateMotorOutput : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateAttControlDebug : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateAltControlDebug : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRatePx4ioState : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateArmingStatus : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateBatteryVoltage : Maybe Time -> model -> (model, Cmd msg)
  }
{-| The `defaultHandler` does nothing for any messages; override the operations you need with your logic -}
defaultHandler : Handler model msg
defaultHandler = updatingHandler (\m _ -> m)
{-| The `updatingHandler` updates a field in your model when new data arrives. You must provide a suitable update function that updates the Vehicle in your model -}
updatingHandler : (model -> (Vehicle -> Vehicle) -> model) -> Handler model msg
updatingHandler upd =
  { handleGotPackedStatus = \x m -> (upd m (\i -> {i | packedStatus = x}), Cmd.none)
  , handleGotControlLaw = \x m -> (upd m (\i -> {i | controlLaw = x}), Cmd.none)
  , handleGotRcInput = \x m -> (upd m (\i -> {i | rcInput = x}), Cmd.none)
  , handleGotUserInput = \x m -> (upd m (\i -> {i | userInput = x}), Cmd.none)
  , handleGotSensorsOutput = \x m -> (upd m (\i -> {i | sensorsOutput = x}), Cmd.none)
  , handleGotGyroOutput = \x m -> (upd m (\i -> {i | gyroOutput = x}), Cmd.none)
  , handleGotAccelOutput = \x m -> (upd m (\i -> {i | accelOutput = x}), Cmd.none)
  , handleGotBaroOutput = \x m -> (upd m (\i -> {i | baroOutput = x}), Cmd.none)
  , handleGotLidarliteOutput = \x m -> (upd m (\i -> {i | lidarliteOutput = x}), Cmd.none)
  , handleGotMagOutput = \x m -> (upd m (\i -> {i | magOutput = x}), Cmd.none)
  , handleGotPx4flowIntOutput = \x m -> (upd m (\i -> {i | px4flowIntOutput = x}), Cmd.none)
  , handleGotPx4flowOutput = \x m -> (upd m (\i -> {i | px4flowOutput = x}), Cmd.none)
  , handleGotGpsOutput = \x m -> (upd m (\i -> {i | gpsOutput = x}), Cmd.none)
  , handleGotControlSetpoint = \x m -> (upd m (\i -> {i | controlSetpoint = x}), Cmd.none)
  , handleGotControlOutput = \x m -> (upd m (\i -> {i | controlOutput = x}), Cmd.none)
  , handleGotMotorOutput = \x m -> (upd m (\i -> {i | motorOutput = x}), Cmd.none)
  , handleGotAttControlDebug = \x m -> (upd m (\i -> {i | attControlDebug = x}), Cmd.none)
  , handleGotAltControlDebug = \x m -> (upd m (\i -> {i | altControlDebug = x}), Cmd.none)
  , handleGotPx4ioState = \x m -> (upd m (\i -> {i | px4ioState = x}), Cmd.none)
  , handleGotArmingStatus = \x m -> (upd m (\i -> {i | armingStatus = x}), Cmd.none)
  , handleGotBatteryVoltage = \x m -> (upd m (\i -> {i | batteryVoltage = x}), Cmd.none)
  , handlePollPackedStatus = \cl m -> (m , (cl m).getPackedStatus)
  , handlePollControlLaw = \cl m -> (m , (cl m).getControlLaw)
  , handlePollRcInput = \cl m -> (m , (cl m).getRcInput)
  , handlePollUserInput = \cl m -> (m , (cl m).getUserInput)
  , handlePollSensorsOutput = \cl m -> (m , (cl m).getSensorsOutput)
  , handlePollGyroOutput = \cl m -> (m , (cl m).getGyroOutput)
  , handlePollAccelOutput = \cl m -> (m , (cl m).getAccelOutput)
  , handlePollBaroOutput = \cl m -> (m , (cl m).getBaroOutput)
  , handlePollLidarliteOutput = \cl m -> (m , (cl m).getLidarliteOutput)
  , handlePollMagOutput = \cl m -> (m , (cl m).getMagOutput)
  , handlePollPx4flowIntOutput = \cl m -> (m , (cl m).getPx4flowIntOutput)
  , handlePollPx4flowOutput = \cl m -> (m , (cl m).getPx4flowOutput)
  , handlePollGpsOutput = \cl m -> (m , (cl m).getGpsOutput)
  , handlePollControlSetpoint = \cl m -> (m , (cl m).getControlSetpoint)
  , handlePollControlOutput = \cl m -> (m , (cl m).getControlOutput)
  , handlePollMotorOutput = \cl m -> (m , (cl m).getMotorOutput)
  , handlePollAttControlDebug = \cl m -> (m , (cl m).getAttControlDebug)
  , handlePollAltControlDebug = \cl m -> (m , (cl m).getAltControlDebug)
  , handlePollPx4ioState = \cl m -> (m , (cl m).getPx4ioState)
  , handlePollArmingStatus = \cl m -> (m , (cl m).getArmingStatus)
  , handlePollBatteryVoltage = \cl m -> (m , (cl m).getBatteryVoltage)
  , handlePollRatePackedStatus = \mt m -> (upd m (\i -> {i | packedStatusPollRate = mt}), Cmd.none)
  , handlePollRateControlLaw = \mt m -> (upd m (\i -> {i | controlLawPollRate = mt}), Cmd.none)
  , handlePollRateRcInput = \mt m -> (upd m (\i -> {i | rcInputPollRate = mt}), Cmd.none)
  , handlePollRateUserInput = \mt m -> (upd m (\i -> {i | userInputPollRate = mt}), Cmd.none)
  , handlePollRateSensorsOutput = \mt m -> (upd m (\i -> {i | sensorsOutputPollRate = mt}), Cmd.none)
  , handlePollRateGyroOutput = \mt m -> (upd m (\i -> {i | gyroOutputPollRate = mt}), Cmd.none)
  , handlePollRateAccelOutput = \mt m -> (upd m (\i -> {i | accelOutputPollRate = mt}), Cmd.none)
  , handlePollRateBaroOutput = \mt m -> (upd m (\i -> {i | baroOutputPollRate = mt}), Cmd.none)
  , handlePollRateLidarliteOutput = \mt m -> (upd m (\i -> {i | lidarliteOutputPollRate = mt}), Cmd.none)
  , handlePollRateMagOutput = \mt m -> (upd m (\i -> {i | magOutputPollRate = mt}), Cmd.none)
  , handlePollRatePx4flowIntOutput = \mt m -> (upd m (\i -> {i | px4flowIntOutputPollRate = mt}), Cmd.none)
  , handlePollRatePx4flowOutput = \mt m -> (upd m (\i -> {i | px4flowOutputPollRate = mt}), Cmd.none)
  , handlePollRateGpsOutput = \mt m -> (upd m (\i -> {i | gpsOutputPollRate = mt}), Cmd.none)
  , handlePollRateControlSetpoint = \mt m -> (upd m (\i -> {i | controlSetpointPollRate = mt}), Cmd.none)
  , handlePollRateControlOutput = \mt m -> (upd m (\i -> {i | controlOutputPollRate = mt}), Cmd.none)
  , handlePollRateMotorOutput = \mt m -> (upd m (\i -> {i | motorOutputPollRate = mt}), Cmd.none)
  , handlePollRateAttControlDebug = \mt m -> (upd m (\i -> {i | attControlDebugPollRate = mt}), Cmd.none)
  , handlePollRateAltControlDebug = \mt m -> (upd m (\i -> {i | altControlDebugPollRate = mt}), Cmd.none)
  , handlePollRatePx4ioState = \mt m -> (upd m (\i -> {i | px4ioStatePollRate = mt}), Cmd.none)
  , handlePollRateArmingStatus = \mt m -> (upd m (\i -> {i | armingStatusPollRate = mt}), Cmd.none)
  , handlePollRateBatteryVoltage = \mt m -> (upd m (\i -> {i | batteryVoltagePollRate = mt}), Cmd.none)
  }
{-| Driver for a `Handler`; use in your `update` function -}
handle : Handler model msg -> (model -> Client msg) -> Msg -> model -> (model, Cmd msg)
handle h cl r m =
  case r of
    GotPackedStatus x -> h.handleGotPackedStatus x m
    GotControlLaw x -> h.handleGotControlLaw x m
    GotRcInput x -> h.handleGotRcInput x m
    GotUserInput x -> h.handleGotUserInput x m
    GotSensorsOutput x -> h.handleGotSensorsOutput x m
    GotGyroOutput x -> h.handleGotGyroOutput x m
    GotAccelOutput x -> h.handleGotAccelOutput x m
    GotBaroOutput x -> h.handleGotBaroOutput x m
    GotLidarliteOutput x -> h.handleGotLidarliteOutput x m
    GotMagOutput x -> h.handleGotMagOutput x m
    GotPx4flowIntOutput x -> h.handleGotPx4flowIntOutput x m
    GotPx4flowOutput x -> h.handleGotPx4flowOutput x m
    GotGpsOutput x -> h.handleGotGpsOutput x m
    GotControlSetpoint x -> h.handleGotControlSetpoint x m
    GotControlOutput x -> h.handleGotControlOutput x m
    GotMotorOutput x -> h.handleGotMotorOutput x m
    GotAttControlDebug x -> h.handleGotAttControlDebug x m
    GotAltControlDebug x -> h.handleGotAltControlDebug x m
    GotPx4ioState x -> h.handleGotPx4ioState x m
    GotArmingStatus x -> h.handleGotArmingStatus x m
    GotBatteryVoltage x -> h.handleGotBatteryVoltage x m
    PollPackedStatus -> h.handlePollPackedStatus cl m
    PollControlLaw -> h.handlePollControlLaw cl m
    PollRcInput -> h.handlePollRcInput cl m
    PollUserInput -> h.handlePollUserInput cl m
    PollSensorsOutput -> h.handlePollSensorsOutput cl m
    PollGyroOutput -> h.handlePollGyroOutput cl m
    PollAccelOutput -> h.handlePollAccelOutput cl m
    PollBaroOutput -> h.handlePollBaroOutput cl m
    PollLidarliteOutput -> h.handlePollLidarliteOutput cl m
    PollMagOutput -> h.handlePollMagOutput cl m
    PollPx4flowIntOutput -> h.handlePollPx4flowIntOutput cl m
    PollPx4flowOutput -> h.handlePollPx4flowOutput cl m
    PollGpsOutput -> h.handlePollGpsOutput cl m
    PollControlSetpoint -> h.handlePollControlSetpoint cl m
    PollControlOutput -> h.handlePollControlOutput cl m
    PollMotorOutput -> h.handlePollMotorOutput cl m
    PollAttControlDebug -> h.handlePollAttControlDebug cl m
    PollAltControlDebug -> h.handlePollAltControlDebug cl m
    PollPx4ioState -> h.handlePollPx4ioState cl m
    PollArmingStatus -> h.handlePollArmingStatus cl m
    PollBatteryVoltage -> h.handlePollBatteryVoltage cl m
    PollRatePackedStatus mt -> h.handlePollRatePackedStatus mt m
    PollRateControlLaw mt -> h.handlePollRateControlLaw mt m
    PollRateRcInput mt -> h.handlePollRateRcInput mt m
    PollRateUserInput mt -> h.handlePollRateUserInput mt m
    PollRateSensorsOutput mt -> h.handlePollRateSensorsOutput mt m
    PollRateGyroOutput mt -> h.handlePollRateGyroOutput mt m
    PollRateAccelOutput mt -> h.handlePollRateAccelOutput mt m
    PollRateBaroOutput mt -> h.handlePollRateBaroOutput mt m
    PollRateLidarliteOutput mt -> h.handlePollRateLidarliteOutput mt m
    PollRateMagOutput mt -> h.handlePollRateMagOutput mt m
    PollRatePx4flowIntOutput mt -> h.handlePollRatePx4flowIntOutput mt m
    PollRatePx4flowOutput mt -> h.handlePollRatePx4flowOutput mt m
    PollRateGpsOutput mt -> h.handlePollRateGpsOutput mt m
    PollRateControlSetpoint mt -> h.handlePollRateControlSetpoint mt m
    PollRateControlOutput mt -> h.handlePollRateControlOutput mt m
    PollRateMotorOutput mt -> h.handlePollRateMotorOutput mt m
    PollRateAttControlDebug mt -> h.handlePollRateAttControlDebug mt m
    PollRateAltControlDebug mt -> h.handlePollRateAltControlDebug mt m
    PollRatePx4ioState mt -> h.handlePollRatePx4ioState mt m
    PollRateArmingStatus mt -> h.handlePollRateArmingStatus mt m
    PollRateBatteryVoltage mt -> h.handlePollRateBatteryVoltage mt m
{-| Generate subscriptions from the poll rates in the `Vehicle` -}
subscriptions : Vehicle -> (Msg -> msg) -> List (Sub.Sub msg)
subscriptions i toMsg =
  [ Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollPackedStatus))) i.packedStatusPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollControlLaw))) i.controlLawPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollRcInput))) i.rcInputPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollUserInput))) i.userInputPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollSensorsOutput))) i.sensorsOutputPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollGyroOutput))) i.gyroOutputPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollAccelOutput))) i.accelOutputPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollBaroOutput))) i.baroOutputPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollLidarliteOutput))) i.lidarliteOutputPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollMagOutput))) i.magOutputPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollPx4flowIntOutput))) i.px4flowIntOutputPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollPx4flowOutput))) i.px4flowOutputPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollGpsOutput))) i.gpsOutputPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollControlSetpoint))) i.controlSetpointPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollControlOutput))) i.controlOutputPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollMotorOutput))) i.motorOutputPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollAttControlDebug))) i.attControlDebugPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollAltControlDebug))) i.altControlDebugPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollPx4ioState))) i.px4ioStatePollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollArmingStatus))) i.armingStatusPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollBatteryVoltage))) i.batteryVoltagePollRate)
  ]
{-| Map over the polling rates that are not disabled -}
mapPollRates : (Time -> Time) -> Vehicle -> Vehicle
mapPollRates f i =
  {i   | packedStatusPollRate = Maybe.map f i.packedStatusPollRate
       , controlLawPollRate = Maybe.map f i.controlLawPollRate
       , rcInputPollRate = Maybe.map f i.rcInputPollRate
       , userInputPollRate = Maybe.map f i.userInputPollRate
       , sensorsOutputPollRate = Maybe.map f i.sensorsOutputPollRate
       , gyroOutputPollRate = Maybe.map f i.gyroOutputPollRate
       , accelOutputPollRate = Maybe.map f i.accelOutputPollRate
       , baroOutputPollRate = Maybe.map f i.baroOutputPollRate
       , lidarliteOutputPollRate = Maybe.map f i.lidarliteOutputPollRate
       , magOutputPollRate = Maybe.map f i.magOutputPollRate
       , px4flowIntOutputPollRate = Maybe.map f i.px4flowIntOutputPollRate
       , px4flowOutputPollRate = Maybe.map f i.px4flowOutputPollRate
       , gpsOutputPollRate = Maybe.map f i.gpsOutputPollRate
       , controlSetpointPollRate = Maybe.map f i.controlSetpointPollRate
       , controlOutputPollRate = Maybe.map f i.controlOutputPollRate
       , motorOutputPollRate = Maybe.map f i.motorOutputPollRate
       , attControlDebugPollRate = Maybe.map f i.attControlDebugPollRate
       , altControlDebugPollRate = Maybe.map f i.altControlDebugPollRate
       , px4ioStatePollRate = Maybe.map f i.px4ioStatePollRate
       , armingStatusPollRate = Maybe.map f i.armingStatusPollRate
       , batteryVoltagePollRate = Maybe.map f i.batteryVoltagePollRate}