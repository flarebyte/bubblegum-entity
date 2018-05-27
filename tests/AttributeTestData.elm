module AttributeTestData exposing (..)

{-| Unit tests for testing the Bubblegum.Entity.Attribute

    generated

-}
import Bubblegum.Entity.Attribute as Attribute exposing(Model)

import FunctionTester exposing(..)
import Fuzz exposing (Fuzzer, int, list, string, intRange, constant)


attr: String -> String -> Attribute.Model
attr key value =
     { id = Nothing
    , key = key
    , facets = []
    , values = [value]
    }  

attr2: String -> Attribute.Model
attr2 str =
    attr str str

defaultAttributeModel: Attribute.Model
defaultAttributeModel =
    attr "key:default" "default value"

-- findAttributeByKey
fuzzyV1FindAttributeByKey : Fuzzer String
fuzzyV1FindAttributeByKey = string

fuzzyV2FindAttributeByKey : Fuzzer (List String)
fuzzyV2FindAttributeByKey = list string

validP1FindAttributeByKeyForJustModel: String -> String
validP1FindAttributeByKeyForJustModel value =
    "key:default"

validP2FindAttributeByKeyForJustModel: List String -> List Model
validP2FindAttributeByKeyForJustModel list =
    defaultAttributeModel :: List.map attr2 list

underTestP1FindAttributeByKeyForJustModel: String -> String
underTestP1FindAttributeByKeyForJustModel value =
    "key:default"

underTestP2FindAttributeByKeyForJustModel: List String -> List Model
underTestP2FindAttributeByKeyForJustModel list =
    defaultAttributeModel :: List.map attr2 list

summarizeFindAttributeByKeyForJustModel: List Model -> List String
summarizeFindAttributeByKeyForJustModel result =
    [
        justOrErr/nonEmptyStringOrErr/atLeastOneStringOrErr "attr is missing" result.attr
    ]



validP1FindAttributeByKeyForNothing: String -> String
validP1FindAttributeByKeyForNothing value =
    value

validP2FindAttributeByKeyForNothing: String -> List Model
validP2FindAttributeByKeyForNothing value =
    value

underTestP1FindAttributeByKeyForNothing: String -> String
underTestP1FindAttributeByKeyForNothing value =
    value

underTestP2FindAttributeByKeyForNothing: String -> List Model
underTestP2FindAttributeByKeyForNothing value =
    value


summarizeFindAttributeByKeyForNothing: List Model -> List String
summarizeFindAttributeByKeyForNothing result =
    [
        justOrErr/nonEmptyStringOrErr/atLeastOneStringOrErr "attr is missing" result.attr
    ]