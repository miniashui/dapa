module SMACCMPilot.Comm.Types.MagnetometerSample exposing (..)
import SMACCMPilot.Comm.Types.Xyz
import SMACCMPilot.Comm.Types.TimeMicros
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias MagnetometerSample =
  { initfail : Bool
  , samplefail : Bool
  , sample : SMACCMPilot.Comm.Types.Xyz.Xyz
  , time : SMACCMPilot.Comm.Types.TimeMicros.TimeMicros
  }
encode : MagnetometerSample -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("initfail", Json.Encode.bool x.initfail)
    , ("samplefail", Json.Encode.bool x.samplefail)
    , ("sample", SMACCMPilot.Comm.Types.Xyz.encode x.sample)
    , ("time", SMACCMPilot.Comm.Types.TimeMicros.encode x.time)
    ]
decode : Json.Decode.Decoder MagnetometerSample
decode = Json.Decode.Pipeline.decode MagnetometerSample
  |> (required "initfail" Json.Decode.bool)
  |> (required "samplefail" Json.Decode.bool)
  |> (required "sample" SMACCMPilot.Comm.Types.Xyz.decode)
  |> (required "time" SMACCMPilot.Comm.Types.TimeMicros.decode)
{-| MagnetometerSample initialized with (arbitrary) default values -}
init : MagnetometerSample
init =
  { initfail = False
  , samplefail = False
  , sample = SMACCMPilot.Comm.Types.Xyz.init
  , time = SMACCMPilot.Comm.Types.TimeMicros.init
  }