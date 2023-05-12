module SMACCMPilot.Comm.Types.PidConfig exposing (..)
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias PidConfig =
  { p_gain : Float
  , i_gain : Float
  , d_gain : Float
  , dd_gain : Float
  , i_min : Float
  , i_max : Float
  , err_max : Float
  , errd_max : Float
  }
encode : PidConfig -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("p_gain", Json.Encode.float x.p_gain)
    , ("i_gain", Json.Encode.float x.i_gain)
    , ("d_gain", Json.Encode.float x.d_gain)
    , ("dd_gain", Json.Encode.float x.dd_gain)
    , ("i_min", Json.Encode.float x.i_min)
    , ("i_max", Json.Encode.float x.i_max)
    , ("err_max", Json.Encode.float x.err_max)
    , ("errd_max", Json.Encode.float x.errd_max)
    ]
decode : Json.Decode.Decoder PidConfig
decode = Json.Decode.Pipeline.decode PidConfig
  |> (required "p_gain" Json.Decode.float)
  |> (required "i_gain" Json.Decode.float)
  |> (required "d_gain" Json.Decode.float)
  |> (required "dd_gain" Json.Decode.float)
  |> (required "i_min" Json.Decode.float)
  |> (required "i_max" Json.Decode.float)
  |> (required "err_max" Json.Decode.float)
  |> (required "errd_max" Json.Decode.float)
{-| PidConfig initialized with (arbitrary) default values -}
init : PidConfig
init =
  { p_gain = 0
  , i_gain = 0
  , d_gain = 0
  , dd_gain = 0
  , i_min = 0
  , i_max = 0
  , err_max = 0
  , errd_max = 0
  }