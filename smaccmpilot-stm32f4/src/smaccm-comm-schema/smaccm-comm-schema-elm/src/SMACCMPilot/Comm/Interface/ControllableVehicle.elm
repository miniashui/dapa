module SMACCMPilot.Comm.Interface.ControllableVehicle exposing (..)
import SMACCMPilot.Comm.Types.PidConfig
import SMACCMPilot.Comm.Types.ThrottleUi
import SMACCMPilot.Comm.Types.StabConfig
import SMACCMPilot.Comm.Types.Tristate
import SMACCMPilot.Comm.Types.ControlModes
import SMACCMPilot.Comm.Types.UserInput
import SMACCMPilot.Comm.Types.RgbLedSetting
import SMACCMPilot.Comm.Types.CameraTarget
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
import SMACCMPilot.Comm.Types.RebootReq
import SMACCMPilot.Comm.Utils as Utils
import Http
import Json.Decode
import Json.Encode
import Task
import Time exposing (Time)
{-| A type containing all of the fields and poll rates of the interface, useful for keeping state in a model -}
type alias ControllableVehicle =
  { nominalThrottle : Float
  , nominalThrottlePollRate : Maybe Time
  , altitudeRatePid : SMACCMPilot.Comm.Types.PidConfig.PidConfig
  , altitudeRatePidPollRate : Maybe Time
  , altitudePositionPid : SMACCMPilot.Comm.Types.PidConfig.PidConfig
  , altitudePositionPidPollRate : Maybe Time
  , throttleUi : SMACCMPilot.Comm.Types.ThrottleUi.ThrottleUi
  , throttleUiPollRate : Maybe Time
  , attitudeRollStab : SMACCMPilot.Comm.Types.StabConfig.StabConfig
  , attitudeRollStabPollRate : Maybe Time
  , attitudePitchStab : SMACCMPilot.Comm.Types.StabConfig.StabConfig
  , attitudePitchStabPollRate : Maybe Time
  , yawRatePid : SMACCMPilot.Comm.Types.PidConfig.PidConfig
  , yawRatePidPollRate : Maybe Time
  , yawPositionPid : SMACCMPilot.Comm.Types.PidConfig.PidConfig
  , yawPositionPidPollRate : Maybe Time
  , armingRequest : SMACCMPilot.Comm.Types.Tristate.Tristate
  , armingRequestPollRate : Maybe Time
  , controlModesRequest : SMACCMPilot.Comm.Types.ControlModes.ControlModes
  , controlModesRequestPollRate : Maybe Time
  , userInputRequest : SMACCMPilot.Comm.Types.UserInput.UserInput
  , userInputRequestPollRate : Maybe Time
  , rgbLed : SMACCMPilot.Comm.Types.RgbLedSetting.RgbLedSetting
  , rgbLedPollRate : Maybe Time
  , cameraTargetInput : SMACCMPilot.Comm.Types.CameraTarget.CameraTarget
  , cameraTargetInputPollRate : Maybe Time
  , packedStatus : SMACCMPilot.Comm.Types.PackedStatus.PackedStatus
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
{-| ControllableVehicle initialized with (arbitrary) default values -}
init : ControllableVehicle
init =
  { nominalThrottle = 0
  , nominalThrottlePollRate = Nothing
  , altitudeRatePid = SMACCMPilot.Comm.Types.PidConfig.init
  , altitudeRatePidPollRate = Nothing
  , altitudePositionPid = SMACCMPilot.Comm.Types.PidConfig.init
  , altitudePositionPidPollRate = Nothing
  , throttleUi = SMACCMPilot.Comm.Types.ThrottleUi.init
  , throttleUiPollRate = Nothing
  , attitudeRollStab = SMACCMPilot.Comm.Types.StabConfig.init
  , attitudeRollStabPollRate = Nothing
  , attitudePitchStab = SMACCMPilot.Comm.Types.StabConfig.init
  , attitudePitchStabPollRate = Nothing
  , yawRatePid = SMACCMPilot.Comm.Types.PidConfig.init
  , yawRatePidPollRate = Nothing
  , yawPositionPid = SMACCMPilot.Comm.Types.PidConfig.init
  , yawPositionPidPollRate = Nothing
  , armingRequest = SMACCMPilot.Comm.Types.Tristate.init
  , armingRequestPollRate = Nothing
  , controlModesRequest = SMACCMPilot.Comm.Types.ControlModes.init
  , controlModesRequestPollRate = Nothing
  , userInputRequest = SMACCMPilot.Comm.Types.UserInput.init
  , userInputRequestPollRate = Nothing
  , rgbLed = SMACCMPilot.Comm.Types.RgbLedSetting.init
  , rgbLedPollRate = Nothing
  , cameraTargetInput = SMACCMPilot.Comm.Types.CameraTarget.init
  , cameraTargetInputPollRate = Nothing
  , packedStatus = SMACCMPilot.Comm.Types.PackedStatus.init
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
{-| Client interface for ControllableVehicle backed by a Gidl-generated RPC server -}
type alias Client msg =
  { getNominalThrottle : Cmd msg
  , pollNominalThrottle : Maybe Time -> Cmd msg
  , getAltitudeRatePid : Cmd msg
  , pollAltitudeRatePid : Maybe Time -> Cmd msg
  , getAltitudePositionPid : Cmd msg
  , pollAltitudePositionPid : Maybe Time -> Cmd msg
  , getThrottleUi : Cmd msg
  , pollThrottleUi : Maybe Time -> Cmd msg
  , getAttitudeRollStab : Cmd msg
  , pollAttitudeRollStab : Maybe Time -> Cmd msg
  , getAttitudePitchStab : Cmd msg
  , pollAttitudePitchStab : Maybe Time -> Cmd msg
  , getYawRatePid : Cmd msg
  , pollYawRatePid : Maybe Time -> Cmd msg
  , getYawPositionPid : Cmd msg
  , pollYawPositionPid : Maybe Time -> Cmd msg
  , getArmingRequest : Cmd msg
  , pollArmingRequest : Maybe Time -> Cmd msg
  , getControlModesRequest : Cmd msg
  , pollControlModesRequest : Maybe Time -> Cmd msg
  , getUserInputRequest : Cmd msg
  , pollUserInputRequest : Maybe Time -> Cmd msg
  , getRgbLed : Cmd msg
  , pollRgbLed : Maybe Time -> Cmd msg
  , getCameraTargetInput : Cmd msg
  , pollCameraTargetInput : Maybe Time -> Cmd msg
  , getPackedStatus : Cmd msg
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
  , setRebootReq : SMACCMPilot.Comm.Types.RebootReq.RebootReq -> Cmd msg
  , setNominalThrottle : Float -> Cmd msg
  , setAltitudeRatePid : SMACCMPilot.Comm.Types.PidConfig.PidConfig -> Cmd msg
  , setAltitudePositionPid : SMACCMPilot.Comm.Types.PidConfig.PidConfig -> Cmd msg
  , setThrottleUi : SMACCMPilot.Comm.Types.ThrottleUi.ThrottleUi -> Cmd msg
  , setAttitudeRollStab : SMACCMPilot.Comm.Types.StabConfig.StabConfig -> Cmd msg
  , setAttitudePitchStab : SMACCMPilot.Comm.Types.StabConfig.StabConfig -> Cmd msg
  , setYawRatePid : SMACCMPilot.Comm.Types.PidConfig.PidConfig -> Cmd msg
  , setYawPositionPid : SMACCMPilot.Comm.Types.PidConfig.PidConfig -> Cmd msg
  , setArmingRequest : SMACCMPilot.Comm.Types.Tristate.Tristate -> Cmd msg
  , setControlModesRequest : SMACCMPilot.Comm.Types.ControlModes.ControlModes -> Cmd msg
  , setUserInputRequest : SMACCMPilot.Comm.Types.UserInput.UserInput -> Cmd msg
  , setRgbLed : SMACCMPilot.Comm.Types.RgbLedSetting.RgbLedSetting -> Cmd msg
  }
{-| Msg variants. Not recommended for use directly, instead use the `Handler` interface -}
type Msg
  = GotNominalThrottle Float
  | PollNominalThrottle
  | PollRateNominalThrottle (Maybe Time)
  | GotAltitudeRatePid SMACCMPilot.Comm.Types.PidConfig.PidConfig
  | PollAltitudeRatePid
  | PollRateAltitudeRatePid (Maybe Time)
  | GotAltitudePositionPid SMACCMPilot.Comm.Types.PidConfig.PidConfig
  | PollAltitudePositionPid
  | PollRateAltitudePositionPid (Maybe Time)
  | GotThrottleUi SMACCMPilot.Comm.Types.ThrottleUi.ThrottleUi
  | PollThrottleUi
  | PollRateThrottleUi (Maybe Time)
  | GotAttitudeRollStab SMACCMPilot.Comm.Types.StabConfig.StabConfig
  | PollAttitudeRollStab
  | PollRateAttitudeRollStab (Maybe Time)
  | GotAttitudePitchStab SMACCMPilot.Comm.Types.StabConfig.StabConfig
  | PollAttitudePitchStab
  | PollRateAttitudePitchStab (Maybe Time)
  | GotYawRatePid SMACCMPilot.Comm.Types.PidConfig.PidConfig
  | PollYawRatePid
  | PollRateYawRatePid (Maybe Time)
  | GotYawPositionPid SMACCMPilot.Comm.Types.PidConfig.PidConfig
  | PollYawPositionPid
  | PollRateYawPositionPid (Maybe Time)
  | GotArmingRequest SMACCMPilot.Comm.Types.Tristate.Tristate
  | PollArmingRequest
  | PollRateArmingRequest (Maybe Time)
  | GotControlModesRequest SMACCMPilot.Comm.Types.ControlModes.ControlModes
  | PollControlModesRequest
  | PollRateControlModesRequest (Maybe Time)
  | GotUserInputRequest SMACCMPilot.Comm.Types.UserInput.UserInput
  | PollUserInputRequest
  | PollRateUserInputRequest (Maybe Time)
  | GotRgbLed SMACCMPilot.Comm.Types.RgbLedSetting.RgbLedSetting
  | PollRgbLed
  | PollRateRgbLed (Maybe Time)
  | GotCameraTargetInput SMACCMPilot.Comm.Types.CameraTarget.CameraTarget
  | PollCameraTargetInput
  | PollRateCameraTargetInput (Maybe Time)
  | GotPackedStatus SMACCMPilot.Comm.Types.PackedStatus.PackedStatus
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
  | SetRebootReq
  | SetNominalThrottle
  | SetAltitudeRatePid
  | SetAltitudePositionPid
  | SetThrottleUi
  | SetAttitudeRollStab
  | SetAttitudePitchStab
  | SetYawRatePid
  | SetYawPositionPid
  | SetArmingRequest
  | SetControlModesRequest
  | SetUserInputRequest
  | SetRgbLed
{-| Determine whether a `Msg` arose from a network call -}
networkMsg : Msg -> Bool
networkMsg msg =
  case msg of
    GotNominalThrottle _ -> True
    GotAltitudeRatePid _ -> True
    GotAltitudePositionPid _ -> True
    GotThrottleUi _ -> True
    GotAttitudeRollStab _ -> True
    GotAttitudePitchStab _ -> True
    GotYawRatePid _ -> True
    GotYawPositionPid _ -> True
    GotArmingRequest _ -> True
    GotControlModesRequest _ -> True
    GotUserInputRequest _ -> True
    GotRgbLed _ -> True
    GotCameraTargetInput _ -> True
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
    SetRebootReq -> True
    SetNominalThrottle -> True
    SetAltitudeRatePid -> True
    SetAltitudePositionPid -> True
    SetThrottleUi -> True
    SetAttitudeRollStab -> True
    SetAttitudePitchStab -> True
    SetYawRatePid -> True
    SetYawPositionPid -> True
    SetArmingRequest -> True
    SetControlModesRequest -> True
    SetUserInputRequest -> True
    SetRgbLed -> True
    _ -> False
{-| Given an error handler, a builder for your `msg` type, and a base URL for the RPC server, build a `Client` -}
client : Time.Time -> (Http.Error -> msg) -> (Msg -> msg) -> String -> Client msg
client to err ok url =
  { getNominalThrottle = Utils.send_ err (ok << GotNominalThrottle) (Utils.get_ to (url ++ "/controllable_vehicle_i/nominal_throttle") Json.Decode.float)
  , getAltitudeRatePid = Utils.send_ err (ok << GotAltitudeRatePid) (Utils.get_ to (url ++ "/controllable_vehicle_i/altitude_rate_pid") SMACCMPilot.Comm.Types.PidConfig.decode)
  , getAltitudePositionPid = Utils.send_ err (ok << GotAltitudePositionPid) (Utils.get_ to (url ++ "/controllable_vehicle_i/altitude_position_pid") SMACCMPilot.Comm.Types.PidConfig.decode)
  , getThrottleUi = Utils.send_ err (ok << GotThrottleUi) (Utils.get_ to (url ++ "/controllable_vehicle_i/throttle_ui") SMACCMPilot.Comm.Types.ThrottleUi.decode)
  , getAttitudeRollStab = Utils.send_ err (ok << GotAttitudeRollStab) (Utils.get_ to (url ++ "/controllable_vehicle_i/attitude_roll_stab") SMACCMPilot.Comm.Types.StabConfig.decode)
  , getAttitudePitchStab = Utils.send_ err (ok << GotAttitudePitchStab) (Utils.get_ to (url ++ "/controllable_vehicle_i/attitude_pitch_stab") SMACCMPilot.Comm.Types.StabConfig.decode)
  , getYawRatePid = Utils.send_ err (ok << GotYawRatePid) (Utils.get_ to (url ++ "/controllable_vehicle_i/yaw_rate_pid") SMACCMPilot.Comm.Types.PidConfig.decode)
  , getYawPositionPid = Utils.send_ err (ok << GotYawPositionPid) (Utils.get_ to (url ++ "/controllable_vehicle_i/yaw_position_pid") SMACCMPilot.Comm.Types.PidConfig.decode)
  , getArmingRequest = Utils.send_ err (ok << GotArmingRequest) (Utils.get_ to (url ++ "/controllable_vehicle_i/arming_request") SMACCMPilot.Comm.Types.Tristate.decode)
  , getControlModesRequest = Utils.send_ err (ok << GotControlModesRequest) (Utils.get_ to (url ++ "/controllable_vehicle_i/control_modes_request") SMACCMPilot.Comm.Types.ControlModes.decode)
  , getUserInputRequest = Utils.send_ err (ok << GotUserInputRequest) (Utils.get_ to (url ++ "/controllable_vehicle_i/user_input_request") SMACCMPilot.Comm.Types.UserInput.decode)
  , getRgbLed = Utils.send_ err (ok << GotRgbLed) (Utils.get_ to (url ++ "/controllable_vehicle_i/rgb_led") SMACCMPilot.Comm.Types.RgbLedSetting.decode)
  , getCameraTargetInput = Utils.send_ err (ok << GotCameraTargetInput) (Utils.get_ to (url ++ "/controllable_vehicle_i/camera_target_input") SMACCMPilot.Comm.Types.CameraTarget.decode)
  , getPackedStatus = Utils.send_ err (ok << GotPackedStatus) (Utils.get_ to (url ++ "/controllable_vehicle_i/packed_status") SMACCMPilot.Comm.Types.PackedStatus.decode)
  , getControlLaw = Utils.send_ err (ok << GotControlLaw) (Utils.get_ to (url ++ "/controllable_vehicle_i/control_law") SMACCMPilot.Comm.Types.ControlLaw.decode)
  , getRcInput = Utils.send_ err (ok << GotRcInput) (Utils.get_ to (url ++ "/controllable_vehicle_i/rc_input") SMACCMPilot.Comm.Types.RcInput.decode)
  , getUserInput = Utils.send_ err (ok << GotUserInput) (Utils.get_ to (url ++ "/controllable_vehicle_i/user_input") SMACCMPilot.Comm.Types.UserInputResult.decode)
  , getSensorsOutput = Utils.send_ err (ok << GotSensorsOutput) (Utils.get_ to (url ++ "/controllable_vehicle_i/sensors_output") SMACCMPilot.Comm.Types.SensorsResult.decode)
  , getGyroOutput = Utils.send_ err (ok << GotGyroOutput) (Utils.get_ to (url ++ "/controllable_vehicle_i/gyro_output") SMACCMPilot.Comm.Types.GyroscopeSample.decode)
  , getAccelOutput = Utils.send_ err (ok << GotAccelOutput) (Utils.get_ to (url ++ "/controllable_vehicle_i/accel_output") SMACCMPilot.Comm.Types.AccelerometerSample.decode)
  , getBaroOutput = Utils.send_ err (ok << GotBaroOutput) (Utils.get_ to (url ++ "/controllable_vehicle_i/baro_output") SMACCMPilot.Comm.Types.BarometerSample.decode)
  , getLidarliteOutput = Utils.send_ err (ok << GotLidarliteOutput) (Utils.get_ to (url ++ "/controllable_vehicle_i/lidarlite_output") SMACCMPilot.Comm.Types.LidarliteSample.decode)
  , getMagOutput = Utils.send_ err (ok << GotMagOutput) (Utils.get_ to (url ++ "/controllable_vehicle_i/mag_output") SMACCMPilot.Comm.Types.MagnetometerSample.decode)
  , getPx4flowIntOutput = Utils.send_ err (ok << GotPx4flowIntOutput) (Utils.get_ to (url ++ "/controllable_vehicle_i/px4flow_int_output") SMACCMPilot.Comm.Types.Px4flowIntegralSample.decode)
  , getPx4flowOutput = Utils.send_ err (ok << GotPx4flowOutput) (Utils.get_ to (url ++ "/controllable_vehicle_i/px4flow_output") SMACCMPilot.Comm.Types.Px4flowSample.decode)
  , getGpsOutput = Utils.send_ err (ok << GotGpsOutput) (Utils.get_ to (url ++ "/controllable_vehicle_i/gps_output") SMACCMPilot.Comm.Types.PositionSample.decode)
  , getControlSetpoint = Utils.send_ err (ok << GotControlSetpoint) (Utils.get_ to (url ++ "/controllable_vehicle_i/control_setpoint") SMACCMPilot.Comm.Types.ControlSetpoint.decode)
  , getControlOutput = Utils.send_ err (ok << GotControlOutput) (Utils.get_ to (url ++ "/controllable_vehicle_i/control_output") SMACCMPilot.Comm.Types.ControlOutput.decode)
  , getMotorOutput = Utils.send_ err (ok << GotMotorOutput) (Utils.get_ to (url ++ "/controllable_vehicle_i/motor_output") SMACCMPilot.Comm.Types.QuadcopterMotors.decode)
  , getAttControlDebug = Utils.send_ err (ok << GotAttControlDebug) (Utils.get_ to (url ++ "/controllable_vehicle_i/att_control_debug") SMACCMPilot.Comm.Types.AttControlDebug.decode)
  , getAltControlDebug = Utils.send_ err (ok << GotAltControlDebug) (Utils.get_ to (url ++ "/controllable_vehicle_i/alt_control_debug") SMACCMPilot.Comm.Types.AltControlDebug.decode)
  , getPx4ioState = Utils.send_ err (ok << GotPx4ioState) (Utils.get_ to (url ++ "/controllable_vehicle_i/px4io_state") SMACCMPilot.Comm.Types.Px4ioState.decode)
  , getArmingStatus = Utils.send_ err (ok << GotArmingStatus) (Utils.get_ to (url ++ "/controllable_vehicle_i/arming_status") SMACCMPilot.Comm.Types.ArmingStatus.decode)
  , getBatteryVoltage = Utils.send_ err (ok << GotBatteryVoltage) (Utils.get_ to (url ++ "/controllable_vehicle_i/battery_voltage") Json.Decode.float)
  , pollNominalThrottle = \mt -> Task.perform (always (ok (PollRateNominalThrottle mt))) (Task.succeed ())
  , pollAltitudeRatePid = \mt -> Task.perform (always (ok (PollRateAltitudeRatePid mt))) (Task.succeed ())
  , pollAltitudePositionPid = \mt -> Task.perform (always (ok (PollRateAltitudePositionPid mt))) (Task.succeed ())
  , pollThrottleUi = \mt -> Task.perform (always (ok (PollRateThrottleUi mt))) (Task.succeed ())
  , pollAttitudeRollStab = \mt -> Task.perform (always (ok (PollRateAttitudeRollStab mt))) (Task.succeed ())
  , pollAttitudePitchStab = \mt -> Task.perform (always (ok (PollRateAttitudePitchStab mt))) (Task.succeed ())
  , pollYawRatePid = \mt -> Task.perform (always (ok (PollRateYawRatePid mt))) (Task.succeed ())
  , pollYawPositionPid = \mt -> Task.perform (always (ok (PollRateYawPositionPid mt))) (Task.succeed ())
  , pollArmingRequest = \mt -> Task.perform (always (ok (PollRateArmingRequest mt))) (Task.succeed ())
  , pollControlModesRequest = \mt -> Task.perform (always (ok (PollRateControlModesRequest mt))) (Task.succeed ())
  , pollUserInputRequest = \mt -> Task.perform (always (ok (PollRateUserInputRequest mt))) (Task.succeed ())
  , pollRgbLed = \mt -> Task.perform (always (ok (PollRateRgbLed mt))) (Task.succeed ())
  , pollCameraTargetInput = \mt -> Task.perform (always (ok (PollRateCameraTargetInput mt))) (Task.succeed ())
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
  , setRebootReq = \x -> Utils.send_ err (ok << always SetRebootReq) (Utils.post_ to (url ++ "/controllable_vehicle_i/reboot_req") (Http.jsonBody (SMACCMPilot.Comm.Types.RebootReq.encode x)))
  , setNominalThrottle = \x -> Utils.send_ err (ok << always SetNominalThrottle) (Utils.post_ to (url ++ "/controllable_vehicle_i/nominal_throttle") (Http.jsonBody (Json.Encode.float x)))
  , setAltitudeRatePid = \x -> Utils.send_ err (ok << always SetAltitudeRatePid) (Utils.post_ to (url ++ "/controllable_vehicle_i/altitude_rate_pid") (Http.jsonBody (SMACCMPilot.Comm.Types.PidConfig.encode x)))
  , setAltitudePositionPid = \x -> Utils.send_ err (ok << always SetAltitudePositionPid) (Utils.post_ to (url ++ "/controllable_vehicle_i/altitude_position_pid") (Http.jsonBody (SMACCMPilot.Comm.Types.PidConfig.encode x)))
  , setThrottleUi = \x -> Utils.send_ err (ok << always SetThrottleUi) (Utils.post_ to (url ++ "/controllable_vehicle_i/throttle_ui") (Http.jsonBody (SMACCMPilot.Comm.Types.ThrottleUi.encode x)))
  , setAttitudeRollStab = \x -> Utils.send_ err (ok << always SetAttitudeRollStab) (Utils.post_ to (url ++ "/controllable_vehicle_i/attitude_roll_stab") (Http.jsonBody (SMACCMPilot.Comm.Types.StabConfig.encode x)))
  , setAttitudePitchStab = \x -> Utils.send_ err (ok << always SetAttitudePitchStab) (Utils.post_ to (url ++ "/controllable_vehicle_i/attitude_pitch_stab") (Http.jsonBody (SMACCMPilot.Comm.Types.StabConfig.encode x)))
  , setYawRatePid = \x -> Utils.send_ err (ok << always SetYawRatePid) (Utils.post_ to (url ++ "/controllable_vehicle_i/yaw_rate_pid") (Http.jsonBody (SMACCMPilot.Comm.Types.PidConfig.encode x)))
  , setYawPositionPid = \x -> Utils.send_ err (ok << always SetYawPositionPid) (Utils.post_ to (url ++ "/controllable_vehicle_i/yaw_position_pid") (Http.jsonBody (SMACCMPilot.Comm.Types.PidConfig.encode x)))
  , setArmingRequest = \x -> Utils.send_ err (ok << always SetArmingRequest) (Utils.post_ to (url ++ "/controllable_vehicle_i/arming_request") (Http.jsonBody (SMACCMPilot.Comm.Types.Tristate.encode x)))
  , setControlModesRequest = \x -> Utils.send_ err (ok << always SetControlModesRequest) (Utils.post_ to (url ++ "/controllable_vehicle_i/control_modes_request") (Http.jsonBody (SMACCMPilot.Comm.Types.ControlModes.encode x)))
  , setUserInputRequest = \x -> Utils.send_ err (ok << always SetUserInputRequest) (Utils.post_ to (url ++ "/controllable_vehicle_i/user_input_request") (Http.jsonBody (SMACCMPilot.Comm.Types.UserInput.encode x)))
  , setRgbLed = \x -> Utils.send_ err (ok << always SetRgbLed) (Utils.post_ to (url ++ "/controllable_vehicle_i/rgb_led") (Http.jsonBody (SMACCMPilot.Comm.Types.RgbLedSetting.encode x)))
  }
{-| The `Handler` is how the client should integrate with your Elm Architecture `update` function -}
type alias Handler model msg =
  { handleGotNominalThrottle : Float -> model -> (model, Cmd msg)
  , handleGotAltitudeRatePid : SMACCMPilot.Comm.Types.PidConfig.PidConfig -> model -> (model, Cmd msg)
  , handleGotAltitudePositionPid : SMACCMPilot.Comm.Types.PidConfig.PidConfig -> model -> (model, Cmd msg)
  , handleGotThrottleUi : SMACCMPilot.Comm.Types.ThrottleUi.ThrottleUi -> model -> (model, Cmd msg)
  , handleGotAttitudeRollStab : SMACCMPilot.Comm.Types.StabConfig.StabConfig -> model -> (model, Cmd msg)
  , handleGotAttitudePitchStab : SMACCMPilot.Comm.Types.StabConfig.StabConfig -> model -> (model, Cmd msg)
  , handleGotYawRatePid : SMACCMPilot.Comm.Types.PidConfig.PidConfig -> model -> (model, Cmd msg)
  , handleGotYawPositionPid : SMACCMPilot.Comm.Types.PidConfig.PidConfig -> model -> (model, Cmd msg)
  , handleGotArmingRequest : SMACCMPilot.Comm.Types.Tristate.Tristate -> model -> (model, Cmd msg)
  , handleGotControlModesRequest : SMACCMPilot.Comm.Types.ControlModes.ControlModes -> model -> (model, Cmd msg)
  , handleGotUserInputRequest : SMACCMPilot.Comm.Types.UserInput.UserInput -> model -> (model, Cmd msg)
  , handleGotRgbLed : SMACCMPilot.Comm.Types.RgbLedSetting.RgbLedSetting -> model -> (model, Cmd msg)
  , handleGotCameraTargetInput : SMACCMPilot.Comm.Types.CameraTarget.CameraTarget -> model -> (model, Cmd msg)
  , handleGotPackedStatus : SMACCMPilot.Comm.Types.PackedStatus.PackedStatus -> model -> (model, Cmd msg)
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
  , handlePollNominalThrottle : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollAltitudeRatePid : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollAltitudePositionPid : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollThrottleUi : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollAttitudeRollStab : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollAttitudePitchStab : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollYawRatePid : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollYawPositionPid : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollArmingRequest : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollControlModesRequest : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollUserInputRequest : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollRgbLed : (model -> Client msg) -> model -> (model, Cmd msg)
  , handlePollCameraTargetInput : (model -> Client msg) -> model -> (model, Cmd msg)
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
  , handlePollRateNominalThrottle : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateAltitudeRatePid : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateAltitudePositionPid : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateThrottleUi : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateAttitudeRollStab : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateAttitudePitchStab : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateYawRatePid : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateYawPositionPid : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateArmingRequest : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateControlModesRequest : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateUserInputRequest : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateRgbLed : Maybe Time -> model -> (model, Cmd msg)
  , handlePollRateCameraTargetInput : Maybe Time -> model -> (model, Cmd msg)
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
  , handleSetRebootReq : model -> (model, Cmd msg)
  , handleSetNominalThrottle : model -> (model, Cmd msg)
  , handleSetAltitudeRatePid : model -> (model, Cmd msg)
  , handleSetAltitudePositionPid : model -> (model, Cmd msg)
  , handleSetThrottleUi : model -> (model, Cmd msg)
  , handleSetAttitudeRollStab : model -> (model, Cmd msg)
  , handleSetAttitudePitchStab : model -> (model, Cmd msg)
  , handleSetYawRatePid : model -> (model, Cmd msg)
  , handleSetYawPositionPid : model -> (model, Cmd msg)
  , handleSetArmingRequest : model -> (model, Cmd msg)
  , handleSetControlModesRequest : model -> (model, Cmd msg)
  , handleSetUserInputRequest : model -> (model, Cmd msg)
  , handleSetRgbLed : model -> (model, Cmd msg)
  }
{-| The `defaultHandler` does nothing for any messages; override the operations you need with your logic -}
defaultHandler : Handler model msg
defaultHandler = updatingHandler (\m _ -> m)
{-| The `updatingHandler` updates a field in your model when new data arrives. You must provide a suitable update function that updates the ControllableVehicle in your model -}
updatingHandler : (model -> (ControllableVehicle -> ControllableVehicle) -> model) -> Handler model msg
updatingHandler upd =
  { handleGotNominalThrottle = \x m -> (upd m (\i -> {i | nominalThrottle = x}), Cmd.none)
  , handleGotAltitudeRatePid = \x m -> (upd m (\i -> {i | altitudeRatePid = x}), Cmd.none)
  , handleGotAltitudePositionPid = \x m -> (upd m (\i -> {i | altitudePositionPid = x}), Cmd.none)
  , handleGotThrottleUi = \x m -> (upd m (\i -> {i | throttleUi = x}), Cmd.none)
  , handleGotAttitudeRollStab = \x m -> (upd m (\i -> {i | attitudeRollStab = x}), Cmd.none)
  , handleGotAttitudePitchStab = \x m -> (upd m (\i -> {i | attitudePitchStab = x}), Cmd.none)
  , handleGotYawRatePid = \x m -> (upd m (\i -> {i | yawRatePid = x}), Cmd.none)
  , handleGotYawPositionPid = \x m -> (upd m (\i -> {i | yawPositionPid = x}), Cmd.none)
  , handleGotArmingRequest = \x m -> (upd m (\i -> {i | armingRequest = x}), Cmd.none)
  , handleGotControlModesRequest = \x m -> (upd m (\i -> {i | controlModesRequest = x}), Cmd.none)
  , handleGotUserInputRequest = \x m -> (upd m (\i -> {i | userInputRequest = x}), Cmd.none)
  , handleGotRgbLed = \x m -> (upd m (\i -> {i | rgbLed = x}), Cmd.none)
  , handleGotCameraTargetInput = \x m -> (upd m (\i -> {i | cameraTargetInput = x}), Cmd.none)
  , handleGotPackedStatus = \x m -> (upd m (\i -> {i | packedStatus = x}), Cmd.none)
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
  , handlePollNominalThrottle = \cl m -> (m , (cl m).getNominalThrottle)
  , handlePollAltitudeRatePid = \cl m -> (m , (cl m).getAltitudeRatePid)
  , handlePollAltitudePositionPid = \cl m -> (m , (cl m).getAltitudePositionPid)
  , handlePollThrottleUi = \cl m -> (m , (cl m).getThrottleUi)
  , handlePollAttitudeRollStab = \cl m -> (m , (cl m).getAttitudeRollStab)
  , handlePollAttitudePitchStab = \cl m -> (m , (cl m).getAttitudePitchStab)
  , handlePollYawRatePid = \cl m -> (m , (cl m).getYawRatePid)
  , handlePollYawPositionPid = \cl m -> (m , (cl m).getYawPositionPid)
  , handlePollArmingRequest = \cl m -> (m , (cl m).getArmingRequest)
  , handlePollControlModesRequest = \cl m -> (m , (cl m).getControlModesRequest)
  , handlePollUserInputRequest = \cl m -> (m , (cl m).getUserInputRequest)
  , handlePollRgbLed = \cl m -> (m , (cl m).getRgbLed)
  , handlePollCameraTargetInput = \cl m -> (m , (cl m).getCameraTargetInput)
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
  , handlePollRateNominalThrottle = \mt m -> (upd m (\i -> {i | nominalThrottlePollRate = mt}), Cmd.none)
  , handlePollRateAltitudeRatePid = \mt m -> (upd m (\i -> {i | altitudeRatePidPollRate = mt}), Cmd.none)
  , handlePollRateAltitudePositionPid = \mt m -> (upd m (\i -> {i | altitudePositionPidPollRate = mt}), Cmd.none)
  , handlePollRateThrottleUi = \mt m -> (upd m (\i -> {i | throttleUiPollRate = mt}), Cmd.none)
  , handlePollRateAttitudeRollStab = \mt m -> (upd m (\i -> {i | attitudeRollStabPollRate = mt}), Cmd.none)
  , handlePollRateAttitudePitchStab = \mt m -> (upd m (\i -> {i | attitudePitchStabPollRate = mt}), Cmd.none)
  , handlePollRateYawRatePid = \mt m -> (upd m (\i -> {i | yawRatePidPollRate = mt}), Cmd.none)
  , handlePollRateYawPositionPid = \mt m -> (upd m (\i -> {i | yawPositionPidPollRate = mt}), Cmd.none)
  , handlePollRateArmingRequest = \mt m -> (upd m (\i -> {i | armingRequestPollRate = mt}), Cmd.none)
  , handlePollRateControlModesRequest = \mt m -> (upd m (\i -> {i | controlModesRequestPollRate = mt}), Cmd.none)
  , handlePollRateUserInputRequest = \mt m -> (upd m (\i -> {i | userInputRequestPollRate = mt}), Cmd.none)
  , handlePollRateRgbLed = \mt m -> (upd m (\i -> {i | rgbLedPollRate = mt}), Cmd.none)
  , handlePollRateCameraTargetInput = \mt m -> (upd m (\i -> {i | cameraTargetInputPollRate = mt}), Cmd.none)
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
  , handleSetRebootReq = \m -> (m, Cmd.none)
  , handleSetNominalThrottle = \m -> (m, Cmd.none)
  , handleSetAltitudeRatePid = \m -> (m, Cmd.none)
  , handleSetAltitudePositionPid = \m -> (m, Cmd.none)
  , handleSetThrottleUi = \m -> (m, Cmd.none)
  , handleSetAttitudeRollStab = \m -> (m, Cmd.none)
  , handleSetAttitudePitchStab = \m -> (m, Cmd.none)
  , handleSetYawRatePid = \m -> (m, Cmd.none)
  , handleSetYawPositionPid = \m -> (m, Cmd.none)
  , handleSetArmingRequest = \m -> (m, Cmd.none)
  , handleSetControlModesRequest = \m -> (m, Cmd.none)
  , handleSetUserInputRequest = \m -> (m, Cmd.none)
  , handleSetRgbLed = \m -> (m, Cmd.none)
  }
{-| Driver for a `Handler`; use in your `update` function -}
handle : Handler model msg -> (model -> Client msg) -> Msg -> model -> (model, Cmd msg)
handle h cl r m =
  case r of
    GotNominalThrottle x -> h.handleGotNominalThrottle x m
    GotAltitudeRatePid x -> h.handleGotAltitudeRatePid x m
    GotAltitudePositionPid x -> h.handleGotAltitudePositionPid x m
    GotThrottleUi x -> h.handleGotThrottleUi x m
    GotAttitudeRollStab x -> h.handleGotAttitudeRollStab x m
    GotAttitudePitchStab x -> h.handleGotAttitudePitchStab x m
    GotYawRatePid x -> h.handleGotYawRatePid x m
    GotYawPositionPid x -> h.handleGotYawPositionPid x m
    GotArmingRequest x -> h.handleGotArmingRequest x m
    GotControlModesRequest x -> h.handleGotControlModesRequest x m
    GotUserInputRequest x -> h.handleGotUserInputRequest x m
    GotRgbLed x -> h.handleGotRgbLed x m
    GotCameraTargetInput x -> h.handleGotCameraTargetInput x m
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
    PollNominalThrottle -> h.handlePollNominalThrottle cl m
    PollAltitudeRatePid -> h.handlePollAltitudeRatePid cl m
    PollAltitudePositionPid -> h.handlePollAltitudePositionPid cl m
    PollThrottleUi -> h.handlePollThrottleUi cl m
    PollAttitudeRollStab -> h.handlePollAttitudeRollStab cl m
    PollAttitudePitchStab -> h.handlePollAttitudePitchStab cl m
    PollYawRatePid -> h.handlePollYawRatePid cl m
    PollYawPositionPid -> h.handlePollYawPositionPid cl m
    PollArmingRequest -> h.handlePollArmingRequest cl m
    PollControlModesRequest -> h.handlePollControlModesRequest cl m
    PollUserInputRequest -> h.handlePollUserInputRequest cl m
    PollRgbLed -> h.handlePollRgbLed cl m
    PollCameraTargetInput -> h.handlePollCameraTargetInput cl m
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
    PollRateNominalThrottle mt -> h.handlePollRateNominalThrottle mt m
    PollRateAltitudeRatePid mt -> h.handlePollRateAltitudeRatePid mt m
    PollRateAltitudePositionPid mt -> h.handlePollRateAltitudePositionPid mt m
    PollRateThrottleUi mt -> h.handlePollRateThrottleUi mt m
    PollRateAttitudeRollStab mt -> h.handlePollRateAttitudeRollStab mt m
    PollRateAttitudePitchStab mt -> h.handlePollRateAttitudePitchStab mt m
    PollRateYawRatePid mt -> h.handlePollRateYawRatePid mt m
    PollRateYawPositionPid mt -> h.handlePollRateYawPositionPid mt m
    PollRateArmingRequest mt -> h.handlePollRateArmingRequest mt m
    PollRateControlModesRequest mt -> h.handlePollRateControlModesRequest mt m
    PollRateUserInputRequest mt -> h.handlePollRateUserInputRequest mt m
    PollRateRgbLed mt -> h.handlePollRateRgbLed mt m
    PollRateCameraTargetInput mt -> h.handlePollRateCameraTargetInput mt m
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
    SetRebootReq -> h.handleSetRebootReq m
    SetNominalThrottle -> h.handleSetNominalThrottle m
    SetAltitudeRatePid -> h.handleSetAltitudeRatePid m
    SetAltitudePositionPid -> h.handleSetAltitudePositionPid m
    SetThrottleUi -> h.handleSetThrottleUi m
    SetAttitudeRollStab -> h.handleSetAttitudeRollStab m
    SetAttitudePitchStab -> h.handleSetAttitudePitchStab m
    SetYawRatePid -> h.handleSetYawRatePid m
    SetYawPositionPid -> h.handleSetYawPositionPid m
    SetArmingRequest -> h.handleSetArmingRequest m
    SetControlModesRequest -> h.handleSetControlModesRequest m
    SetUserInputRequest -> h.handleSetUserInputRequest m
    SetRgbLed -> h.handleSetRgbLed m
{-| Generate subscriptions from the poll rates in the `ControllableVehicle` -}
subscriptions : ControllableVehicle -> (Msg -> msg) -> List (Sub.Sub msg)
subscriptions i toMsg =
  [ Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollNominalThrottle))) i.nominalThrottlePollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollAltitudeRatePid))) i.altitudeRatePidPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollAltitudePositionPid))) i.altitudePositionPidPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollThrottleUi))) i.throttleUiPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollAttitudeRollStab))) i.attitudeRollStabPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollAttitudePitchStab))) i.attitudePitchStabPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollYawRatePid))) i.yawRatePidPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollYawPositionPid))) i.yawPositionPidPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollArmingRequest))) i.armingRequestPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollControlModesRequest))) i.controlModesRequestPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollUserInputRequest))) i.userInputRequestPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollRgbLed))) i.rgbLedPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollCameraTargetInput))) i.cameraTargetInputPollRate)
  , Maybe.withDefault Sub.none (Maybe.map (\t -> Time.every t (always (toMsg PollPackedStatus))) i.packedStatusPollRate)
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
mapPollRates : (Time -> Time) -> ControllableVehicle -> ControllableVehicle
mapPollRates f i =
  {i   | nominalThrottlePollRate = Maybe.map f i.nominalThrottlePollRate
       , altitudeRatePidPollRate = Maybe.map f i.altitudeRatePidPollRate
       , altitudePositionPidPollRate = Maybe.map f i.altitudePositionPidPollRate
       , throttleUiPollRate = Maybe.map f i.throttleUiPollRate
       , attitudeRollStabPollRate = Maybe.map f i.attitudeRollStabPollRate
       , attitudePitchStabPollRate = Maybe.map f i.attitudePitchStabPollRate
       , yawRatePidPollRate = Maybe.map f i.yawRatePidPollRate
       , yawPositionPidPollRate = Maybe.map f i.yawPositionPidPollRate
       , armingRequestPollRate = Maybe.map f i.armingRequestPollRate
       , controlModesRequestPollRate = Maybe.map f i.controlModesRequestPollRate
       , userInputRequestPollRate = Maybe.map f i.userInputRequestPollRate
       , rgbLedPollRate = Maybe.map f i.rgbLedPollRate
       , cameraTargetInputPollRate = Maybe.map f i.cameraTargetInputPollRate
       , packedStatusPollRate = Maybe.map f i.packedStatusPollRate
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