module OutcomeTestData exposing (..)

{-| Unit tests for testing the Bubblegum.Entity.Outcome

-}
import Bubblegum.Entity.Outcome as Outcome exposing (..)

import FunctionTester exposing(..)
import Fuzz exposing (Fuzzer, int, list, string, intRange, constant, tuple)
import Regex as Regex exposing(regex)

expectValid: Outcome a -> String
expectValid outcome =
    if Outcome.isValid outcome then ok else "outcome should be Valid"

expectNone: Outcome a -> String
expectNone outcome =
    if Outcome.isNone outcome then ok else "outcome should be None"

expectWarning: Outcome a -> String
expectWarning outcome =
    if Outcome.isWarning outcome then ok else "outcome should be warning"


expectValidOutcomeString: String -> Outcome String -> String
expectValidOutcomeString term outcome =
    case outcome of
        Valid s ->
            if s == term then ok else s ++ " is not " ++ term
        None ->
            "should not be none"
        Warning s ->
            "should not be warning " ++ s

expectValidOutcomeRegex: String -> Outcome String -> String
expectValidOutcomeRegex term outcome =
    case outcome of
        Valid s ->
            if Regex.contains (regex term) s then ok else s ++ " does not match " ++ term
        None ->
            "should not be none"
        Warning s ->
            "should not be warning " ++ s

-- withDefault
fuzzyV1WithDefault : Fuzzer String -- should produce a
fuzzyV1WithDefault = string

fuzzyV2WithDefault : Fuzzer String -- should produce Outcome a
fuzzyV2WithDefault = string 


validP1WithDefaultForValid: String -> String
validP1WithDefaultForValid value =
    value

validP2WithDefaultForValid: String -> Outcome String
validP2WithDefaultForValid value =
    Valid "expected"
    
summarizeWithDefaultForValid: Outcome String -> List String
summarizeWithDefaultForValid result =
    [
        expectValid result
        , expectValidOutcomeString "expected" result
    ]


validP1WithDefaultForNone: String -> String
validP1WithDefaultForNone value =
    "default"

validP2WithDefaultForNone: String -> Outcome String
validP2WithDefaultForNone value =
    None
    
summarizeWithDefaultForNone: Outcome String -> List String
summarizeWithDefaultForNone result =
    [
        expectValid result
        , expectValidOutcomeString "default" result
    ]

-- map
fuzzyV1Map : Fuzzer Int -- should produce (a -> value)
fuzzyV1Map = constant 0

fuzzyV2Map : Fuzzer Int -- should produce Outcome a
fuzzyV2Map = int


validP1MapForValid: Int -> (Int -> String)
validP1MapForValid value =
    toString

validP2MapForValid: Int -> Outcome Int
validP2MapForValid value =
    Valid value

summarizeMapForValid: Outcome String -> List String
summarizeMapForValid result =
    [
        expectValid result
        , expectValidOutcomeRegex "[0-9]" result
    ]


validP1MapForNone: Int -> (Int -> String)
validP1MapForNone value =
    toString

validP2MapForNone: Int -> Outcome Int
validP2MapForNone value =
    None

summarizeMapForNone: Outcome value -> List String
summarizeMapForNone result =
    [
        expectNone result
        , ok
    ]


validP1MapForWarning: Int -> (Int -> String)
validP1MapForWarning value =
    toString

validP2MapForWarning: Int -> Outcome Int
validP2MapForWarning value =
    Warning "warning"

summarizeMapForWarning: Outcome value -> List String
summarizeMapForWarning result =
    [
        expectWarning result
        , ok
    ]
