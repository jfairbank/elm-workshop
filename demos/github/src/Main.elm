module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, disabled, type_, value)
import Html.Events exposing (onInput)


type alias User =
    { id : Int
    , login : String
    , name : String
    , bio : String
    , avatarUrl : String
    }


type alias Model =
    { login : String
    , user : Maybe User
    }


type Msg
    = UpdateLogin String


initialModel : Model
initialModel =
    Model "" Nothing


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateLogin login ->
            ( { model | login = login }
            , Cmd.none
            )


view : Model -> Html Msg
view model =
    div [ class "find-user" ]
        [ h2 [] [ text "Find GitHub User" ]
        , label [] [ text "Login:" ]
        , input
            [ type_ "text"
            , value model.login
            , onInput UpdateLogin
            ]
            []
        , button
            [ class "btn btn-primary"
            , disabled (model.login == "")
            ]
            [ text "Find" ]
        ]


subscriptions : Model -> Sub msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
