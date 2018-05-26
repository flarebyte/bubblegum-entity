module AttributeTestData exposing (..)

{-| Unit tests for testing the Bubblegum.Entity.Attribute

    generated

-}
import Bubblegum.Entity.Attribute as Attribute
import FunctionTester exposing(..)
import Fuzz exposing (Fuzzer, int, list, string, intRange, constant)


attr: String -> String -> Attribute.Model
attr key value =
     { id = Nothing
    , key = key
    , facets = []
    , values = [value]
    }  

defaultAttributeModel: Attribute.Model
defaultAttributeModel =
    attr "key:default" "default value"

-- SetId
fuzzyV1SetId : Fuzzer String
fuzzyV1SetId = string 

fuzzyV2SetId : Fuzzer (List String)
fuzzyV2SetId = list string


validP1SetId: String -> Maybe String
validP1SetId value =
    Just value

validP2SetId: List String -> Attribute.Model
validP2SetId list =
    { defaultAttributeModel | values = "something" :: list}

expectedValidSetId: List String
expectedValidSetId = ok3

summarizeSetId: Attribute.Model -> List String
summarizeSetId model =
    [
        justOrErr "id is missing" model.id
        , nonEmptyStringOrErr "key is missing" model.key
        , atLeastOneStringOrErr "values should not be empty" model.values
    ]

summarizeSetIdWithIdNothing: Attribute.Model -> List String
summarizeSetIdWithIdNothing model =
    [
        nothingOrErr "id should be nothing" model.id
        , nonEmptyStringOrErr "key is missing" model.key
        , atLeastOneStringOrErr "values should not be empty" model.values
    ]    