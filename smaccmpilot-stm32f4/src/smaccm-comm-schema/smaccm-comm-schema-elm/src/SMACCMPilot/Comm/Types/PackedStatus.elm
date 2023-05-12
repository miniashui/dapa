module SMACCMPilot.Comm.Types.PackedStatus exposing (..)
import SMACCMPilot.Comm.Types.GpsFix
import SMACCMPilot.Comm.Types.Tristate
import SMACCMPilot.Comm.Types.ArmingMode
import SMACCMPilot.Comm.Types.ControlModes
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias PackedStatus =
  { valid : Bool
  , roll : Float
  , pitch : Float
  , yaw : Float
  , alt_est : Float
  , fix : SMACCMPilot.Comm.Types.GpsFix.GpsFix
  , num_sv : Int
  , lat : Int
  , lon : Int
  , alt : Int
  , vground : Int
  , heading : Float
  , rcinput : SMACCMPilot.Comm.Types.Tristate.Tristate
  , telem : SMACCMPilot.Comm.Types.Tristate.Tristate
  , px4io : SMACCMPilot.Comm.Types.Tristate.Tristate
  , sens_valid : SMACCMPilot.Comm.Types.Tristate.Tristate
  , arming_mode : SMACCMPilot.Comm.Types.ArmingMode.ArmingMode
  , control_modes : SMACCMPilot.Comm.Types.ControlModes.ControlModes
  , battery_voltage : Float
  }
encode : PackedStatus -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("valid", Json.Encode.bool x.valid)
    , ("roll", Json.Encode.float x.roll)
    , ("pitch", Json.Encode.float x.pitch)
    , ("yaw", Json.Encode.float x.yaw)
    , ("alt_est", Json.Encode.float x.alt_est)
    , ("fix", SMACCMPilot.Comm.Types.GpsFix.encode x.fix)
    , ("num_sv", Json.Encode.int x.num_sv)
    , ("lat", Json.Encode.int x.lat)
    , ("lon", Json.Encode.int x.lon)
    , ("alt", Json.Encode.int x.alt)
    , ("vground", Json.Encode.int x.vground)
    , ("heading", Json.Encode.float x.heading)
    , ("rcinput", SMACCMPilot.Comm.Types.Tristate.encode x.rcinput)
    , ("telem", SMACCMPilot.Comm.Types.Tristate.encode x.telem)
    , ("px4io", SMACCMPilot.Comm.Types.Tristate.encode x.px4io)
    , ("sens_valid", SMACCMPilot.Comm.Types.Tristate.encode x.sens_valid)
    , ("arming_mode", SMACCMPilot.Comm.Types.ArmingMode.encode x.arming_mode)
    , ("control_modes", SMACCMPilot.Comm.Types.ControlModes.encode x.control_modes)
    , ("battery_voltage", Json.Encode.float x.battery_voltage)
    ]
decode : Json.Decode.Decoder PackedStatus
decode = Json.Decode.Pipeline.decode PackedStatus
  |> (required "valid" Json.Decode.bool)
  |> (required "roll" Json.Decode.float)
  |> (required "pitch" Json.Decode.float)
  |> (required "yaw" Json.Decode.float)
  |> (required "alt_est" Json.Decode.float)
  |> (required "fix" SMACCMPilot.Comm.Types.GpsFix.decode)
  |> (required "num_sv" Json.Decode.int)
  |> (required "lat" Json.Decode.int)
  |> (required "lon" Json.Decode.int)
  |> (required "alt" Json.Decode.int)
  |> (required "vground" Json.Decode.int)
  |> (required "heading" Json.Decode.float)
  |> (required "rcinput" SMACCMPilot.Comm.Types.Tristate.decode)
  |> (required "telem" SMACCMPilot.Comm.Types.Tristate.decode)
  |> (required "px4io" SMACCMPilot.Comm.Types.Tristate.decode)
  |> (required "sens_valid" SMACCMPilot.Comm.Types.Tristate.decode)
  |> (required "arming_mode" SMACCMPilot.Comm.Types.ArmingMode.decode)
  |> (required "control_modes" SMACCMPilot.Comm.Types.ControlModes.decode)
  |> (required "battery_voltage" Json.Decode.float)
{-| PackedStatus initialized with (arbitrary) default values -}
init : PackedStatus
init =
  { valid = False
  , roll = 0
  , pitch = 0
  , yaw = 0
  , alt_est = 0
  , fix = SMACCMPilot.Comm.Types.GpsFix.init
  , num_sv = 0
  , lat = 0
  , lon = 0
  , alt = 0
  , vground = 0
  , heading = 0
  , rcinput = SMACCMPilot.Comm.Types.Tristate.init
  , telem = SMACCMPilot.Comm.Types.Tristate.init
  , px4io = SMACCMPilot.Comm.Types.Tristate.init
  , sens_valid = SMACCMPilot.Comm.Types.Tristate.init
  , arming_mode = SMACCMPilot.Comm.Types.ArmingMode.init
  , control_modes = SMACCMPilot.Comm.Types.ControlModes.init
  , battery_voltage = 0
  }