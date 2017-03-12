port module Main exposing (..)

import Platform exposing (program)
import Syntax exposing (output)


port sendOutput : String -> Cmd msg


init : ( (), Cmd msg )
init =
    ( (), sendOutput output )


update : msg -> () -> ( (), Cmd msg )
update _ _ =
    ( (), Cmd.none )


subscriptions : () -> Sub msg
subscriptions _ =
    Sub.none


main : Program Never () ()
main =
    program
        { init = init
        , update = update
        , subscriptions = subscriptions
        }
