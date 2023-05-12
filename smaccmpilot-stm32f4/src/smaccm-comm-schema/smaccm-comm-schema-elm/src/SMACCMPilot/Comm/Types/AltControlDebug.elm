module SMACCMPilot.Comm.Types.AltControlDebug exposing (..)
import SMACCMPilot.Comm.Types.PidState
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias AltControlDebug =
  { alt_est : Float
  , alt_rate_est : Float
  , r22_gain : Float
  , ui_setp : Float
  , ui_rate_setp : Float
  , pos : SMACCMPilot.Comm.Types.PidState.PidState
  , vz_fb : Float
  , vz_ff : Float
  , vz_ff_rot : Float
  , vz_ctl : Float
  }
encode : AltControlDebug -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("alt_est", Json.Encode.float x.alt_est)
    , ("alt_rate_est", Json.Encode.float x.alt_rate_est)
    , ("r22_gain", Json.Encode.float x.r22_gain)
    , ("ui_setp", Json.Encode.float x.ui_setp)
    , ("ui_rate_setp", Json.Encode.float x.ui_rate_setp)
    , ("pos", SMACCMPilot.Comm.Types.PidState.encode x.pos)
    , ("vz_fb", Json.Encode.float x.vz_fb)
    , ("vz_ff", Json.Encode.float x.vz_ff)
    , ("vz_ff_rot", Json.Encode.float x.vz_ff_rot)
    , ("vz_ctl", Json.Encode.float x.vz_ctl)
    ]
decode : Json.Decode.Decoder AltControlDebug
decode = Json.Decode.Pipeline.decode AltControlDebug
  |> (required "alt_est" Json.Decode.float)
  |> (required "alt_rate_est" Json.Decode.float)
  |> (required "r22_gain" Json.Decode.float)
  |> (required "ui_setp" Json.Decode.float)
  |> (required "ui_rate_setp" Json.Decode.float)
  |> (required "pos" SMACCMPilot.Comm.Types.PidState.decode)
  |> (required "vz_fb" Json.Decode.float)
  |> (required "vz_ff" Json.Decode.float)
  |> (required "vz_ff_rot" Json.Decode.float)
  |> (required "vz_ctl" Json.Decode.float)
{-| AltControlDebug initialized with (arbitrary) default values -}
init : AltControlDebug
init =
  { alt_est = 0
  , alt_rate_est = 0
  , r22_gain = 0
  , ui_setp = 0
  , ui_rate_setp = 0
  , pos = SMACCMPilot.Comm.Types.PidState.init
  , vz_fb = 0
  , vz_ff = 0
  , vz_ff_rot = 0
  , vz_ctl = 0
  }