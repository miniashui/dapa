module SMACCMPilot.Comm.Types.ControlSource exposing (..)
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type ControlSource
  = Ppm
  | Gcs
  | Nav
encode : ControlSource -> Json.Encode.Value
encode x =
  case x of
    Ppm -> Json.Encode.string "Ppm"
    Gcs -> Json.Encode.string "Gcs"
    Nav -> Json.Encode.string "Nav"
decode : Json.Decode.Decoder ControlSource
decode =
  Utils.customDecoder Json.Decode.string (\tag ->
    case tag of
      "Ppm" -> Ok Ppm
      "Gcs" -> Ok Gcs
      "Nav" -> Ok Nav
      str -> Err ("unrecognized ControlSource tag: " ++ str))
{-| ControlSource initialized with (arbitrary) default values -}
init : ControlSource
init = Ppm