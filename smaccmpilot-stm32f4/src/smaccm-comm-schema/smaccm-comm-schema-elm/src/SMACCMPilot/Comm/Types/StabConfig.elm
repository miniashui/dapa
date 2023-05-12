module SMACCMPilot.Comm.Types.StabConfig exposing (..)
import SMACCMPilot.Comm.Types.PidConfig
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias StabConfig =
  { pos : SMACCMPilot.Comm.Types.PidConfig.PidConfig
  , rate : SMACCMPilot.Comm.Types.PidConfig.PidConfig
  }
encode : StabConfig -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("pos", SMACCMPilot.Comm.Types.PidConfig.encode x.pos)
    , ("rate", SMACCMPilot.Comm.Types.PidConfig.encode x.rate)
    ]
decode : Json.Decode.Decoder StabConfig
decode = Json.Decode.Pipeline.decode StabConfig
  |> (required "pos" SMACCMPilot.Comm.Types.PidConfig.decode)
  |> (required "rate" SMACCMPilot.Comm.Types.PidConfig.decode)
{-| StabConfig initialized with (arbitrary) default values -}
init : StabConfig
init =
  { pos = SMACCMPilot.Comm.Types.PidConfig.init
  , rate = SMACCMPilot.Comm.Types.PidConfig.init
  }