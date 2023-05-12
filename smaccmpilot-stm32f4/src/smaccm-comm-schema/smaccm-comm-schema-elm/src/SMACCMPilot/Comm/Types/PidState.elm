module SMACCMPilot.Comm.Types.PidState exposing (..)
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias PidState =
  { i_state : Float
  , d_term : Float
  , dd_term : Float
  , p_term : Float
  , i_term : Float
  , angle_err : Float
  , rate_err : Float
  }
encode : PidState -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("i_state", Json.Encode.float x.i_state)
    , ("d_term", Json.Encode.float x.d_term)
    , ("dd_term", Json.Encode.float x.dd_term)
    , ("p_term", Json.Encode.float x.p_term)
    , ("i_term", Json.Encode.float x.i_term)
    , ("angle_err", Json.Encode.float x.angle_err)
    , ("rate_err", Json.Encode.float x.rate_err)
    ]
decode : Json.Decode.Decoder PidState
decode = Json.Decode.Pipeline.decode PidState
  |> (required "i_state" Json.Decode.float)
  |> (required "d_term" Json.Decode.float)
  |> (required "dd_term" Json.Decode.float)
  |> (required "p_term" Json.Decode.float)
  |> (required "i_term" Json.Decode.float)
  |> (required "angle_err" Json.Decode.float)
  |> (required "rate_err" Json.Decode.float)
{-| PidState initialized with (arbitrary) default values -}
init : PidState
init =
  { i_state = 0
  , d_term = 0
  , dd_term = 0
  , p_term = 0
  , i_term = 0
  , angle_err = 0
  , rate_err = 0
  }