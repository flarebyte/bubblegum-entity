module ValidationTests exposing (suite)

{-| Unit tests for testing the Bubblegum.Entity.Validation

  **generated** in scripts/*.py

-}
import Test exposing (..)
import Expect as Expect
import FunctionTester exposing (ok,ok1,ok2,ok3)
import ValidationTestData exposing (..)
import Bubblegum.Entity.Validation as Validation


suite : Test
suite =
    describe "The Validation module"
        [ 

            describe "listStrictlyLessThan"
            [

               fuzz2 fuzzyV1ListStrictlyLessThan fuzzyV2ListStrictlyLessThan "listStrictlyLessThan should return valid" <|
                \v1 v2 ->
                    Validation.listStrictlyLessThan (validP1ListStrictlyLessThanForValid v1) (validP2ListStrictlyLessThanForValid v2)
                    |> summarizeListStrictlyLessThanForValid
                    |> Expect.equal ok1

            ,
               fuzz2 fuzzyV1ListStrictlyLessThan fuzzyV2ListStrictlyLessThan "listStrictlyLessThan should return invalid" <|
                \v1 v2 ->
                    Validation.listStrictlyLessThan (validP1ListStrictlyLessThanForInvalid v1) (validP2ListStrictlyLessThanForInvalid v2)
                    |> summarizeListStrictlyLessThanForInvalid
                    |> Expect.equal ok1

            ]            , 
            describe "asIntRange"
            [

               fuzz fuzzyV1AsIntRange "asIntRange should return valid" <|
                \v1 ->
                    Validation.asIntRange (validP1AsIntRangeForValid v1)
                    |> summarizeAsIntRangeForValid
                    |> Expect.equal ok1

            ,
               fuzz fuzzyV1AsIntRange "asIntRange should return invalid" <|
                \v1 ->
                    Validation.asIntRange (validP1AsIntRangeForInvalid v1)
                    |> summarizeAsIntRangeForInvalid
                    |> Expect.equal ok1

            ]            , 
            describe "asFloatRange"
            [

               fuzz fuzzyV1AsFloatRange "asFloatRange should return valid" <|
                \v1 ->
                    Validation.asFloatRange (validP1AsFloatRangeForValid v1)
                    |> summarizeAsFloatRangeForValid
                    |> Expect.equal ok1

            ,
               fuzz fuzzyV1AsFloatRange "asFloatRange should return invalid" <|
                \v1 ->
                    Validation.asFloatRange (validP1AsFloatRangeForInvalid v1)
                    |> summarizeAsFloatRangeForInvalid
                    |> Expect.equal ok1

            ]            , 
            describe "withinIntRange"
            [

               fuzz2 fuzzyV1WithinIntRange fuzzyV2WithinIntRange "withinIntRange should return inside range" <|
                \v1 v2 ->
                    Validation.withinIntRange (validP1WithinIntRangeForInsideRange v1) (validP2WithinIntRangeForInsideRange v2)
                    |> summarizeWithinIntRangeForInsideRange
                    |> Expect.equal ok1

            ,
               fuzz2 fuzzyV1WithinIntRange fuzzyV2WithinIntRange "withinIntRange should return outside range" <|
                \v1 v2 ->
                    Validation.withinIntRange (validP1WithinIntRangeForOutsideRange v1) (validP2WithinIntRangeForOutsideRange v2)
                    |> summarizeWithinIntRangeForOutsideRange
                    |> Expect.equal ok1

            ]            , 
            describe "withinFloatRange"
            [

               fuzz2 fuzzyV1WithinFloatRange fuzzyV2WithinFloatRange "withinFloatRange should return inside range" <|
                \v1 v2 ->
                    Validation.withinFloatRange (validP1WithinFloatRangeForInsideRange v1) (validP2WithinFloatRangeForInsideRange v2)
                    |> summarizeWithinFloatRangeForInsideRange
                    |> Expect.equal ok1

            ,
               fuzz2 fuzzyV1WithinFloatRange fuzzyV2WithinFloatRange "withinFloatRange should return outside range" <|
                \v1 v2 ->
                    Validation.withinFloatRange (validP1WithinFloatRangeForOutsideRange v1) (validP2WithinFloatRangeForOutsideRange v2)
                    |> summarizeWithinFloatRangeForOutsideRange
                    |> Expect.equal ok1

            ]
        ]