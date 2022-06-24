module ValidationTests exposing (suite)

{-| Unit tests for testing the Bubblegum.Entity.Validation

**generated** with make generate

-}

import Bubblegum.Entity.Validation as Validation
import Expect as Expect
import FunctionTester exposing (ok1)
import Test exposing (..)
import ValidationTestData exposing (..)


suite : Test
suite =
    describe "The Validation module"
        [ describe "listStrictlyMoreThan"
            [ fuzz2 fuzzyV1ListStrictlyMoreThan fuzzyV2ListStrictlyMoreThan "listStrictlyMoreThan should return valid" <|
                \v1 v2 ->
                    Validation.listStrictlyMoreThan (validP1ListStrictlyMoreThanForValid v1) (validP2ListStrictlyMoreThanForValid v2)
                        |> summarizeListStrictlyMoreThanForValid
                        |> Expect.equal ok1
            , fuzz2 fuzzyV1ListStrictlyMoreThan fuzzyV2ListStrictlyMoreThan "listStrictlyMoreThan should return invalid" <|
                \v1 v2 ->
                    Validation.listStrictlyMoreThan (validP1ListStrictlyMoreThanForInvalid v1) (validP2ListStrictlyMoreThanForInvalid v2)
                        |> summarizeListStrictlyMoreThanForInvalid
                        |> Expect.equal ok1
            ]
        , describe "listStrictlyLessThan"
            [ fuzz2 fuzzyV1ListStrictlyLessThan fuzzyV2ListStrictlyLessThan "listStrictlyLessThan should return valid" <|
                \v1 v2 ->
                    Validation.listStrictlyLessThan (validP1ListStrictlyLessThanForValid v1) (validP2ListStrictlyLessThanForValid v2)
                        |> summarizeListStrictlyLessThanForValid
                        |> Expect.equal ok1
            , fuzz2 fuzzyV1ListStrictlyLessThan fuzzyV2ListStrictlyLessThan "listStrictlyLessThan should return invalid" <|
                \v1 v2 ->
                    Validation.listStrictlyLessThan (validP1ListStrictlyLessThanForInvalid v1) (validP2ListStrictlyLessThanForInvalid v2)
                        |> summarizeListStrictlyLessThanForInvalid
                        |> Expect.equal ok1
            ]
        , describe "matchEnum"
            [ fuzz2 fuzzyV1MatchEnum fuzzyV2MatchEnum "matchEnum should return valid" <|
                \v1 v2 ->
                    Validation.matchEnum (validP1MatchEnumForValid v1) (validP2MatchEnumForValid v2)
                        |> summarizeMatchEnumForValid
                        |> Expect.equal ok1
            , fuzz2 fuzzyV1MatchEnum fuzzyV2MatchEnum "matchEnum should return invalid" <|
                \v1 v2 ->
                    Validation.matchEnum (validP1MatchEnumForInvalid v1) (validP2MatchEnumForInvalid v2)
                        |> summarizeMatchEnumForInvalid
                        |> Expect.equal ok1
            ]
        , describe "stringStartsWith"
            [ fuzz2 fuzzyV1StringStartsWith fuzzyV2StringStartsWith "stringStartsWith should return valid" <|
                \v1 v2 ->
                    Validation.stringStartsWith (validP1StringStartsWithForValid v1) (validP2StringStartsWithForValid v2)
                        |> summarizeStringStartsWithForValid
                        |> Expect.equal ok1
            , fuzz2 fuzzyV1StringStartsWith fuzzyV2StringStartsWith "stringStartsWith should return invalid" <|
                \v1 v2 ->
                    Validation.stringStartsWith (validP1StringStartsWithForInvalid v1) (validP2StringStartsWithForInvalid v2)
                        |> summarizeStringStartsWithForInvalid
                        |> Expect.equal ok1
            ]
        , describe "matchAbsoluteUrl"
            [ fuzz fuzzyV1MatchAbsoluteUrl "matchAbsoluteUrl should return valid" <|
                \v1 ->
                    Validation.matchAbsoluteUrl (validP1MatchAbsoluteUrlForValid v1)
                        |> summarizeMatchAbsoluteUrlForValid
                        |> Expect.equal ok1
            , fuzz fuzzyV1MatchAbsoluteUrl "matchAbsoluteUrl should return invalid" <|
                \v1 ->
                    Validation.matchAbsoluteUrl (validP1MatchAbsoluteUrlForInvalid v1)
                        |> summarizeMatchAbsoluteUrlForInvalid
                        |> Expect.equal ok1
            ]
        , describe "matchCompactUri"
            [ fuzz fuzzyV1MatchCompactUri "matchCompactUri should return valid" <|
                \v1 ->
                    Validation.matchCompactUri (validP1MatchCompactUriForValid v1)
                        |> summarizeMatchCompactUriForValid
                        |> Expect.equal ok1
            , fuzz fuzzyV1MatchCompactUri "matchCompactUri should return invalid" <|
                \v1 ->
                    Validation.matchCompactUri (validP1MatchCompactUriForInvalid v1)
                        |> summarizeMatchCompactUriForInvalid
                        |> Expect.equal ok1
            ]
        , describe "asIntRange"
            [ fuzz fuzzyV1AsIntRange "asIntRange should return valid" <|
                \v1 ->
                    Validation.asIntRange (validP1AsIntRangeForValid v1)
                        |> summarizeAsIntRangeForValid
                        |> Expect.equal ok1
            , fuzz fuzzyV1AsIntRange "asIntRange should return invalid" <|
                \v1 ->
                    Validation.asIntRange (validP1AsIntRangeForInvalid v1)
                        |> summarizeAsIntRangeForInvalid
                        |> Expect.equal ok1
            ]
        , describe "asFloatRange"
            [ fuzz fuzzyV1AsFloatRange "asFloatRange should return valid" <|
                \v1 ->
                    Validation.asFloatRange (validP1AsFloatRangeForValid v1)
                        |> summarizeAsFloatRangeForValid
                        |> Expect.equal ok1
            , fuzz fuzzyV1AsFloatRange "asFloatRange should return invalid" <|
                \v1 ->
                    Validation.asFloatRange (validP1AsFloatRangeForInvalid v1)
                        |> summarizeAsFloatRangeForInvalid
                        |> Expect.equal ok1
            ]
        , describe "withinStringCharsRange"
            [ fuzz2 fuzzyV1WithinStringCharsRange fuzzyV2WithinStringCharsRange "withinStringCharsRange should return valid" <|
                \v1 v2 ->
                    Validation.withinStringCharsRange (validP1WithinStringCharsRangeForValid v1) (validP2WithinStringCharsRangeForValid v2)
                        |> summarizeWithinStringCharsRangeForValid
                        |> Expect.equal ok1
            , fuzz2 fuzzyV1WithinStringCharsRange fuzzyV2WithinStringCharsRange "withinStringCharsRange should return invalid" <|
                \v1 v2 ->
                    Validation.withinStringCharsRange (validP1WithinStringCharsRangeForInvalid v1) (validP2WithinStringCharsRangeForInvalid v2)
                        |> summarizeWithinStringCharsRangeForInvalid
                        |> Expect.equal ok1
            ]
        ]
