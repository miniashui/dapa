module SMACCMPilot.Comm.Types.ControlSetpoint exposing (..)
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias ControlSetpoint =
  { altitude : Float
  , alt_rate : Float
  , roll : Float
  , pitch : Float
  , heading : Float
  }
encode : ControlSetpoint -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("altitude", Json.Encode.float x.altitude)
    , ("alt_rate", Json.Encode.float x.alt_rate)
    , ("roll", Json.Encode.float x.roll)
    , ("pitch", Json.Encode.float x.pitch)
    , ("heading", Json.Encode.float x.heading)
    ]
decode : Json.Decode.Decoder ControlSetpoint
decode = Json.Decode.Pipeline.decode ControlSetpoint
  |> (required "altitude" Json.Decode.float)
  |> (required "alt_rate" Json.Decode.float)
  |> (required "roll" Json.Decode.float)
  |> (required "pitch" Json.Decode.float)
  |> (required "heading" Json.Decode.float)
{-| ControlSetpoint initialized with (arbitrary) default values -}
init : ControlSetpoint
init =
  { altitude = 0
  , alt_rate = 0
  , roll = 0
  , pitch = 0
  , heading = 0
  }