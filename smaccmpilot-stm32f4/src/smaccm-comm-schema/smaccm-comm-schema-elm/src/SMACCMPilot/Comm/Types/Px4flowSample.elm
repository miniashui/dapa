module SMACCMPilot.Comm.Types.Px4flowSample exposing (..)
import SMACCMPilot.Comm.Types.TimeMicros
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias Px4flowSample =
  { frame_count : Int
  , pixel_flow_x_sum : Int
  , pixel_flow_y_sum : Int
  , flow_comp_m_x : Int
  , flow_comp_m_y : Int
  , quality : Int
  , gyro_x_rate : Int
  , gyro_y_rate : Int
  , gyro_z_rate : Int
  , gyro_range : Int
  , sonar_timestamp : Int
  , ground_distance : Int
  , samplefail : Bool
  , time : SMACCMPilot.Comm.Types.TimeMicros.TimeMicros
  }
encode : Px4flowSample -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("frame_count", Json.Encode.int x.frame_count)
    , ("pixel_flow_x_sum", Json.Encode.int x.pixel_flow_x_sum)
    , ("pixel_flow_y_sum", Json.Encode.int x.pixel_flow_y_sum)
    , ("flow_comp_m_x", Json.Encode.int x.flow_comp_m_x)
    , ("flow_comp_m_y", Json.Encode.int x.flow_comp_m_y)
    , ("quality", Json.Encode.int x.quality)
    , ("gyro_x_rate", Json.Encode.int x.gyro_x_rate)
    , ("gyro_y_rate", Json.Encode.int x.gyro_y_rate)
    , ("gyro_z_rate", Json.Encode.int x.gyro_z_rate)
    , ("gyro_range", Json.Encode.int x.gyro_range)
    , ("sonar_timestamp", Json.Encode.int x.sonar_timestamp)
    , ("ground_distance", Json.Encode.int x.ground_distance)
    , ("samplefail", Json.Encode.bool x.samplefail)
    , ("time", SMACCMPilot.Comm.Types.TimeMicros.encode x.time)
    ]
decode : Json.Decode.Decoder Px4flowSample
decode = Json.Decode.Pipeline.decode Px4flowSample
  |> (required "frame_count" Json.Decode.int)
  |> (required "pixel_flow_x_sum" Json.Decode.int)
  |> (required "pixel_flow_y_sum" Json.Decode.int)
  |> (required "flow_comp_m_x" Json.Decode.int)
  |> (required "flow_comp_m_y" Json.Decode.int)
  |> (required "quality" Json.Decode.int)
  |> (required "gyro_x_rate" Json.Decode.int)
  |> (required "gyro_y_rate" Json.Decode.int)
  |> (required "gyro_z_rate" Json.Decode.int)
  |> (required "gyro_range" Json.Decode.int)
  |> (required "sonar_timestamp" Json.Decode.int)
  |> (required "ground_distance" Json.Decode.int)
  |> (required "samplefail" Json.Decode.bool)
  |> (required "time" SMACCMPilot.Comm.Types.TimeMicros.decode)
{-| Px4flowSample initialized with (arbitrary) default values -}
init : Px4flowSample
init =
  { frame_count = 0
  , pixel_flow_x_sum = 0
  , pixel_flow_y_sum = 0
  , flow_comp_m_x = 0
  , flow_comp_m_y = 0
  , quality = 0
  , gyro_x_rate = 0
  , gyro_y_rate = 0
  , gyro_z_rate = 0
  , gyro_range = 0
  , sonar_timestamp = 0
  , ground_distance = 0
  , samplefail = False
  , time = SMACCMPilot.Comm.Types.TimeMicros.init
  }