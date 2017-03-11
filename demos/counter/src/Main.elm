module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


type alias Model =
    Int


type Msg
    = Increment
    | Decrement


initialModel : Model
initialModel =
    0


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( model + 1, Cmd.none )

        Decrement ->
            ( model - 1, Cmd.none )


view : Model -> Html Msg
view model =
    div [ class "counter" ]
        [ div [] [ text (toString model) ]
        , button [ onClick Increment ] [ text "Increment" ]
        , button [ onClick Decrement ] [ text "Decrement" ]
        ]


subscriptions : Model -> Sub msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
