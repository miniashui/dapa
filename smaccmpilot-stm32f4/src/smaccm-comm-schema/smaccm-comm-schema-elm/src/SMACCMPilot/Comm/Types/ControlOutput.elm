module SMACCMPilot.Comm.Types.ControlOutput exposing (..)
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias ControlOutput =
  { armed : Bool
  , throttle : Float
  , roll : Float
  , pitch : Float
  , yaw : Float
  }
encode : ControlOutput -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("armed", Json.Encode.bool x.armed)
    , ("throttle", Json.Encode.float x.throttle)
    , ("roll", Json.Encode.float x.roll)
    , ("pitch", Json.Encode.float x.pitch)
    , ("yaw", Json.Encode.float x.yaw)
    ]
decode : Json.Decode.Decoder ControlOutput
decode = Json.Decode.Pipeline.decode ControlOutput
  |> (required "armed" Json.Decode.bool)
  |> (required "throttle" Json.Decode.float)
  |> (required "roll" Json.Decode.float)
  |> (required "pitch" Json.Decode.float)
  |> (required "yaw" Json.Decode.float)
{-| ControlOutput initialized with (arbitrary) default values -}
init : ControlOutput
init =
  { armed = False
  , throttle = 0
  , roll = 0
  , pitch = 0
  , yaw = 0
  }