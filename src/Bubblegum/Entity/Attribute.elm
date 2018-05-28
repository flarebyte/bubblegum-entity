module Bubblegum.Entity.Attribute
    exposing
        ( Model
        , deleteAttributeByKey
        , findAttributeByKey
        , findAttributeFirstValueByKey
        , findOutcomeByKey
        , findOutcomeByKeyTuple
        , replaceAttributeByKey
        , setFacets
        , setId
        , setKey
        , setValues
        )

{-| Setting key

@docs Model

-}

import Bubblegum.Entity.Outcome as Outcome exposing (Outcome(..))
import Maybe
import Tuple exposing (first, second)


{-| The core representation of a field.
-}
type alias Model =
    { id : Maybe String
    , key : String
    , facets : List String
    , values : List String
    }


setId : Maybe String -> Model -> Model
setId id model =
    { model | id = id }


setKey : String -> Model -> Model
setKey key model =
    { model | key = key }


setFacets : List String -> Model -> Model
setFacets facets model =
    { model | facets = facets }


setValues : List String -> Model -> Model
setValues values model =
    { model | values = values }


blankAttribute : Model
blankAttribute =
    { id = Nothing
    , key = ""
    , facets = []
    , values = []
    }


findAttributeByKey : String -> List Model -> Maybe Model
findAttributeByKey key attributes =
    case attributes of
        [] ->
            Nothing

        first :: rest ->
            if first.key == key then
                Just first
            else
                findAttributeByKey key rest

deleteAttributeByKey : String -> List Model -> List Model
deleteAttributeByKey key attributes =
    List.filter (\attr -> attr.key /= key) attributes

findAttributeFirstValueByKey : String -> List Model -> Maybe String
findAttributeFirstValueByKey key attributes =
    findAttributeByKey key attributes |> Maybe.map .values |> Maybe.andThen List.head


findOutcomeByKey : String -> List Model -> Outcome (List String)
findOutcomeByKey key attributes =
    findAttributeByKey key attributes |> Maybe.map .values |> Outcome.fromMaybe


createTuple : a -> a -> ( a, a )
createTuple a b =
    ( a, b )


findOutcomeByKeyTuple : ( String, String ) -> List Model -> Outcome ( List String, List String )
findOutcomeByKeyTuple tuple attributes =
    let
        a =
            findAttributeByKey (first tuple) attributes |> Maybe.map .values

        b =
            findAttributeByKey (second tuple) attributes |> Maybe.map .values

        ab =
            Maybe.map2 createTuple a b
    in
    Outcome.fromMaybe ab


replaceAttributeByKey : String -> List String -> List Model -> List Model
replaceAttributeByKey key values attributes =
    let
        existingOrNew =
            findAttributeByKey key attributes |> Maybe.withDefault { blankAttribute | key = key }
    in
    deleteAttributeByKey key attributes |> (++) [ { existingOrNew | values = values } ]
