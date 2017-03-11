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


updateComponent : (cmodel -> Model) -> (cmsg -> Msg) -> ( cmodel, Cmd cmsg ) -> ( Model, Cmd Msg )
updateComponent update msgCreator ( subModel, subCmd ) =
    ( update subModel, Cmd.map msgCreator subCmd )


updateTodo : Model -> Todo.Model -> Model
updateTodo model todo =
    { model | todo = todo }


updateGitHub : Model -> GitHub.Model -> Model
updateGitHub model github =
    { model | github = github }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TodoMsg todoMsg ->
            updateComponent (updateTodo model) TodoMsg <|
                Todo.update todoMsg model.todo

        GitHubMsg githubMsg ->
            updateComponent (updateGitHub model) GitHubMsg <|
                GitHub.update githubMsg model.github


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
