module SMACCMPilot.Comm.Types.Tristate exposing (..)
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type Tristate
  = Negative
  | Neutral
  | Positive
encode : Tristate -> Json.Encode.Value
encode x =
  case x of
    Negative -> Json.Encode.string "Negative"
    Neutral -> Json.Encode.string "Neutral"
    Positive -> Json.Encode.string "Positive"
decode : Json.Decode.Decoder Tristate
decode =
  Utils.customDecoder Json.Decode.string (\tag ->
    case tag of
      "Negative" -> Ok Negative
      "Neutral" -> Ok Neutral
      "Positive" -> Ok Positive
      str -> Err ("unrecognized Tristate tag: " ++ str))
{-| Tristate initialized with (arbitrary) default values -}
init : Tristate
init = Negative