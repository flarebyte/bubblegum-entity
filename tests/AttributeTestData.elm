module AttributeTestData exposing (..)

{-| Unit tests for testing the Bubblegum.Entity.Attribute

-}
import Bubblegum.Entity.Attribute as Attribute exposing(Model)
import Bubblegum.Entity.Outcome as Outcome exposing (Outcome(..))

import FunctionTester exposing(..)
import Fuzz exposing (Fuzzer, int, list, string, intRange, constant, tuple)


attr: String -> String -> Attribute.Model
attr key value =
     { id = Nothing
    , key = key
    , facets = []
    , values = [value]
    }  

attr2: String -> Attribute.Model
attr2 str =
    attr str ("value of " ++ str)

defaultAttributeModel: Attribute.Model
defaultAttributeModel =
    attr "key:default" "default value"


otherOutcome : Outcome String -> String
otherOutcome outcome =
    case outcome of
        Valid v ->
            v
        Warning m->
            "Warning " ++ m
        None->
            "None "

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
        expectResult result
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

 -- findAttributeFirstValueByKey
fuzzyV1FindAttributeFirstValueByKey : Fuzzer String -- should produce String
fuzzyV1FindAttributeFirstValueByKey = constant "key:default"

fuzzyV2FindAttributeFirstValueByKey : Fuzzer (List String) -- should produce  List Model
fuzzyV2FindAttributeFirstValueByKey = list string


validP1FindAttributeFirstValueByKeyForJustString: String -> String
validP1FindAttributeFirstValueByKeyForJustString value =
    value

validP2FindAttributeFirstValueByKeyForJustString: List String -> List Model
validP2FindAttributeFirstValueByKeyForJustString list =
    List.map attr2 list ++ [defaultAttributeModel]

summarizeFindAttributeFirstValueByKeyForJustString: Maybe String -> List String
summarizeFindAttributeFirstValueByKeyForJustString result =
    [
        expectResult result
        , Maybe.map (\r -> if r == "default value" then ok else "value does not match") result |> Maybe.withDefault "ko"
    ]


validP1FindAttributeFirstValueByKeyForNothing: String -> String
validP1FindAttributeFirstValueByKeyForNothing value =
    value

validP2FindAttributeFirstValueByKeyForNothing: List String -> List Model
validP2FindAttributeFirstValueByKeyForNothing list =
    List.map attr2 list

summarizeFindAttributeFirstValueByKeyForNothing: Maybe String -> List String
summarizeFindAttributeFirstValueByKeyForNothing result =
    [
        expectNoResult result
        , ok
    ]

  -- findOutcomeByKey
fuzzyV1FindOutcomeByKey : Fuzzer String -- should produce String
fuzzyV1FindOutcomeByKey = constant "key:default"

fuzzyV2FindOutcomeByKey : Fuzzer (List String) -- should produce  List Model
fuzzyV2FindOutcomeByKey = list string


validP1FindOutcomeByKeyForValidOutcome: String -> String
validP1FindOutcomeByKeyForValidOutcome value =
    value

validP2FindOutcomeByKeyForValidOutcome: List String -> List Model
validP2FindOutcomeByKeyForValidOutcome list =
    List.map attr2 list ++ [defaultAttributeModel]

summarizeFindOutcomeByKeyForValidOutcome: Outcome (List String) -> List String
summarizeFindOutcomeByKeyForValidOutcome result =
    [
        if Outcome.isValid result then ok else "unexpected oucome"
        , Outcome.map (\r -> if r == ["default value"] then ok else "value does not match") result |> otherOutcome
    ]


validP1FindOutcomeByKeyForNoneOutcome: String -> String
validP1FindOutcomeByKeyForNoneOutcome value =
    value

validP2FindOutcomeByKeyForNoneOutcome: List String -> List Model
validP2FindOutcomeByKeyForNoneOutcome list =
    List.map attr2 list

summarizeFindOutcomeByKeyForNoneOutcome: Outcome (List String) -> List String
summarizeFindOutcomeByKeyForNoneOutcome result =
    [
        if Outcome.isNone result then ok else "unexpected oucome"
        , ok
    ]

-- deleteAttributeByKey
fuzzyV1DeleteAttributeByKey : Fuzzer String -- should produce String
fuzzyV1DeleteAttributeByKey = constant "key:default"

fuzzyV2DeleteAttributeByKey : Fuzzer (List String) -- should produce  List Model
fuzzyV2DeleteAttributeByKey = list string


validP1DeleteAttributeByKeyForList: String -> String
validP1DeleteAttributeByKeyForList value =
    value

validP2DeleteAttributeByKeyForList: List String -> List Model
validP2DeleteAttributeByKeyForList list =
    List.map attr2 list ++ [defaultAttributeModel] ++ [attr "key:alpha" "alpha"]

