module SMACCMPilot.Comm.Types.AttControlDebug exposing (..)
import SMACCMPilot.Comm.Types.PidState
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias AttControlDebug =
  { head_setpt : Float
  , head_rate_est : Float
  , head_rate_setpt : Float
  , head_ctl_p : Float
  , head_ctl_d : Float
  , pitch_setpt : Float
  , pitch_rate_setpt : Float
  , roll_setpt : Float
  , roll_rate_setpt : Float
  , att_pid : SMACCMPilot.Comm.Types.PidState.PidState
  }
encode : AttControlDebug -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("head_setpt", Json.Encode.float x.head_setpt)
    , ("head_rate_est", Json.Encode.float x.head_rate_est)
    , ("head_rate_setpt", Json.Encode.float x.head_rate_setpt)
    , ("head_ctl_p", Json.Encode.float x.head_ctl_p)
    , ("head_ctl_d", Json.Encode.float x.head_ctl_d)
    , ("pitch_setpt", Json.Encode.float x.pitch_setpt)
    , ("pitch_rate_setpt", Json.Encode.float x.pitch_rate_setpt)
    , ("roll_setpt", Json.Encode.float x.roll_setpt)
    , ("roll_rate_setpt", Json.Encode.float x.roll_rate_setpt)
    , ("att_pid", SMACCMPilot.Comm.Types.PidState.encode x.att_pid)
    ]
decode : Json.Decode.Decoder AttControlDebug
decode = Json.Decode.Pipeline.decode AttControlDebug
  |> (required "head_setpt" Json.Decode.float)
  |> (required "head_rate_est" Json.Decode.float)
  |> (required "head_rate_setpt" Json.Decode.float)
  |> (required "head_ctl_p" Json.Decode.float)
  |> (required "head_ctl_d" Json.Decode.float)
  |> (required "pitch_setpt" Json.Decode.float)
  |> (required "pitch_rate_setpt" Json.Decode.float)
  |> (required "roll_setpt" Json.Decode.float)
  |> (required "roll_rate_setpt" Json.Decode.float)
  |> (required "att_pid" SMACCMPilot.Comm.Types.PidState.decode)
{-| AttControlDebug initialized with (arbitrary) default values -}
init : AttControlDebug
init =
  { head_setpt = 0
  , head_rate_est = 0
  , head_rate_setpt = 0
  , head_ctl_p = 0
  , head_ctl_d = 0
  , pitch_setpt = 0
  , pitch_rate_setpt = 0
  , roll_setpt = 0
  , roll_rate_setpt = 0
  , att_pid = SMACCMPilot.Comm.Types.PidState.init
  }