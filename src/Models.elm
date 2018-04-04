module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { tempValues : WebData TempValues
    }


initialModel : Model
initialModel =
    { tempValues = RemoteData.Loading }


type alias TempValues =
    List TempValue


type alias TempValue =
    { timestamp : TimeStamp
    , temp : Int
    , id : Int
    , uploaded : Bool
    }


type alias TimeStamp =
    { hour : Int
    , minute : Int
    , second : Int
    , nano : Int
    , dayOfYear : Int
    , dayOfWeek : String
    , month : String
    , dayOfMonth : Int
    , year : Int
    , monthValue : Int
    , chronology : Chronology
    }


type alias Chronology =
    { id : String
    , calendarType : String
    }


type Msg
    = OnReceivedTempValues (WebData TempValues)
