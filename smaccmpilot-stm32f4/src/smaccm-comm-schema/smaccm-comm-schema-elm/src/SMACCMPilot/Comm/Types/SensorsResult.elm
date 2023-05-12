module SMACCMPilot.Comm.Types.SensorsResult exposing (..)
import SMACCMPilot.Comm.Types.Xyz
import SMACCMPilot.Comm.Types.Quaternion
import SMACCMPilot.Comm.Types.TimeMicros
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias SensorsResult =
  { valid : Bool
  , roll : Float
  , pitch : Float
  , yaw : Float
  , omega : SMACCMPilot.Comm.Types.Xyz.Xyz
  , attitude : SMACCMPilot.Comm.Types.Quaternion.Quaternion
  , baro_alt : Float
  , lidar_alt : Float
  , sonar_alt : Float
  , accel : SMACCMPilot.Comm.Types.Xyz.Xyz
  , ahrs_time : SMACCMPilot.Comm.Types.TimeMicros.TimeMicros
  , baro_time : SMACCMPilot.Comm.Types.TimeMicros.TimeMicros
  , lidar_time : SMACCMPilot.Comm.Types.TimeMicros.TimeMicros
  }
encode : SensorsResult -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("valid", Json.Encode.bool x.valid)
    , ("roll", Json.Encode.float x.roll)
    , ("pitch", Json.Encode.float x.pitch)
    , ("yaw", Json.Encode.float x.yaw)
    , ("omega", SMACCMPilot.Comm.Types.Xyz.encode x.omega)
    , ("attitude", SMACCMPilot.Comm.Types.Quaternion.encode x.attitude)
    , ("baro_alt", Json.Encode.float x.baro_alt)
    , ("lidar_alt", Json.Encode.float x.lidar_alt)
    , ("sonar_alt", Json.Encode.float x.sonar_alt)
    , ("accel", SMACCMPilot.Comm.Types.Xyz.encode x.accel)
    , ("ahrs_time", SMACCMPilot.Comm.Types.TimeMicros.encode x.ahrs_time)
    , ("baro_time", SMACCMPilot.Comm.Types.TimeMicros.encode x.baro_time)
    , ("lidar_time", SMACCMPilot.Comm.Types.TimeMicros.encode x.lidar_time)
    ]
decode : Json.Decode.Decoder SensorsResult
decode = Json.Decode.Pipeline.decode SensorsResult
  |> (required "valid" Json.Decode.bool)
  |> (required "roll" Json.Decode.float)
  |> (required "pitch" Json.Decode.float)
  |> (required "yaw" Json.Decode.float)
  |> (required "omega" SMACCMPilot.Comm.Types.Xyz.decode)
  |> (required "attitude" SMACCMPilot.Comm.Types.Quaternion.decode)
  |> (required "baro_alt" Json.Decode.float)
  |> (required "lidar_alt" Json.Decode.float)
  |> (required "sonar_alt" Json.Decode.float)
  |> (required "accel" SMACCMPilot.Comm.Types.Xyz.decode)
  |> (required "ahrs_time" SMACCMPilot.Comm.Types.TimeMicros.decode)
  |> (required "baro_time" SMACCMPilot.Comm.Types.TimeMicros.decode)
  |> (required "lidar_time" SMACCMPilot.Comm.Types.TimeMicros.decode)
{-| SensorsResult initialized with (arbitrary) default values -}
init : SensorsResult
init =
  { valid = False
  , roll = 0
  , pitch = 0
  , yaw = 0
  , omega = SMACCMPilot.Comm.Types.Xyz.init
  , attitude = SMACCMPilot.Comm.Types.Quaternion.init
  , baro_alt = 0
  , lidar_alt = 0
  , sonar_alt = 0
  , accel = SMACCMPilot.Comm.Types.Xyz.init
  , ahrs_time = SMACCMPilot.Comm.Types.TimeMicros.init
  , baro_time = SMACCMPilot.Comm.Types.TimeMicros.init
  , lidar_time = SMACCMPilot.Comm.Types.TimeMicros.init
  }