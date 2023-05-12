module SMACCMPilot.Comm.Types.Px4ioStatus exposing (..)
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias Px4ioStatus =
  { safety_off : Bool
  , failsafe : Bool
  , init_ok : Bool
  , arm_sync : Bool
  , mixer_ok : Bool
  , raw_pwm : Bool
  , fmu_ok : Bool
  , rc_sbus : Bool
  , rc_dsm : Bool
  , rc_ppm : Bool
  , rc_ok : Bool
  , outputs_armed : Bool
  , override : Bool
  }
encode : Px4ioStatus -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("safety_off", Json.Encode.bool x.safety_off)
    , ("failsafe", Json.Encode.bool x.failsafe)
    , ("init_ok", Json.Encode.bool x.init_ok)
    , ("arm_sync", Json.Encode.bool x.arm_sync)
    , ("mixer_ok", Json.Encode.bool x.mixer_ok)
    , ("raw_pwm", Json.Encode.bool x.raw_pwm)
    , ("fmu_ok", Json.Encode.bool x.fmu_ok)
    , ("rc_sbus", Json.Encode.bool x.rc_sbus)
    , ("rc_dsm", Json.Encode.bool x.rc_dsm)
    , ("rc_ppm", Json.Encode.bool x.rc_ppm)
    , ("rc_ok", Json.Encode.bool x.rc_ok)
    , ("outputs_armed", Json.Encode.bool x.outputs_armed)
    , ("override", Json.Encode.bool x.override)
    ]
decode : Json.Decode.Decoder Px4ioStatus
decode = Json.Decode.Pipeline.decode Px4ioStatus
  |> (required "safety_off" Json.Decode.bool)
  |> (required "failsafe" Json.Decode.bool)
  |> (required "init_ok" Json.Decode.bool)
  |> (required "arm_sync" Json.Decode.bool)
  |> (required "mixer_ok" Json.Decode.bool)
  |> (required "raw_pwm" Json.Decode.bool)
  |> (required "fmu_ok" Json.Decode.bool)
  |> (required "rc_sbus" Json.Decode.bool)
  |> (required "rc_dsm" Json.Decode.bool)
  |> (required "rc_ppm" Json.Decode.bool)
  |> (required "rc_ok" Json.Decode.bool)
  |> (required "outputs_armed" Json.Decode.bool)
  |> (required "override" Json.Decode.bool)
{-| Px4ioStatus initialized with (arbitrary) default values -}
init : Px4ioStatus
init =
  { safety_off = False
  , failsafe = False
  , init_ok = False
  , arm_sync = False
  , mixer_ok = False
  , raw_pwm = False
  , fmu_ok = False
  , rc_sbus = False
  , rc_dsm = False
  , rc_ppm = False
  , rc_ok = False
  , outputs_armed = False
  , override = False
  }