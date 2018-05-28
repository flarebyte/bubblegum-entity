module OutcomeTests exposing (suite)

{-| Unit tests for testing the Bubblegum.Entity.Outcome

  **generated** in scripts/*.py

-}
import Test exposing (..)
import Expect as Expect
import FunctionTester exposing (ok,ok1,ok2,ok3)
import OutcomeTestData exposing (..)
import Bubblegum.Entity.Outcome as Outcome


suite : Test
suite =
    describe "The Outcome module"
        [ 

            describe "withDefault"
            [

               fuzz2 fuzzyV1WithDefault fuzzyV2WithDefault "withDefault should return valid" <|
                \v1 v2 ->
                    Outcome.withDefault (validP1WithDefaultForValid v1) (validP2WithDefaultForValid v2)
                    |> summarizeWithDefaultForValid
                    |> Expect.equal ok2

            ,
               fuzz2 fuzzyV1WithDefault fuzzyV2WithDefault "withDefault should return none" <|
                \v1 v2 ->
                    Outcome.withDefault (validP1WithDefaultForNone v1) (validP2WithDefaultForNone v2)
                    |> summarizeWithDefaultForNone
                    |> Expect.equal ok2

            ]            , 
            describe "map"
            [

               fuzz2 fuzzyV1Map fuzzyV2Map "map should return valid" <|
                \v1 v2 ->
                    Outcome.map (validP1MapForValid v1) (validP2MapForValid v2)
                    |> summarizeMapForValid
                    |> Expect.equal ok2

            ,
               fuzz2 fuzzyV1Map fuzzyV2Map "map should return none" <|
                \v1 v2 ->
                    Outcome.map (validP1MapForNone v1) (validP2MapForNone v2)
                    |> summarizeMapForNone
                    |> Expect.equal ok2

            ,
               fuzz2 fuzzyV1Map fuzzyV2Map "map should return warning" <|
                \v1 v2 ->
                    Outcome.map (validP1MapForWarning v1) (validP2MapForWarning v2)
                    |> summarizeMapForWarning
                    |> Expect.equal ok2

            ]
        ]