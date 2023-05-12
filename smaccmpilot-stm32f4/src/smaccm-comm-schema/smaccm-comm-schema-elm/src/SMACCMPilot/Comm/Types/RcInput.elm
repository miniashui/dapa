module SMACCMPilot.Comm.Types.RcInput exposing (..)
import SMACCMPilot.Comm.Types.TimeMicros
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias RcInput =
  { valid : Bool
  , roll : Int
  , pitch : Int
  , throttle : Int
  , yaw : Int
  , switch1 : Int
  , switch2 : Int
  , time : SMACCMPilot.Comm.Types.TimeMicros.TimeMicros
  }
encode : RcInput -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("valid", Json.Encode.bool x.valid)
    , ("roll", Json.Encode.int x.roll)
    , ("pitch", Json.Encode.int x.pitch)
    , ("throttle", Json.Encode.int x.throttle)
    , ("yaw", Json.Encode.int x.yaw)
    , ("switch1", Json.Encode.int x.switch1)
    , ("switch2", Json.Encode.int x.switch2)
    , ("time", SMACCMPilot.Comm.Types.TimeMicros.encode x.time)
    ]
decode : Json.Decode.Decoder RcInput
decode = Json.Decode.Pipeline.decode RcInput
  |> (required "valid" Json.Decode.bool)
  |> (required "roll" Json.Decode.int)
  |> (required "pitch" Json.Decode.int)
  |> (required "throttle" Json.Decode.int)
  |> (required "yaw" Json.Decode.int)
  |> (required "switch1" Json.Decode.int)
  |> (required "switch2" Json.Decode.int)
  |> (required "time" SMACCMPilot.Comm.Types.TimeMicros.decode)
{-| RcInput initialized with (arbitrary) default values -}
init : RcInput
init =
  { valid = False
  , roll = 0
  , pitch = 0
  , throttle = 0
  , yaw = 0
  , switch1 = 0
  , switch2 = 0
  , time = SMACCMPilot.Comm.Types.TimeMicros.init
  }