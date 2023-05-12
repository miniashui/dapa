module SMACCMPilot.Comm.Types.RebootReq exposing (..)
import SMACCMPilot.Comm.Types.RebootMagic
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias RebootReq =
  { magic : SMACCMPilot.Comm.Types.RebootMagic.RebootMagic
  }
encode : RebootReq -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("magic", SMACCMPilot.Comm.Types.RebootMagic.encode x.magic)
    ]
decode : Json.Decode.Decoder RebootReq
decode = Json.Decode.Pipeline.decode RebootReq
  |> (required "magic" SMACCMPilot.Comm.Types.RebootMagic.decode)
{-| RebootReq initialized with (arbitrary) default values -}
init : RebootReq
init =
  { magic = SMACCMPilot.Comm.Types.RebootMagic.init
  }