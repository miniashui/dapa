module SMACCMPilot.Comm.Types.BarometerSample exposing (..)
import SMACCMPilot.Comm.Types.TimeMicros
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias BarometerSample =
  { initfail : Bool
  , samplefail : Bool
  , pressure : Float
  , temperature : Float
  , time : SMACCMPilot.Comm.Types.TimeMicros.TimeMicros
  }
encode : BarometerSample -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("initfail", Json.Encode.bool x.initfail)
    , ("samplefail", Json.Encode.bool x.samplefail)
    , ("pressure", Json.Encode.float x.pressure)
    , ("temperature", Json.Encode.float x.temperature)
    , ("time", SMACCMPilot.Comm.Types.TimeMicros.encode x.time)
    ]
decode : Json.Decode.Decoder BarometerSample
decode = Json.Decode.Pipeline.decode BarometerSample
  |> (required "initfail" Json.Decode.bool)
  |> (required "samplefail" Json.Decode.bool)
  |> (required "pressure" Json.Decode.float)
  |> (required "temperature" Json.Decode.float)
  |> (required "time" SMACCMPilot.Comm.Types.TimeMicros.decode)
{-| BarometerSample initialized with (arbitrary) default values -}
init : BarometerSample
init =
  { initfail = False
  , samplefail = False
  , pressure = 0
  , temperature = 0
  , time = SMACCMPilot.Comm.Types.TimeMicros.init
  }