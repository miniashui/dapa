module SMACCMPilot.Comm.Types.RgbLedSetting exposing (..)
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias RgbLedSetting =
  { red : Int
  , green : Int
  , blue : Int
  }
encode : RgbLedSetting -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("red", Json.Encode.int x.red)
    , ("green", Json.Encode.int x.green)
    , ("blue", Json.Encode.int x.blue)
    ]
decode : Json.Decode.Decoder RgbLedSetting
decode = Json.Decode.Pipeline.decode RgbLedSetting
  |> (required "red" Json.Decode.int)
  |> (required "green" Json.Decode.int)
  |> (required "blue" Json.Decode.int)
{-| RgbLedSetting initialized with (arbitrary) default values -}
init : RgbLedSetting
init =
  { red = 0
  , green = 0
  , blue = 0
  }