module AttributeTestData exposing (..)

{-| Unit tests for testing the Bubblegum.Entity.Attribute

    generated

-}
import Test exposing (..)
import Bubblegum.Entity.SettingsEntity as SettingsEntity
import Bubblegum.Entity.StateEntity as StateEntity
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
fuzzySetId : Fuzzer String
fuzzySetId = string 


validSetId: String -> AB (Maybe String) Attribute.Model
validSetId value =
    ab (Just value) defaultAttributeModel

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