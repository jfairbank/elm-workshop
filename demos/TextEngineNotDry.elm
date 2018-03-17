module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (checked, class, type_, value)
import Html.Events exposing (onClick, onInput)


type Transformation
    = Reverse
    | Aesthetic
    | Mock
    | None


type alias Model =
    { text : String
    , transformation : Transformation
    }


initialModel : Model
initialModel =
    { text = ""
    , transformation = None
    }


applyTransformation : Transformation -> String -> String
applyTransformation transformation text =
    case transformation of
        Reverse ->
            String.reverse text

        Aesthetic ->
            aesthetic text

        Mock ->
            mock text

        None ->
            text


view : Model -> Html Msg
view model =
    div [ class "text-engine" ]
        [ input
            [ type_ "text"
            , value model.text
            , onInput UpdateText
            ]
            []
        , label []
            [ input
                [ type_ "radio"
                , checked (model.transformation == None)
                , onClick (SetTransformation None)
                ]
                []
            , text "None"
            ]
        , label []
            [ input
                [ type_ "radio"
                , checked (model.transformation == Reverse)
                , onClick (SetTransformation Reverse)
                ]
                []
            , text "Reverse"
            ]
        , label []
            [ input
                [ type_ "radio"
                , checked (model.transformation == Aesthetic)
                , onClick (SetTransformation Aesthetic)
                ]
                []
            , text "Aesthetic"
            ]
        , label []
            [ input
                [ type_ "radio"
                , checked (model.transformation == Mock)
                , onClick (SetTransformation Mock)
                ]
                []
            , text "Mock"
            ]
        , pre []
            [ text (applyTransformation model.transformation model.text) ]
        ]


type Msg
    = UpdateText String
    | SetTransformation Transformation


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateText text ->
            { model | text = text }

        SetTransformation transformation ->
            { model | transformation = transformation }


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initialModel
        , view = view
        , update = update
        }



{--==========================================================================
                         DO NOT MODIFY BELOW THIS LINE
   ==========================================================================--}


aesthetic : String -> String
aesthetic text =
    text
        |> String.trim
        |> String.split ""
        |> String.join " "


mock : String -> String
mock text =
    text
        |> String.trim
        |> String.split ""
        |> List.indexedMap
            (\n c ->
                if n % 2 == 0 then
                    String.toUpper c
                else
                    String.toLower c
            )
        |> String.join ""
