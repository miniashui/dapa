module SMACCMPilot.Comm.Types.Px4ioAlarms exposing (..)
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias Px4ioAlarms =
  { vservo_fault : Bool
  , pwm_error : Bool
  , rc_lost : Bool
  , fmu_lost : Bool
  , acc_current : Bool
  , servo_current : Bool
  , temperature : Bool
  , vbatt_low : Bool
  }
encode : Px4ioAlarms -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("vservo_fault", Json.Encode.bool x.vservo_fault)
    , ("pwm_error", Json.Encode.bool x.pwm_error)
    , ("rc_lost", Json.Encode.bool x.rc_lost)
    , ("fmu_lost", Json.Encode.bool x.fmu_lost)
    , ("acc_current", Json.Encode.bool x.acc_current)
    , ("servo_current", Json.Encode.bool x.servo_current)
    , ("temperature", Json.Encode.bool x.temperature)
    , ("vbatt_low", Json.Encode.bool x.vbatt_low)
    ]
decode : Json.Decode.Decoder Px4ioAlarms
decode = Json.Decode.Pipeline.decode Px4ioAlarms
  |> (required "vservo_fault" Json.Decode.bool)
  |> (required "pwm_error" Json.Decode.bool)
  |> (required "rc_lost" Json.Decode.bool)
  |> (required "fmu_lost" Json.Decode.bool)
  |> (required "acc_current" Json.Decode.bool)
  |> (required "servo_current" Json.Decode.bool)
  |> (required "temperature" Json.Decode.bool)
  |> (required "vbatt_low" Json.Decode.bool)
{-| Px4ioAlarms initialized with (arbitrary) default values -}
init : Px4ioAlarms
init =
  { vservo_fault = False
  , pwm_error = False
  , rc_lost = False
  , fmu_lost = False
  , acc_current = False
  , servo_current = False
  , temperature = False
  , vbatt_low = False
  }