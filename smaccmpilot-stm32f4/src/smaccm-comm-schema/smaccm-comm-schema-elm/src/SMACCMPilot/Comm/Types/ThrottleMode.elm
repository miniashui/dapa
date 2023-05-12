module SMACCMPilot.Comm.Types.ThrottleMode exposing (..)
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type ThrottleMode
  = DirectUi
  | AltUi
  | AltSetpt
encode : ThrottleMode -> Json.Encode.Value
encode x =
  case x of
    DirectUi -> Json.Encode.string "DirectUi"
    AltUi -> Json.Encode.string "AltUi"
    AltSetpt -> Json.Encode.string "AltSetpt"
decode : Json.Decode.Decoder ThrottleMode
decode =
  Utils.customDecoder Json.Decode.string (\tag ->
    case tag of
      "DirectUi" -> Ok DirectUi
      "AltUi" -> Ok AltUi
      "AltSetpt" -> Ok AltSetpt
      str -> Err ("unrecognized ThrottleMode tag: " ++ str))
{-| ThrottleMode initialized with (arbitrary) default values -}
init : ThrottleMode
init = DirectUi