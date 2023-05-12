module SMACCMPilot.Comm.Types.Px4flowIntegralSample exposing (..)
import SMACCMPilot.Comm.Types.TimeMicros
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias Px4flowIntegralSample =
  { frame_count_since_last_readout : Int
  , pixel_flow_x_integral : Int
  , pixel_flow_y_integral : Int
  , gyro_x_rate_integral : Int
  , gyro_y_rate_integral : Int
  , gyro_z_rate_integral : Int
  , integration_timespan : Int
  , sonar_timestamp : Int
  , ground_distance : Int
  , gyro_temperature : Int
  , quality : Int
  , samplefail : Bool
  , time : SMACCMPilot.Comm.Types.TimeMicros.TimeMicros
  }
encode : Px4flowIntegralSample -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("frame_count_since_last_readout", Json.Encode.int x.frame_count_since_last_readout)
    , ("pixel_flow_x_integral", Json.Encode.int x.pixel_flow_x_integral)
    , ("pixel_flow_y_integral", Json.Encode.int x.pixel_flow_y_integral)
    , ("gyro_x_rate_integral", Json.Encode.int x.gyro_x_rate_integral)
    , ("gyro_y_rate_integral", Json.Encode.int x.gyro_y_rate_integral)
    , ("gyro_z_rate_integral", Json.Encode.int x.gyro_z_rate_integral)
    , ("integration_timespan", Json.Encode.int x.integration_timespan)
    , ("sonar_timestamp", Json.Encode.int x.sonar_timestamp)
    , ("ground_distance", Json.Encode.int x.ground_distance)
    , ("gyro_temperature", Json.Encode.int x.gyro_temperature)
    , ("quality", Json.Encode.int x.quality)
    , ("samplefail", Json.Encode.bool x.samplefail)
    , ("time", SMACCMPilot.Comm.Types.TimeMicros.encode x.time)
    ]
decode : Json.Decode.Decoder Px4flowIntegralSample
decode = Json.Decode.Pipeline.decode Px4flowIntegralSample
  |> (required "frame_count_since_last_readout" Json.Decode.int)
  |> (required "pixel_flow_x_integral" Json.Decode.int)
  |> (required "pixel_flow_y_integral" Json.Decode.int)
  |> (required "gyro_x_rate_integral" Json.Decode.int)
  |> (required "gyro_y_rate_integral" Json.Decode.int)
  |> (required "gyro_z_rate_integral" Json.Decode.int)
  |> (required "integration_timespan" Json.Decode.int)
  |> (required "sonar_timestamp" Json.Decode.int)
  |> (required "ground_distance" Json.Decode.int)
  |> (required "gyro_temperature" Json.Decode.int)
  |> (required "quality" Json.Decode.int)
  |> (required "samplefail" Json.Decode.bool)
  |> (required "time" SMACCMPilot.Comm.Types.TimeMicros.decode)
{-| Px4flowIntegralSample initialized with (arbitrary) default values -}
init : Px4flowIntegralSample
init =
  { frame_count_since_last_readout = 0
  , pixel_flow_x_integral = 0
  , pixel_flow_y_integral = 0
  , gyro_x_rate_integral = 0
  , gyro_y_rate_integral = 0
  , gyro_z_rate_integral = 0
  , integration_timespan = 0
  , sonar_timestamp = 0
  , ground_distance = 0
  , gyro_temperature = 0
  , quality = 0
  , samplefail = False
  , time = SMACCMPilot.Comm.Types.TimeMicros.init
  }