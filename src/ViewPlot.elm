module ViewPlot exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Models exposing (..)
import RemoteData exposing (WebData)
import Plot exposing (..)
import Svg
import Svg.Attributes


viewTestPlot : Model -> Html Msg
viewTestPlot model =
    case model.tempValues of
        RemoteData.NotAsked ->
            text "Initialising Data"

        RemoteData.Loading ->
            text "Loading Data"

        RemoteData.Failure error ->
            text ("Error loading data" ++ (toString error))

        RemoteData.Success tempValues ->
            div [ class "jumbotron col-lg-6", id "plot" ]
                [ h3 [ class "text-center" ]
                    [ text "Test Plot" ]
                , div [] [ viewPlot tempValues ]
                ]


viewPlot : TempValues -> Svg.Svg Msg
viewPlot tempValues =
    viewSeries
        [ area (List.map (\{ x, y } -> circle x y)) ]
        (List.map stuff tempValues)


stuff : TempValue -> DataPoint
stuff tempValue =
    let
        timestamp =
            tempValue.timestamp
    in
        DataPoint (toFloat tempValue.id) (toFloat tempValue.temp)


type alias DataPoint =
    { x : Float, y : Float }


roundRect : Html.Html msg
roundRect =
    Svg.svg
        [ Svg.Attributes.width "120"
        , Svg.Attributes.height "120"
        , Svg.Attributes.viewBox "0 0 120 120"
        ]
        [ Svg.rect
            [ Svg.Attributes.x "10"
            , Svg.Attributes.y "10"
            , Svg.Attributes.width "100"
            , Svg.Attributes.height "100"
            , Svg.Attributes.rx "15"
            , Svg.Attributes.ry "15"
            ]
            []
        ]
