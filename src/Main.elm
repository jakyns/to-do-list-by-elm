module Main exposing (Model, init, main)

import Browser
import Html exposing (Html, button, div, h1, input, li, text, ul)
import Html.Attributes exposing (class, value)
import Html.Events exposing (onClick, onInput)


type alias Model =
    { item : String
    , listItem : List String
    }


init : Model
init =
    { item = ""
    , listItem = [ "first", "second" ]
    }


type Msg
    = Noop
    | AddItem
    | InputItem String
    | MarkAsComplete String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Noop ->
            model

        AddItem ->
            { model
                | listItem = List.append model.listItem [ model.item ]
                , item = ""
            }

        InputItem newInput ->
            { model | item = newInput }

        MarkAsComplete item ->
            { model | listItem = List.filter (\i -> i /= item) model.listItem }


view : Model -> Html Msg
view model =
    div [ class "content" ]
        [ h1 [ class "title is-1" ] [ text "To-do List" ]
        , div [ class "columns" ]
            [ div [ class "column is-two-fifths" ] []
            , div [ class "column" ]
                [ input [ onInput InputItem, class "input", value model.item ] [] ]
            , div [ class "column" ]
                [ button [ onClick AddItem, class "button is-primary is-pulled-left" ] [ text "submit" ] ]
            , div [ class "column" ] []
            ]
        , div []
            [ div [ class "panel-heading" ] [ text model.item ]
            , div [] [ ul [ class "list" ] (List.map viewItem model.listItem) ]
            ]
        ]


viewItem : String -> Html Msg
viewItem item =
    li [ class "list-item" ]
        [ div [ class "columns" ]
            [ div [ class "column" ] []
            , div [ class "column" ] [ text ("TODO: " ++ item) ]
            , div [ class "column" ]
                [ button [ onClick (MarkAsComplete item), class "button is-primary" ]
                    [ text "complete" ]
                ]
            , div [ class "column" ] []
            ]
        ]


main =
    Browser.sandbox { init = init, update = update, view = view }
