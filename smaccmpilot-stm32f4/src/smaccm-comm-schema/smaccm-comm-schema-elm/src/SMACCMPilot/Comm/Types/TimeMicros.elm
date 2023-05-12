module SMACCMPilot.Comm.Types.TimeMicros exposing (..)
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias TimeMicros = Int
encode : TimeMicros -> Json.Encode.Value
encode = Json.Encode.int
decode : Json.Decode.Decoder TimeMicros
decode = Json.Decode.int
{-| TimeMicros initialized with (arbitrary) default values -}
init : TimeMicros
init = 0