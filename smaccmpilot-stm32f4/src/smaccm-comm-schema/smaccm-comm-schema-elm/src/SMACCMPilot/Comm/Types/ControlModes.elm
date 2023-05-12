module SMACCMPilot.Comm.Types.ControlModes exposing (..)
import SMACCMPilot.Comm.Types.ControlSource
import SMACCMPilot.Comm.Types.YawMode
import SMACCMPilot.Comm.Types.ThrottleMode
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias ControlModes =
  { ui_mode : SMACCMPilot.Comm.Types.ControlSource.ControlSource
  , yaw_mode : SMACCMPilot.Comm.Types.YawMode.YawMode
  , thr_mode : SMACCMPilot.Comm.Types.ThrottleMode.ThrottleMode
  }
encode : ControlModes -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("ui_mode", SMACCMPilot.Comm.Types.ControlSource.encode x.ui_mode)
    , ("yaw_mode", SMACCMPilot.Comm.Types.YawMode.encode x.yaw_mode)
    , ("thr_mode", SMACCMPilot.Comm.Types.ThrottleMode.encode x.thr_mode)
    ]
decode : Json.Decode.Decoder ControlModes
decode = Json.Decode.Pipeline.decode ControlModes
  |> (required "ui_mode" SMACCMPilot.Comm.Types.ControlSource.decode)
  |> (required "yaw_mode" SMACCMPilot.Comm.Types.YawMode.decode)
  |> (required "thr_mode" SMACCMPilot.Comm.Types.ThrottleMode.decode)
{-| ControlModes initialized with (arbitrary) default values -}
init : ControlModes
init =
  { ui_mode = SMACCMPilot.Comm.Types.ControlSource.init
  , yaw_mode = SMACCMPilot.Comm.Types.YawMode.init
  , thr_mode = SMACCMPilot.Comm.Types.ThrottleMode.init
  }