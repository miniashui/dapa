module SMACCMPilot.Comm.Types.ArmingStatus exposing (..)
import SMACCMPilot.Comm.Types.Tristate
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias ArmingStatus =
  { rcinput : SMACCMPilot.Comm.Types.Tristate.Tristate
  , telem : SMACCMPilot.Comm.Types.Tristate.Tristate
  , px4io : SMACCMPilot.Comm.Types.Tristate.Tristate
  , sens_valid : SMACCMPilot.Comm.Types.Tristate.Tristate
  }
encode : ArmingStatus -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("rcinput", SMACCMPilot.Comm.Types.Tristate.encode x.rcinput)
    , ("telem", SMACCMPilot.Comm.Types.Tristate.encode x.telem)
    , ("px4io", SMACCMPilot.Comm.Types.Tristate.encode x.px4io)
    , ("sens_valid", SMACCMPilot.Comm.Types.Tristate.encode x.sens_valid)
    ]
decode : Json.Decode.Decoder ArmingStatus
decode = Json.Decode.Pipeline.decode ArmingStatus
  |> (required "rcinput" SMACCMPilot.Comm.Types.Tristate.decode)
  |> (required "telem" SMACCMPilot.Comm.Types.Tristate.decode)
  |> (required "px4io" SMACCMPilot.Comm.Types.Tristate.decode)
  |> (required "sens_valid" SMACCMPilot.Comm.Types.Tristate.decode)
{-| ArmingStatus initialized with (arbitrary) default values -}
init : ArmingStatus
init =
  { rcinput = SMACCMPilot.Comm.Types.Tristate.init
  , telem = SMACCMPilot.Comm.Types.Tristate.init
  , px4io = SMACCMPilot.Comm.Types.Tristate.init
  , sens_valid = SMACCMPilot.Comm.Types.Tristate.init
  }