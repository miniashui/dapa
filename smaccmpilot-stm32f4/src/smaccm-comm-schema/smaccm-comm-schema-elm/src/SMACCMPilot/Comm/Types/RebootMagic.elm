module SMACCMPilot.Comm.Types.RebootMagic exposing (..)
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type RebootMagic
  = LinuxRebootMagic1
encode : RebootMagic -> Json.Encode.Value
encode x = Json.Encode.list []
decode : Json.Decode.Decoder RebootMagic
decode =
  Utils.customDecoder Json.Decode.string (\tag ->
    case tag of
      "LinuxRebootMagic1" -> Ok LinuxRebootMagic1
      str -> Err ("unrecognized RebootMagic tag: " ++ str))
{-| RebootMagic initialized with (arbitrary) default values -}
init : RebootMagic
init = LinuxRebootMagic1