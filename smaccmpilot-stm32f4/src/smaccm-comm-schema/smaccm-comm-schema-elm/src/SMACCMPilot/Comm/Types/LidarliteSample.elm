module SMACCMPilot.Comm.Types.LidarliteSample exposing (..)
import SMACCMPilot.Comm.Types.TimeMicros
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias LidarliteSample =
  { samplefail : Bool
  , distance : Float
  , time : SMACCMPilot.Comm.Types.TimeMicros.TimeMicros
  }
encode : LidarliteSample -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("samplefail", Json.Encode.bool x.samplefail)
    , ("distance", Json.Encode.float x.distance)
    , ("time", SMACCMPilot.Comm.Types.TimeMicros.encode x.time)
    ]
decode : Json.Decode.Decoder LidarliteSample
decode = Json.Decode.Pipeline.decode LidarliteSample
  |> (required "samplefail" Json.Decode.bool)
  |> (required "distance" Json.Decode.float)
  |> (required "time" SMACCMPilot.Comm.Types.TimeMicros.decode)
{-| LidarliteSample initialized with (arbitrary) default values -}
init : LidarliteSample
init =
  { samplefail = False
  , distance = 0
  , time = SMACCMPilot.Comm.Types.TimeMicros.init
  }