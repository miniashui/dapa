module SMACCMPilot.Comm.Types.GpsFix exposing (..)
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type GpsFix
  = FixNone
  | Fix2d
  | Fix3d
encode : GpsFix -> Json.Encode.Value
encode x =
  case x of
    FixNone -> Json.Encode.string "FixNone"
    Fix2d -> Json.Encode.string "Fix2d"
    Fix3d -> Json.Encode.string "Fix3d"
decode : Json.Decode.Decoder GpsFix
decode =
  Utils.customDecoder Json.Decode.string (\tag ->
    case tag of
      "FixNone" -> Ok FixNone
      "Fix2d" -> Ok Fix2d
      "Fix3d" -> Ok Fix3d
      str -> Err ("unrecognized GpsFix tag: " ++ str))
{-| GpsFix initialized with (arbitrary) default values -}
init : GpsFix
init = FixNone