module Main exposing (Model, init, main)

import Browser
import Html exposing (Html, button, div, input, li, text, ul)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick, onInput)


type alias Model =
    { item : String
    , listItem : List String
    }


init : Model
init =
    { item = ""
    , listItem = [ "bank", "bankbank" ]
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
    div []
        [ input [ onInput InputItem, value model.item ] []
        , button [ onClick AddItem ] [ text "submit" ]
        , div [] [ text model.item ]
        , ul [] (List.map viewItem model.listItem)
        ]


viewItem : String -> Html msg
viewItem item =
    li []
        [ text ("TODO: " ++ item)
        ]


main =
    Browser.sandbox { init = init, update = update, view = view }
