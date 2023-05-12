module SMACCMPilot.Comm.Types.Quaternion exposing (..)
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias Quaternion =
  { quat_a : Float
  , quat_b : Float
  , quat_c : Float
  , quat_d : Float
  }
encode : Quaternion -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("quat_a", Json.Encode.float x.quat_a)
    , ("quat_b", Json.Encode.float x.quat_b)
    , ("quat_c", Json.Encode.float x.quat_c)
    , ("quat_d", Json.Encode.float x.quat_d)
    ]
decode : Json.Decode.Decoder Quaternion
decode = Json.Decode.Pipeline.decode Quaternion
  |> (required "quat_a" Json.Decode.float)
  |> (required "quat_b" Json.Decode.float)
  |> (required "quat_c" Json.Decode.float)
  |> (required "quat_d" Json.Decode.float)
{-| Quaternion initialized with (arbitrary) default values -}
init : Quaternion
init =
  { quat_a = 0
  , quat_b = 0
  , quat_c = 0
  , quat_d = 0
  }