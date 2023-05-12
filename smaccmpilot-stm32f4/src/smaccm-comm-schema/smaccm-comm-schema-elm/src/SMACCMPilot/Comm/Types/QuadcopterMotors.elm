module SMACCMPilot.Comm.Types.QuadcopterMotors exposing (..)
import SMACCMPilot.Comm.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline exposing (required)
import Json.Encode
type alias QuadcopterMotors =
  { frontleft : Float
  , frontright : Float
  , backleft : Float
  , backright : Float
  }
encode : QuadcopterMotors -> Json.Encode.Value
encode x =
  Json.Encode.object
    [ ("frontleft", Json.Encode.float x.frontleft)
    , ("frontright", Json.Encode.float x.frontright)
    , ("backleft", Json.Encode.float x.backleft)
    , ("backright", Json.Encode.float x.backright)
    ]
decode : Json.Decode.Decoder QuadcopterMotors
decode = Json.Decode.Pipeline.decode QuadcopterMotors
  |> (required "frontleft" Json.Decode.float)
  |> (required "frontright" Json.Decode.float)
  |> (required "backleft" Json.Decode.float)
  |> (required "backright" Json.Decode.float)
{-| QuadcopterMotors initialized with (arbitrary) default values -}
init : QuadcopterMotors
init =
  { frontleft = 0
  , frontright = 0
  , backleft = 0
  , backright = 0
  }