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
fuzzyV1FindAttributeByKey : Fuzzer String -- should produce String
fuzzyV1FindAttributeByKey = constant "key:default"

fuzzyV2FindAttributeByKey : Fuzzer (List String) -- should produce  List Model
fuzzyV2FindAttributeByKey = list string


validP1FindAttributeByKeyForJustModel: String -> String
validP1FindAttributeByKeyForJustModel value =
   value

validP2FindAttributeByKeyForJustModel: List String -> List Model
validP2FindAttributeByKeyForJustModel list =
    List.map attr2 list ++ [defaultAttributeModel]

summarizeFindAttributeByKeyForJustModel: Maybe Model -> List String
summarizeFindAttributeByKeyForJustModel result =
    [
        justOrErr "result is missing" result
        , Maybe.map (\r -> if r.key == "key:default" then ok else "key does not match") result |> Maybe.withDefault "ko"
    ]


validP1FindAttributeByKeyForNothing: String -> String
validP1FindAttributeByKeyForNothing value =
    "key:unknown"

validP2FindAttributeByKeyForNothing: List String -> List Model
validP2FindAttributeByKeyForNothing list =
    List.map attr2 list

summarizeFindAttributeByKeyForNothing: Maybe Model -> List String
summarizeFindAttributeByKeyForNothing result =
    [
        expectNoResult result
       , ok
   ]