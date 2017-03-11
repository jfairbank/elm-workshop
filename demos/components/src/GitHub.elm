module GitHub exposing (..)

import Http
import Html exposing (..)
import Html.Attributes exposing (class, disabled, src, type_, value)
import Html.Events exposing (onClick, onInput)
import Json.Decode exposing (Decoder, decodeString, field, int, string)
import Json.Decode.Pipeline exposing (decode, optional, required)


type alias User =
    { id : Int
    , login : String
    , name : String
    , bio : String
    , avatarUrl : String
    }


userDecoder : Decoder User
userDecoder =
    decode User
        |> required "id" int
        |> required "login" string
        |> optional "name" string "<No Name Available>"
        |> optional "bio" string "<No Bio Available>"
        |> required "avatar_url" string


type RemoteData x a
    = NotAsked
    | Loading
    | Success a
    | Failure x


type alias Model =
    { login : String
    , user : RemoteData String User
    }


type Msg
    = UpdateLogin String
    | FetchUser
    | ReceiveUser (Result Http.Error User)
    | Reset


initialModel : Model
initialModel =
    Model "" NotAsked


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


fetchUser : String -> Cmd Msg
fetchUser login =
    let
        url =
            "http://localhost:3001/users/" ++ login

        request =
            Http.get url userDecoder
    in
        Http.send ReceiveUser request


githubErrorDecoder : Decoder String
githubErrorDecoder =
    field "message" string


parseHttpError : Http.Error -> String
parseHttpError error =
    case error of
        Http.BadStatus response ->
            decodeString githubErrorDecoder response.body
                |> Result.withDefault response.body

        Http.BadPayload message _ ->
            message

        _ ->
            "Unknown Error"


remoteDataFromResult : Result Http.Error User -> RemoteData String User
remoteDataFromResult result =
    case result of
        Ok user ->
            Success user

        Err error ->
            Failure (parseHttpError error)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateLogin login ->
            ( { model | login = login }
            , Cmd.none
            )

        FetchUser ->
            ( { model | user = Loading }
            , fetchUser model.login
            )

        ReceiveUser result ->
            ( { model | user = remoteDataFromResult result }
            , Cmd.none
            )

        Reset ->
            ( initialModel, Cmd.none )


findUserView : Model -> Html Msg
findUserView model =
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
            , onClick FetchUser
            ]
            [ text "Find" ]
        ]


fetchingUserView : Model -> Html Msg
fetchingUserView model =
    div [ class "fetching-user" ]
        [ text ("Fetching user " ++ model.login ++ "...") ]


userView : User -> Html Msg
userView user =
    div [ class "view-user" ]
        [ h2 []
            [ text user.login ]
        , div []
            [ img [ src user.avatarUrl ] []
            , h3 [] [ text user.name ]
            , p [] [ text user.bio ]
            , button
                [ class "btn btn-primary"
                , onClick Reset
                ]
                [ text "New Search" ]
            ]
        ]


fetchErrorView : String -> Html Msg
fetchErrorView error =
    div [ class "fetch-error" ]
        [ strong [] [ text "Error fetching user:" ]
        , p [] [ text error ]
        ]


view : Model -> Html Msg
view model =
    case model.user of
        NotAsked ->
            findUserView model

        Loading ->
            fetchingUserView model

        Success user ->
            userView user

        Failure error ->
            div []
                [ findUserView model
                , fetchErrorView error
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
