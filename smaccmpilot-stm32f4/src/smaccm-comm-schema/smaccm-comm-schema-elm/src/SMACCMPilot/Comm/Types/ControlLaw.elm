module SMACCMPilot.Comm.Types.ControlLaw exposing (..)
import SMACCMPilot.Comm.Types.ArmingMode
import SMACCMPilot.Comm.Types.ControlModes
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias ControlLaw =
  { arming_mode : SMACCMPilot.Comm.Types.ArmingMode.ArmingMode
  , control_modes : SMACCMPilot.Comm.Types.ControlModes.ControlModes
  }
encode : ControlLaw -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("arming_mode", SMACCMPilot.Comm.Types.ArmingMode.encode x.arming_mode)
    , ("control_modes", SMACCMPilot.Comm.Types.ControlModes.encode x.control_modes)
    ]
decode : Json.Decode.Decoder ControlLaw
decode = Json.Decode.Pipeline.decode ControlLaw
  |> (required "arming_mode" SMACCMPilot.Comm.Types.ArmingMode.decode)
  |> (required "control_modes" SMACCMPilot.Comm.Types.ControlModes.decode)
{-| ControlLaw initialized with (arbitrary) default values -}
init : ControlLaw
init =
  { arming_mode = SMACCMPilot.Comm.Types.ArmingMode.init
  , control_modes = SMACCMPilot.Comm.Types.ControlModes.init
  }