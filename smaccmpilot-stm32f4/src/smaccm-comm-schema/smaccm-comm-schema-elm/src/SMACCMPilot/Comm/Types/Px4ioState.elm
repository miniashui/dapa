module SMACCMPilot.Comm.Types.Px4ioState exposing (..)
import SMACCMPilot.Comm.Types.Px4ioStatus
import SMACCMPilot.Comm.Types.Px4ioAlarms
import SMACCMPilot.Comm.Types.RcInput
import SMACCMPilot.Comm.Types.TimeMicros
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias Px4ioState =
  { comm_ok : Bool
  , status : SMACCMPilot.Comm.Types.Px4ioStatus.Px4ioStatus
  , alarms : SMACCMPilot.Comm.Types.Px4ioAlarms.Px4ioAlarms
  , rc_in : SMACCMPilot.Comm.Types.RcInput.RcInput
  , time : SMACCMPilot.Comm.Types.TimeMicros.TimeMicros
  }
encode : Px4ioState -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("comm_ok", Json.Encode.bool x.comm_ok)
    , ("status", SMACCMPilot.Comm.Types.Px4ioStatus.encode x.status)
    , ("alarms", SMACCMPilot.Comm.Types.Px4ioAlarms.encode x.alarms)
    , ("rc_in", SMACCMPilot.Comm.Types.RcInput.encode x.rc_in)
    , ("time", SMACCMPilot.Comm.Types.TimeMicros.encode x.time)
    ]
decode : Json.Decode.Decoder Px4ioState
decode = Json.Decode.Pipeline.decode Px4ioState
  |> (required "comm_ok" Json.Decode.bool)
  |> (required "status" SMACCMPilot.Comm.Types.Px4ioStatus.decode)
  |> (required "alarms" SMACCMPilot.Comm.Types.Px4ioAlarms.decode)
  |> (required "rc_in" SMACCMPilot.Comm.Types.RcInput.decode)
  |> (required "time" SMACCMPilot.Comm.Types.TimeMicros.decode)
{-| Px4ioState initialized with (arbitrary) default values -}
init : Px4ioState
init =
  { comm_ok = False
  , status = SMACCMPilot.Comm.Types.Px4ioStatus.init
  , alarms = SMACCMPilot.Comm.Types.Px4ioAlarms.init
  , rc_in = SMACCMPilot.Comm.Types.RcInput.init
  , time = SMACCMPilot.Comm.Types.TimeMicros.init
  }