module Main exposing (..)

import GitHub
import Todo
import Html exposing (..)


type alias Model =
    { todo : Todo.Model
    , github : GitHub.Model
    }


type Msg
    = TodoMsg Todo.Msg
    | GitHubMsg GitHub.Msg


initialModel : Model
initialModel =
    Model Todo.initialModel GitHub.initialModel


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TodoMsg todoMsg ->
            let
                newTodo =
                    Todo.update todoMsg model.todo
            in
                ( { model | todo = newTodo }
                , Cmd.none
                )

        GitHubMsg githubMsg ->
            let
                ( newGitHub, githubCmd ) =
                    GitHub.update githubMsg model.github
            in
                ( { model | github = newGitHub }
                , Cmd.map GitHubMsg githubCmd
                )


view : Model -> Html Msg
view model =
    div []
        [ Html.map TodoMsg (Todo.view model.todo)
        , hr [] []
        , Html.map GitHubMsg (GitHub.view model.github)
        ]


subscriptions : Model -> Sub Msg
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
