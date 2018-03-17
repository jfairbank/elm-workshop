module Main exposing (..)

import Html exposing (Html, text)


numberList =
    [ 1, 2, 3, 4, 5 ]


doubleNumbers numbers =
    List.map double numbers


double n =
    n * 2


keepGreaterThan3 numbers =
    List.filter gt3 numbers


gt3 n =
    n > 3


doubleAndKeepGreaterThan threshold numbers =
    numbers
        |> List.map double
        |> List.filter (\n -> n > threshold)


concatOperator =
    -- both operands are ALWAYS lists
    numberList ++ [ 6 ]


consOperator =
    -- left operand is ALWAYS single item
    -- right operand is ALWAYS list
    0 :: numberList


dog =
    { name = "Tucker", age = 11 }


haveBirthday dog =
    { dog | age = dog.age + 1 }


dogs =
    [ { name = "Sally", age = 7 }
    , { name = "Tucker", age = 11 }
    ]


findAndHaveBirthday name list =
    List.map
        (\dog ->
            if dog.name == name then
                { dog | age = dog.age + 1 }
            else
                dog
        )
        list


output =
    findAndHaveBirthday "Sally" dogs



{--==========================================================================
                         DO NOT MODIFY BELOW THIS LINE
   ==========================================================================--}


main : Html a
main =
    text (toString output)
