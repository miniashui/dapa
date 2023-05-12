module SMACCMPilot.Comm.Types.ThrottleUi exposing (..)
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias ThrottleUi =
  { sens : Float
  , dead : Float
  }
encode : ThrottleUi -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("sens", Json.Encode.float x.sens)
    , ("dead", Json.Encode.float x.dead)
    ]
decode : Json.Decode.Decoder ThrottleUi
decode = Json.Decode.Pipeline.decode ThrottleUi
  |> (required "sens" Json.Decode.float)
  |> (required "dead" Json.Decode.float)
{-| ThrottleUi initialized with (arbitrary) default values -}
init : ThrottleUi
init =
  { sens = 0
  , dead = 0
  }