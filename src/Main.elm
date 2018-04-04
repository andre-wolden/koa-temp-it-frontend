module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Models exposing (..)
import Commands exposing (..)
import RemoteData exposing (WebData)
import ViewTemp exposing (..)
import ViewPlot exposing (..)


init : ( Model, Cmd Msg )
init =
    ( initialModel
    , fetchAllTempValues
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnReceivedTempValues response ->
            ( { model | tempValues = response }, Cmd.none )


view : Model -> Html Msg
view model =
    div [ class "row" ]
        [ ViewTemp.viewListOfAll model
        , ViewPlot.viewTestPlot model
        ]



-- MAIN


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
