module Commands exposing (..)

import Models exposing (..)
import Html exposing (..)
import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import RemoteData


fetchAllTempValues : Cmd Msg
fetchAllTempValues =
    -- Http.get "http://localhost:8080/temp/all" tempValuesDecoder
    Http.get "https://salty-forest-59491.herokuapp.com/temp/all" tempValuesDecoder
        |> RemoteData.sendRequest
        |> Cmd.map OnReceivedTempValues


tempValuesDecoder : Decode.Decoder TempValues
tempValuesDecoder =
    Decode.list tempValueDecoder


tempValueDecoder : Decode.Decoder TempValue
tempValueDecoder =
    decode TempValue
        |> required "timestamp" Decode.string
        |> required "temp" Decode.float
        |> required "id" Decode.int
        |> required "uploaded" Decode.bool


decodeTimeStamp : Decode.Decoder TimeStamp
decodeTimeStamp =
    decode TimeStamp
        |> required "hour" Decode.int
        |> required "minute" Decode.int
        |> required "second" Decode.int
        |> required "nano" Decode.int
        |> required "dayOfYear" Decode.int
        |> required "dayOfWeek" Decode.string
        |> required "month" Decode.string
        |> required "dayOfMonth" Decode.int
        |> required "year" Decode.int
        |> required "monthValue" Decode.int
        |> required "chronology" decodeChronology


decodeChronology : Decode.Decoder Chronology
decodeChronology =
    decode Chronology
        |> required "id" Decode.string
        |> required "calendarType" Decode.string



-- END
