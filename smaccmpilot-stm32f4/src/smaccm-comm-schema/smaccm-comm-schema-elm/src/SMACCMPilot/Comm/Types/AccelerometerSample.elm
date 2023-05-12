module SMACCMPilot.Comm.Types.AccelerometerSample exposing (..)
import SMACCMPilot.Comm.Types.Xyz
import SMACCMPilot.Comm.Types.TimeMicros
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias AccelerometerSample =
  { initfail : Bool
  , samplefail : Bool
  , sample : SMACCMPilot.Comm.Types.Xyz.Xyz
  , temperature : Float
  , time : SMACCMPilot.Comm.Types.TimeMicros.TimeMicros
  }
encode : AccelerometerSample -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("initfail", Json.Encode.bool x.initfail)
    , ("samplefail", Json.Encode.bool x.samplefail)
    , ("sample", SMACCMPilot.Comm.Types.Xyz.encode x.sample)
    , ("temperature", Json.Encode.float x.temperature)
    , ("time", SMACCMPilot.Comm.Types.TimeMicros.encode x.time)
    ]
decode : Json.Decode.Decoder AccelerometerSample
decode = Json.Decode.Pipeline.decode AccelerometerSample
  |> (required "initfail" Json.Decode.bool)
  |> (required "samplefail" Json.Decode.bool)
  |> (required "sample" SMACCMPilot.Comm.Types.Xyz.decode)
  |> (required "temperature" Json.Decode.float)
  |> (required "time" SMACCMPilot.Comm.Types.TimeMicros.decode)
{-| AccelerometerSample initialized with (arbitrary) default values -}
init : AccelerometerSample
init =
  { initfail = False
  , samplefail = False
  , sample = SMACCMPilot.Comm.Types.Xyz.init
  , temperature = 0
  , time = SMACCMPilot.Comm.Types.TimeMicros.init
  }