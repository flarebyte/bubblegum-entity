module OutcomeTestData exposing (..)

{-| Unit tests for testing the Bubblegum.Entity.Outcome

-}
import Bubblegum.Entity.Outcome as Outcome exposing (..)

import FunctionTester exposing(..)
import Fuzz exposing (Fuzzer, int, list, string, intRange, constant, tuple)

expectValid: Outcome a -> String
expectValid outcome =
    if Outcome.isValid outcome then ok else "outcome should be Valid"

expectNone: Outcome a -> String
expectNone outcome =
    if Outcome.isNone outcome then ok else "outcome should be None"


expectValidOutcomeString: String -> Outcome String -> String
expectValidOutcomeString term outcome =
    case outcome of
        Valid s ->
            if s == term then ok else s ++ " is not " ++ term
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

