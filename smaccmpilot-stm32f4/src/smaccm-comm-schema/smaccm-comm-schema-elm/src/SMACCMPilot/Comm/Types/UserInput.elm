module SMACCMPilot.Comm.Types.UserInput exposing (..)
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias UserInput =
  { throttle : Float
  , roll : Float
  , pitch : Float
  , yaw : Float
  }
encode : UserInput -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("throttle", Json.Encode.float x.throttle)
    , ("roll", Json.Encode.float x.roll)
    , ("pitch", Json.Encode.float x.pitch)
    , ("yaw", Json.Encode.float x.yaw)
    ]
decode : Json.Decode.Decoder UserInput
decode = Json.Decode.Pipeline.decode UserInput
  |> (required "throttle" Json.Decode.float)
  |> (required "roll" Json.Decode.float)
  |> (required "pitch" Json.Decode.float)
  |> (required "yaw" Json.Decode.float)
{-| UserInput initialized with (arbitrary) default values -}
init : UserInput
init =
  { throttle = 0
  , roll = 0
  , pitch = 0
  , yaw = 0
  }