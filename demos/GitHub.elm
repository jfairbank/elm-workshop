module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (class, disabled, src, type_, value)
import Html.Events exposing (onClick, onInput)


defaultAvatarUrl : String
defaultAvatarUrl =
    "https://avatars4.githubusercontent.com/u/33384?v=4"


type alias User =
    { login : String
    , name : String
    , bio : String
    , avatarUrl : String
    }


type alias Model =
    { login : String
    , user : Maybe User
    }


hardcodedUser : String -> User
hardcodedUser login =
    { login = login
    , name = "Elmer Coder"
    , bio = "Elm and Functional Programming"
    , avatarUrl = defaultAvatarUrl
    }


initialModel : Model
initialModel =
    Model "" Nothing


viewFindUser : Model -> Html Msg
viewFindUser model =
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
            [ disabled (model.login == "")
            , onClick FetchUser
            ]
            [ text "Find" ]
        ]


viewUser : User -> Html Msg
viewUser user =
    div [ class "view-user" ]
        [ h2 []
            [ text user.login ]
        , div []
            [ img [ src user.avatarUrl ] []
            , h3 [] [ text user.name ]
            , p [] [ text user.bio ]
            , button
                [ onClick Reset ]
                [ text "New Search" ]
            ]
        ]


view : Model -> Html Msg
view model =
    case model.user of
        Just user ->
            viewUser user

        Nothing ->
            viewFindUser model


type Msg
    = UpdateLogin String
    | Reset
    | FetchUser


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateLogin login ->
            { model | login = login }

        Reset ->
            initialModel

        FetchUser ->
            { model | user = Just (hardcodedUser model.login) }


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initialModel
        , view = view
        , update = update
        }
