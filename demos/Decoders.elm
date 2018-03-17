module Main exposing (..)

import Html exposing (Html, text)
import Json.Decode exposing (Decoder, bool, decodeString, field, int, map2, nullable, string)
import Json.Decode.Pipeline exposing (decode, optional, required)


greetingJson : String
greetingJson =
    "\"Hello\""


greeting : Result String String
greeting =
    decodeString string greetingJson


life : Result String Int
life =
    decodeString int "42"


type alias Todo =
    { title : String
    , complete : Bool
    , description : String
    }


titleDecoder : Decoder String
titleDecoder =
    field "title" string


todoJson : String
todoJson =
    """{"title": "Learn Elm", "complete": false, "description": "A todo"}"""


title : Result String String
title =
    decodeString titleDecoder todoJson



{--
todoDecoder : Decoder Todo
todoDecoder =
    map2 Todo
        titleDecoder
        (field "complete" bool)
--}


altTodoDecoder : Decoder Todo
altTodoDecoder =
    decode Todo
        |> required "title" string
        |> required "complete" bool
        |> optional "description" string "<No Description>"


todo : Result String Todo
todo =
    decodeString altTodoDecoder todoJson


todoDescription : String
todoDescription =
    case todo of
        Ok t ->
            "Is '" ++ t.title ++ "' done? " ++ toString t.complete

        Err error ->
            "Couldn't process todo: " ++ error


output =
    todoDescription



{--==========================================================================
                         DO NOT MODIFY BELOW THIS LINE
   ==========================================================================--}


main : Html a
main =
    text (toString output)
