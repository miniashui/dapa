module SMACCMPilot.Comm.Types.CameraTarget exposing (..)
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias CameraTarget =
  { valid : Bool
  , bbox_l : Int
  , bbox_r : Int
  , bbox_t : Int
  , bbox_b : Int
  }
encode : CameraTarget -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("valid", Json.Encode.bool x.valid)
    , ("bbox_l", Json.Encode.int x.bbox_l)
    , ("bbox_r", Json.Encode.int x.bbox_r)
    , ("bbox_t", Json.Encode.int x.bbox_t)
    , ("bbox_b", Json.Encode.int x.bbox_b)
    ]
decode : Json.Decode.Decoder CameraTarget
decode = Json.Decode.Pipeline.decode CameraTarget
  |> (required "valid" Json.Decode.bool)
  |> (required "bbox_l" Json.Decode.int)
  |> (required "bbox_r" Json.Decode.int)
  |> (required "bbox_t" Json.Decode.int)
  |> (required "bbox_b" Json.Decode.int)
{-| CameraTarget initialized with (arbitrary) default values -}
init : CameraTarget
init =
  { valid = False
  , bbox_l = 0
  , bbox_r = 0
  , bbox_t = 0
  , bbox_b = 0
  }