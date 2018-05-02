module ViewTemp exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Models exposing (..)
import RemoteData exposing (WebData)


viewListOfAll : Model -> Html Msg
viewListOfAll model =
    case model.tempValues of
        RemoteData.NotAsked ->
            div [] []

        RemoteData.Loading ->
            div [] []

        RemoteData.Failure error ->
            div [] []

        RemoteData.Success tempValues ->
            div [ class "table col-lg-5 jumbotron", id "tempTable" ]
                [ h3 [] [ text "List of Temperature Values" ]
                , table []
                    (List.concat
                        ([ [ tr []
                                [ th [] [ text "Date" ]
                                , th [] [ text "Time" ]
                                , th [] [ text "Temperature" ]
                                ]
                           ]
                         , (List.map viewTempValue tempValues)
                         ]
                        )
                    )
                ]


viewTempValue : TempValue -> Html Msg
viewTempValue tempValue =
    let
        timestamp =
            tempValue.timestamp
    in
        tr []
            [ td [] [ text timestamp ]

            -- , td []
            --     [ text
            --         (toString (timestamp.year)
            --             ++ "-"
            --             ++ toString (timestamp.monthValue)
            --             ++ "-"
            --             ++ toString (timestamp.dayOfMonth)
            --         )
            --     ]
            -- , td
            --     []
            --     [ text
            --         (toString (timestamp.hour)
            --             ++ ":"
            --             ++ toString (timestamp.minute)
            --             ++ ":"
            --             ++ toString (timestamp.second)
            --         )
            --     ]
            , td
                [ class "text-right" ]
                [ text (toString tempValue.temp)
                ]
            ]
