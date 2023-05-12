module SMACCMPilot.Comm.Types.YawMode exposing (..)
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type YawMode
  = Rate
  | Heading
encode : YawMode -> Json.Encode.Value
encode x =
  case x of
    Rate -> Json.Encode.string "Rate"
    Heading -> Json.Encode.string "Heading"
decode : Json.Decode.Decoder YawMode
decode =
  Utils.customDecoder Json.Decode.string (\tag ->
    case tag of
      "Rate" -> Ok Rate
      "Heading" -> Ok Heading
      str -> Err ("unrecognized YawMode tag: " ++ str))
{-| YawMode initialized with (arbitrary) default values -}
init : YawMode
init = Rate