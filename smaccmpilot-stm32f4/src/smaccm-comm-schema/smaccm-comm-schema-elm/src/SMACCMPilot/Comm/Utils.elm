module SMACCMPilot.Comm.Utils exposing (..)

import Http
import Json.Decode as Json
import Time

send_ err ok req =
  let k res = case res of
                Ok v -> ok v
                Err e -> err e
  in Http.send k req

get_ to url decoder =
  Http.request
    { method = "GET"
    , headers = []
    , url = url
    , body = Http.emptyBody
    , expect = Http.expectJson decoder
    , timeout = Just to
    , withCredentials = False
    }

post_ to url body =
  Http.request
    { method = "POST"
    , headers = []
    , url = url
    , body = body
    , expect = Http.expectStringResponse (\_ -> Ok ())
    , timeout = Just to
    , withCredentials = False
    }

customDecoder decoder toResult =
   Json.andThen
     (\a ->
        case toResult a of
          Ok b -> Json.succeed b
          Err err -> Json.fail err
     )
     decoder