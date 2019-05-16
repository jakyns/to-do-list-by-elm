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


view : Model -> Html Msg
view model =
    div [ class "content" ]
        [ h1 [ class "title is-1" ] [ text "To-do List" ]
        , div [ class "columns" ]
            [ div [ class "column is-one-fifth" ] []
            , div [ class "column is-half" ]
                [ input
                    [ onInput InputItem, class "input", value model.item ]
                    []
                ]
            , div [ class "column is-one-fifth" ]
                [ button [ onClick AddItem, class "button is-primary" ]
                    [ text "submit" ]
                ]
            ]
        , div []
            [ div [ class "panel-heading" ] [ text model.item ]
            , div []
                [ ul [ class "list" ] (List.map viewItem model.listItem) ]
            ]
        ]


viewItem : String -> Html msg
viewItem item =
    li [ class "list-item" ]
        [ text ("TODO: " ++ item) ]


main =
    Browser.sandbox { init = init, update = update, view = view }
