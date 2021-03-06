module Main exposing (..)

import Html exposing (Html, text)


type Breed
    = Sheltie
    | Poodle
    | GoldenRetriever


type alias Dog =
    { name : String
    , age : Int
    , breed : Breed
    }


dog : Dog
dog =
    Dog "Tucker" 11 Sheltie


describeDog : Dog -> String
describeDog dog =
    dog.name ++ " is a " ++ breedToString dog.breed


breedToString : Breed -> String
breedToString breed =
    case breed of
        Sheltie ->
            "sheltie"

        Poodle ->
            "poodle"

        GoldenRetriever ->
            "golden retriever"


type Maybe a
    = Just a
    | Nothing


type alias Person =
    { name : String
    , dog : Maybe Dog
    }


person : Person
person =
    Person "Jeremy" (Just dog)


hasDog : Person -> String
hasDog person =
    case person.dog of
        Nothing ->
            person.name ++ " does not have a dog"

        Just personsDog ->
            person.name ++ " has a " ++ breedToString personsDog.breed


output =
    hasDog person



{--==========================================================================
                         DO NOT MODIFY BELOW THIS LINE
   ==========================================================================--}


main : Html a
main =
    text (toString output)
