module SMACCMPilot.Comm.Types.PositionSample exposing (..)
import SMACCMPilot.Comm.Types.GpsFix
import SMACCMPilot.Comm.Types.TimeMicros
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias PositionSample =
  { fix : SMACCMPilot.Comm.Types.GpsFix.GpsFix
  , num_sv : Int
  , dop : Float
  , lat : Int
  , lon : Int
  , alt : Int
  , vnorth : Int
  , veast : Int
  , vdown : Int
  , vground : Int
  , heading : Float
  , time : SMACCMPilot.Comm.Types.TimeMicros.TimeMicros
  }
encode : PositionSample -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("fix", SMACCMPilot.Comm.Types.GpsFix.encode x.fix)
    , ("num_sv", Json.Encode.int x.num_sv)
    , ("dop", Json.Encode.float x.dop)
    , ("lat", Json.Encode.int x.lat)
    , ("lon", Json.Encode.int x.lon)
    , ("alt", Json.Encode.int x.alt)
    , ("vnorth", Json.Encode.int x.vnorth)
    , ("veast", Json.Encode.int x.veast)
    , ("vdown", Json.Encode.int x.vdown)
    , ("vground", Json.Encode.int x.vground)
    , ("heading", Json.Encode.float x.heading)
    , ("time", SMACCMPilot.Comm.Types.TimeMicros.encode x.time)
    ]
decode : Json.Decode.Decoder PositionSample
decode = Json.Decode.Pipeline.decode PositionSample
  |> (required "fix" SMACCMPilot.Comm.Types.GpsFix.decode)
  |> (required "num_sv" Json.Decode.int)
  |> (required "dop" Json.Decode.float)
  |> (required "lat" Json.Decode.int)
  |> (required "lon" Json.Decode.int)
  |> (required "alt" Json.Decode.int)
  |> (required "vnorth" Json.Decode.int)
  |> (required "veast" Json.Decode.int)
  |> (required "vdown" Json.Decode.int)
  |> (required "vground" Json.Decode.int)
  |> (required "heading" Json.Decode.float)
  |> (required "time" SMACCMPilot.Comm.Types.TimeMicros.decode)
{-| PositionSample initialized with (arbitrary) default values -}
init : PositionSample
init =
  { fix = SMACCMPilot.Comm.Types.GpsFix.init
  , num_sv = 0
  , dop = 0
  , lat = 0
  , lon = 0
  , alt = 0
  , vnorth = 0
  , veast = 0
  , vdown = 0
  , vground = 0
  , heading = 0
  , time = SMACCMPilot.Comm.Types.TimeMicros.init
  }