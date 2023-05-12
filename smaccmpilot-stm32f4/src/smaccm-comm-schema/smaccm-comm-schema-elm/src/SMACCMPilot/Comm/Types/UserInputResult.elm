module SMACCMPilot.Comm.Types.UserInputResult exposing (..)
import SMACCMPilot.Comm.Types.UserInput
import SMACCMPilot.Comm.Types.ControlSource
import SMACCMPilot.Comm.Types.TimeMicros
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias UserInputResult =
  { ui : SMACCMPilot.Comm.Types.UserInput.UserInput
  , source : SMACCMPilot.Comm.Types.ControlSource.ControlSource
  , time : SMACCMPilot.Comm.Types.TimeMicros.TimeMicros
  }
encode : UserInputResult -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("ui", SMACCMPilot.Comm.Types.UserInput.encode x.ui)
    , ("source", SMACCMPilot.Comm.Types.ControlSource.encode x.source)
    , ("time", SMACCMPilot.Comm.Types.TimeMicros.encode x.time)
    ]
decode : Json.Decode.Decoder UserInputResult
decode = Json.Decode.Pipeline.decode UserInputResult
  |> (required "ui" SMACCMPilot.Comm.Types.UserInput.decode)
  |> (required "source" SMACCMPilot.Comm.Types.ControlSource.decode)
  |> (required "time" SMACCMPilot.Comm.Types.TimeMicros.decode)
{-| UserInputResult initialized with (arbitrary) default values -}
init : UserInputResult
init =
  { ui = SMACCMPilot.Comm.Types.UserInput.init
  , source = SMACCMPilot.Comm.Types.ControlSource.init
  , time = SMACCMPilot.Comm.Types.TimeMicros.init
  }