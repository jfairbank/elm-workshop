module Main exposing (main)

import Html exposing (Html, a, button, div, img, input, text)
import Html.Attributes exposing (class, disabled, href, src, type_, value, width)
import Html.Events exposing (onClick, onInput)
import Http
import Json.Decode exposing (Decoder, field, string)
import Json.Decode.Pipeline exposing (decode, required)


baseApiUrl : String
baseApiUrl =
    "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag="


type alias Gif =
    { url : String
    , imageUrl : String
    }


type alias Model =
    { tag : String
    , gif : Maybe Gif
    , error : Maybe String
    }


initialModel : Model
initialModel =
    Model "" Nothing Nothing


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


viewGif : Maybe Gif -> Html Msg
viewGif maybeGif =
    case maybeGif of
        Just gif ->
            div []
                [ div []
                    [ img [ src gif.imageUrl, width 400 ] [] ]
                , div []
                    [ a [ href gif.url ]
                        [ text "View on Giphy" ]
                    ]
                ]

        Nothing ->
            text ""


viewError : Maybe String -> Html Msg
viewError maybeError =
    case maybeError of
        Just error ->
            div [ class "error" ]
                [ text ("Error: " ++ error) ]

        Nothing ->
            text ""


view : Model -> Html Msg
view model =
    div [ class "gifs" ]
        [ input
            [ type_ "text"
            , value model.tag
            , onInput UpdateTag
            ]
            []
        , button
            [ disabled (model.tag == "")
            , onClick FetchGif
            ]
            [ text "Surprise Me!" ]
        , viewGif model.gif
        , viewError model.error
        ]


type Msg
    = UpdateTag String
    | FetchGif
    | ReceiveGif (Result Http.Error Gif)


getRandomGif : String -> Cmd Msg
getRandomGif tag =
    let
        url =
            baseApiUrl ++ tag
    in
    Http.get url gifDecoder
        |> Http.send ReceiveGif


gifDecoder : Decoder Gif
gifDecoder =
    decode Gif
        |> required "url" string
        |> required "image_url" string
        |> field "data"


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateTag tag ->
            ( { model | tag = tag }
            , Cmd.none
            )

        FetchGif ->
            ( model, getRandomGif model.tag )

        ReceiveGif (Ok gif) ->
            ( { model | gif = Just gif, error = Nothing }
            , Cmd.none
            )

        ReceiveGif (Err error) ->
            ( { model | gif = Nothing, error = Just "Couldn't load gif." }
            , Cmd.none
            )


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
