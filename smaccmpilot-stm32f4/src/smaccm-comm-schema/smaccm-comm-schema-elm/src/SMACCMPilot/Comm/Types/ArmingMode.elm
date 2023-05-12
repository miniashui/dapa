module SMACCMPilot.Comm.Types.ArmingMode exposing (..)
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type ArmingMode
  = Safe
  | Armed
encode : ArmingMode -> Json.Encode.Value
encode x =
  case x of
    Safe -> Json.Encode.string "Safe"
    Armed -> Json.Encode.string "Armed"
decode : Json.Decode.Decoder ArmingMode
decode =
  Utils.customDecoder Json.Decode.string (\tag ->
    case tag of
      "Safe" -> Ok Safe
      "Armed" -> Ok Armed
      str -> Err ("unrecognized ArmingMode tag: " ++ str))
{-| ArmingMode initialized with (arbitrary) default values -}
init : ArmingMode
init = Safe