summarizeDeleteAttributeByKeyForList: List Model -> List String
summarizeDeleteAttributeByKeyForList result =
    [
        expectNotEmptyList result
        , List.map .key result |> withoutStringInListMatching "key:default"
    ]


validP1DeleteAttributeByKeyForEmptyList: String -> String
validP1DeleteAttributeByKeyForEmptyList value =
    value

validP2DeleteAttributeByKeyForEmptyList: List String -> List Model
validP2DeleteAttributeByKeyForEmptyList list =
    [defaultAttributeModel]

summarizeDeleteAttributeByKeyForEmptyList: List Model -> List String
summarizeDeleteAttributeByKeyForEmptyList result =
    [
        expectEmptyList result
        , ok
    ]

-- findOutcomeByKeyTuple
fuzzyV1FindOutcomeByKeyTuple : Fuzzer (String, String) -- should produce ( String, String )
fuzzyV1FindOutcomeByKeyTuple = constant ("key:min", "key:max")

fuzzyV2FindOutcomeByKeyTuple : Fuzzer (List String) -- should produce List Model
fuzzyV2FindOutcomeByKeyTuple = list string


validP1FindOutcomeByKeyTupleForValidOutcome: (String, String) -> ( String, String )
validP1FindOutcomeByKeyTupleForValidOutcome value =
    value

validP2FindOutcomeByKeyTupleForValidOutcome: List String -> List Model
validP2FindOutcomeByKeyTupleForValidOutcome list =
    List.map attr2 list ++ [defaultAttributeModel, attr2 "key:min", attr2 "key:max"]

summarizeFindOutcomeByKeyTupleForValidOutcome: Outcome ( List String, List String ) -> List String
summarizeFindOutcomeByKeyTupleForValidOutcome result =
    [
        if Outcome.isValid result then ok else "unexpected oucome"
        , Outcome.map (\r -> if r == (["value of key:min"], ["value of key:max"]) then ok else "value does not match") result |> otherOutcome
    ]



validP1FindOutcomeByKeyTupleForOutcomeWithFirstNone: (String, String) -> ( String, String )
validP1FindOutcomeByKeyTupleForOutcomeWithFirstNone value =
    value

validP2FindOutcomeByKeyTupleForOutcomeWithFirstNone: List String -> List Model
validP2FindOutcomeByKeyTupleForOutcomeWithFirstNone list =
    List.map attr2 list ++ [defaultAttributeModel, attr2 "key:max"]

summarizeFindOutcomeByKeyTupleForOutcomeWithFirstNone: Outcome ( List String, List String ) -> List String
summarizeFindOutcomeByKeyTupleForOutcomeWithFirstNone result =
    [
        if Outcome.isNone result then ok else "unexpected oucome"
        , ok
    ]

-- replaceAttributeByKey
fuzzyV1ReplaceAttributeByKey : Fuzzer String -- should produce String
fuzzyV1ReplaceAttributeByKey = constant "key:default"

fuzzyV2ReplaceAttributeByKey : Fuzzer (List String) -- should produce List String
fuzzyV2ReplaceAttributeByKey = constant ["alpha", "beta", "charlie"]

fuzzyV3ReplaceAttributeByKey : Fuzzer (List String) -- should produce List Model
fuzzyV3ReplaceAttributeByKey = list string



validP1ReplaceAttributeByKeyForList: String -> String
validP1ReplaceAttributeByKeyForList value =
    value

validP2ReplaceAttributeByKeyForList: List String -> List String
validP2ReplaceAttributeByKeyForList value =
    value

validP3ReplaceAttributeByKeyForList: List String -> List Model
validP3ReplaceAttributeByKeyForList list =
    List.map attr2 list ++ [defaultAttributeModel]

summarizeReplaceAttributeByKeyForList: List Model -> List String
summarizeReplaceAttributeByKeyForList result =
    [
        expectNotEmptyList result
        , List.filter (\r ->r.key == "key:default" && r.values == ["alpha", "beta", "charlie"]) result |> expectNotEmptyList
    ]

validP1ReplaceAttributeByKeyForEmptyList: String -> String
validP1ReplaceAttributeByKeyForEmptyList value =
    value

validP2ReplaceAttributeByKeyForEmptyList: List String -> List String
validP2ReplaceAttributeByKeyForEmptyList value =
    value

validP3ReplaceAttributeByKeyForEmptyList: List String -> List Model
validP3ReplaceAttributeByKeyForEmptyList value =
    []

summarizeReplaceAttributeByKeyForEmptyList: List Model -> List String
summarizeReplaceAttributeByKeyForEmptyList result =
    [
        expectNotEmptyList result
        , List.filter (\r ->r.key == "key:default" && r.values == ["alpha", "beta", "charlie"]) result |> expectNotEmptyList
    ]