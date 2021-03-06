module Main exposing (main)

import Html exposing (Html, text)


greeting =
    "Hello"


life =
    42


pi =
    3.14


learningElm =
    True


greet name =
    "Hello, " ++ name


greet2 greeting name =
    greeting ++ ", " ++ name


greetInEnglish =
    greet2 "Hello"


greetInSpanish =
    greet2 "Hola"


add x y =
    x + y


increment =
    add 1


status isReady =
    if isReady then
        "Ready to go."
    else
        "Please wait."


exclaim phrase =
    phrase ++ "!"


excitedGreeting name =
    name
        |> String.toUpper
        |> greet2 "Hi"
        |> exclaim


output =
    excitedGreeting "Elm"



{--==========================================================================
                         DO NOT MODIFY BELOW THIS LINE
   ==========================================================================--}


main : Html a
main =
    text (toString output)
