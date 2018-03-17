module Main exposing (..)

import Html exposing (Html, text)


greeting : String
greeting =
    "Hello"


life : Int
life =
    42


pi : Float
pi =
    3.14


numberList : List Int
numberList =
    [ 1, 2, 3, 4, 5 ]


greet : String -> String
greet name =
    "Hello, " ++ name


add : Int -> Int -> Int
add x y =
    x + y


type alias Id =
    Int


type alias Dog =
    { id : Id
    , name : String
    , age : Int
    }


dog : Dog
dog =
    Dog 1 "Tucker" 11


haveBirthday : Dog -> Dog
haveBirthday dog =
    { dog | age = dog.age + 1 }


output =
    haveBirthday dog



{--==========================================================================
                         DO NOT MODIFY BELOW THIS LINE
   ==========================================================================--}


main : Html a
main =
    text (toString output)
