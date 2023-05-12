module SMACCMPilot.Comm.Types.Xyz exposing (..)
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias Xyz =
  { x : Float
  , y : Float
  , z : Float
  }
encode : Xyz -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("x", Json.Encode.float x.x)
    , ("y", Json.Encode.float x.y)
    , ("z", Json.Encode.float x.z)
    ]
decode : Json.Decode.Decoder Xyz
decode = Json.Decode.Pipeline.decode Xyz
  |> (required "x" Json.Decode.float)
  |> (required "y" Json.Decode.float)
  |> (required "z" Json.Decode.float)
{-| Xyz initialized with (arbitrary) default values -}
init : Xyz
init =
  { x = 0
  , y = 0
  , z = 0
  }