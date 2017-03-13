module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (checked, class, type_, value)
import Html.Events exposing (onCheck, onClick, onInput)


type TodoStatus
    = Incomplete
    | Editing
    | Complete


type alias TodoItem =
    { description : String
    , status : TodoStatus
    }


type alias Model =
    List TodoItem


type Msg
    = EditTodoItem TodoItem
    | SaveTodoItem TodoItem
    | UpdateTodoItem TodoItem String
    | DeleteTodoItem TodoItem
    | CompleteTodoItem TodoItem Bool
    | AddTodoItem


initialModel : Model
initialModel =
    [ TodoItem "Learn Elm" Incomplete
    , TodoItem "Build Awesome Elm App" Incomplete
    ]


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


editTodoItem : TodoItem -> TodoItem
editTodoItem todoItem =
    { todoItem | status = Editing }


saveTodoItem : TodoItem -> TodoItem
saveTodoItem todoItem =
    { todoItem | status = Incomplete }


setDescription : String -> TodoItem -> TodoItem
setDescription description todoItem =
    { todoItem | description = description }


updateTodoItem : TodoItem -> (TodoItem -> TodoItem) -> List TodoItem -> List TodoItem
updateTodoItem refTodoItem f todoItems =
    List.map
        (\todoItem ->
            if todoItem == refTodoItem then
                f todoItem
            else
                todoItem
        )
        todoItems


completeTodoItem : Bool -> TodoItem -> TodoItem
completeTodoItem isComplete todoItem =
    let
        status =
            if isComplete then
                Complete
            else
                Incomplete
    in
        { todoItem | status = status }


removeTodoItem : TodoItem -> List TodoItem -> List TodoItem
removeTodoItem refTodoItem todoItems =
    List.filter ((/=) refTodoItem) todoItems


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        EditTodoItem refTodoItem ->
            ( updateTodoItem refTodoItem editTodoItem model
            , Cmd.none
            )

        SaveTodoItem refTodoItem ->
            ( updateTodoItem refTodoItem saveTodoItem model
            , Cmd.none
            )

        UpdateTodoItem refTodoItem description ->
            ( updateTodoItem refTodoItem (setDescription description) model
            , Cmd.none
            )

        DeleteTodoItem refTodoItem ->
            ( removeTodoItem refTodoItem model
            , Cmd.none
            )

        CompleteTodoItem refTodoItem isComplete ->
            ( updateTodoItem refTodoItem (completeTodoItem isComplete) model
            , Cmd.none
            )

        AddTodoItem ->
            ( model ++ [ TodoItem "" Editing ]
            , Cmd.none
            )


editTodoItemView : TodoItem -> Html Msg
editTodoItemView todoItem =
    div [ class "todo-item-edit" ]
        [ input
            [ type_ "text"
            , value todoItem.description
            , onInput (UpdateTodoItem todoItem)
            ]
            []
        , button
            [ class "btn btn-primary btn-sm"
            , onClick (SaveTodoItem todoItem)
            ]
            [ text "Save" ]
        ]


incompleteTodoItemView : TodoItem -> Html Msg
incompleteTodoItemView todoItem =
    div [ class "todo-item-incomplete" ]
        [ input
            [ type_ "checkbox"
            , checked False
            , onCheck (CompleteTodoItem todoItem)
            ]
            []
        , text todoItem.description
        , button
            [ class "btn btn-danger btn-xs"
            , onClick (DeleteTodoItem todoItem)
            ]
            [ text "Delete" ]
        , button
            [ class "btn btn-default btn-xs"
            , onClick (EditTodoItem todoItem)
            ]
            [ text "Edit" ]
        ]


completeTodoItemView : TodoItem -> Html Msg
completeTodoItemView todoItem =
    div [ class "todo-item-complete" ]
        [ input
            [ type_ "checkbox"
            , checked True
            , onCheck (CompleteTodoItem todoItem)
            ]
            []
        , text todoItem.description
        ]


todoItemView : TodoItem -> Html Msg
todoItemView todoItem =
    let
        child =
            case todoItem.status of
                Complete ->
                    completeTodoItemView todoItem

                Editing ->
                    editTodoItemView todoItem

                Incomplete ->
                    incompleteTodoItemView todoItem
    in
        li [ class "todo-list-item" ]
            [ child ]


todoListView : List TodoItem -> Html Msg
todoListView todoItems =
    case todoItems of
        [] ->
            div [ class "no-todo-items" ]
                [ text "No Todo Items" ]

        _ ->
            ul [] (List.map todoItemView todoItems)


view : Model -> Html Msg
view model =
    div [ class "todo-list" ]
        [ h1 [] [ text "Todo List" ]
        , todoListView model
        , button
            [ class "btn btn-primary"
            , onClick AddTodoItem
            ]
            [ text "+ Add Todo Item" ]
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
