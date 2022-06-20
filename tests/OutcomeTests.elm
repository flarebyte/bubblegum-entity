module OutcomeTests exposing (suite)

{-| Unit tests for testing the Bubblegum.Entity.Outcome

  **generated** with make generate

-}
import Test exposing (..)
import Expect as Expect
import FunctionTester exposing (ok1,ok2)
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
               ,fuzz2 fuzzyV1WithDefault fuzzyV2WithDefault "withDefault should return none" <|
                \v1 v2 ->
                    Outcome.withDefault (validP1WithDefaultForNone v1) (validP2WithDefaultForNone v2)
                    |> summarizeWithDefaultForNone
                    |> Expect.equal ok2
            ],
            describe "map"    
            [
               fuzz2 fuzzyV1Map fuzzyV2Map "map should return valid" <|
                \v1 v2 ->
                    Outcome.map (validP1MapForValid v1) (validP2MapForValid v2)
                    |> summarizeMapForValid
                    |> Expect.equal ok2
               ,fuzz2 fuzzyV1Map fuzzyV2Map "map should return none" <|
                \v1 v2 ->
                    Outcome.map (validP1MapForNone v1) (validP2MapForNone v2)
                    |> summarizeMapForNone
                    |> Expect.equal ok2
               ,fuzz2 fuzzyV1Map fuzzyV2Map "map should return warning" <|
                \v1 v2 ->
                    Outcome.map (validP1MapForWarning v1) (validP2MapForWarning v2)
                    |> summarizeMapForWarning
                    |> Expect.equal ok2
            ],
            describe "map2"    
            [
               fuzz3 fuzzyV1Map2 fuzzyV2Map2 fuzzyV3Map2 "map2 should return valid" <|
                \v1 v2 v3->
                    Outcome.map2 (validP1Map2ForValid v1) (validP2Map2ForValid v2) (validP3Map2ForValid v3)
                    |> summarizeMap2ForValid
                    |> Expect.equal ok2
               ,fuzz3 fuzzyV1Map2 fuzzyV2Map2 fuzzyV3Map2 "map2 should return none" <|
                \v1 v2 v3->
                    Outcome.map2 (validP1Map2ForNone v1) (validP2Map2ForNone v2) (validP3Map2ForNone v3)
                    |> summarizeMap2ForNone
                    |> Expect.equal ok2
               ,fuzz3 fuzzyV1Map2 fuzzyV2Map2 fuzzyV3Map2 "map2 should return warning" <|
                \v1 v2 v3->
                    Outcome.map2 (validP1Map2ForWarning v1) (validP2Map2ForWarning v2) (validP3Map2ForWarning v3)
                    |> summarizeMap2ForWarning
                    |> Expect.equal ok2
            ],
            describe "check"    
            [
               fuzz3 fuzzyV1Check fuzzyV2Check fuzzyV3Check "check should return valid" <|
                \v1 v2 v3->
                    Outcome.check (validP1CheckForValid v1) (validP2CheckForValid v2) (validP3CheckForValid v3)
                    |> summarizeCheckForValid
                    |> Expect.equal ok2
               ,fuzz3 fuzzyV1Check fuzzyV2Check fuzzyV3Check "check should return none" <|
                \v1 v2 v3->
                    Outcome.check (validP1CheckForNone v1) (validP2CheckForNone v2) (validP3CheckForNone v3)
                    |> summarizeCheckForNone
                    |> Expect.equal ok2
               ,fuzz3 fuzzyV1Check fuzzyV2Check fuzzyV3Check "check should return warning" <|
                \v1 v2 v3->
                    Outcome.check (validP1CheckForWarning v1) (validP2CheckForWarning v2) (validP3CheckForWarning v3)
                    |> summarizeCheckForWarning
                    |> Expect.equal ok2
               ,fuzz3 fuzzyV1Check fuzzyV2Check fuzzyV3Check "check should return check failed" <|
                \v1 v2 v3->
                    Outcome.check (validP1CheckForCheckFailed v1) (validP2CheckForCheckFailed v2) (validP3CheckForCheckFailed v3)
                    |> summarizeCheckForCheckFailed
                    |> Expect.equal ok2
            ],
            describe "checkOrNone"    
            [
               fuzz2 fuzzyV1CheckOrNone fuzzyV2CheckOrNone "checkOrNone should return valid" <|
                \v1 v2 ->
                    Outcome.checkOrNone (validP1CheckOrNoneForValid v1) (validP2CheckOrNoneForValid v2)
                    |> summarizeCheckOrNoneForValid
                    |> Expect.equal ok2
               ,fuzz2 fuzzyV1CheckOrNone fuzzyV2CheckOrNone "checkOrNone should return check failed" <|
                \v1 v2 ->
                    Outcome.checkOrNone (validP1CheckOrNoneForCheckFailed v1) (validP2CheckOrNoneForCheckFailed v2)
                    |> summarizeCheckOrNoneForCheckFailed
                    |> Expect.equal ok2
               ,fuzz2 fuzzyV1CheckOrNone fuzzyV2CheckOrNone "checkOrNone should return warning" <|
                \v1 v2 ->
                    Outcome.checkOrNone (validP1CheckOrNoneForWarning v1) (validP2CheckOrNoneForWarning v2)
                    |> summarizeCheckOrNoneForWarning
                    |> Expect.equal ok2
            ],
            describe "trueMapToConstant"    
            [
               fuzz2 fuzzyV1TrueMapToConstant fuzzyV2TrueMapToConstant "trueMapToConstant should return true" <|
                \v1 v2 ->
                    Outcome.trueMapToConstant (validP1TrueMapToConstantForTrue v1) (validP2TrueMapToConstantForTrue v2)
                    |> summarizeTrueMapToConstantForTrue
                    |> Expect.equal ok2
               ,fuzz2 fuzzyV1TrueMapToConstant fuzzyV2TrueMapToConstant "trueMapToConstant should return false" <|
                \v1 v2 ->
                    Outcome.trueMapToConstant (validP1TrueMapToConstantForFalse v1) (validP2TrueMapToConstantForFalse v2)
                    |> summarizeTrueMapToConstantForFalse
                    |> Expect.equal ok2
            ],
            describe "or"    
            [
               fuzz2 fuzzyV1Or fuzzyV2Or "or should return first" <|
                \v1 v2 ->
                    Outcome.or (validP1OrForFirst v1) (validP2OrForFirst v2)
                    |> summarizeOrForFirst
                    |> Expect.equal ok2
               ,fuzz2 fuzzyV1Or fuzzyV2Or "or should return second" <|
                \v1 v2 ->
                    Outcome.or (validP1OrForSecond v1) (validP2OrForSecond v2)
                    |> summarizeOrForSecond
                    |> Expect.equal ok2
            ],
            describe "fromMaybe"    
            [
               fuzz fuzzyV1FromMaybe "fromMaybe should return valid" <|
                \v1 ->
                    Outcome.fromMaybe (validP1FromMaybeForValid v1)
                    |> summarizeFromMaybeForValid
                    |> Expect.equal ok2
               ,fuzz fuzzyV1FromMaybe "fromMaybe should return none" <|
                \v1 ->
                    Outcome.fromMaybe (validP1FromMaybeForNone v1)
                    |> summarizeFromMaybeForNone
                    |> Expect.equal ok2
            ],
            describe "toMaybe"    
            [
               fuzz fuzzyV1ToMaybe "toMaybe should return just" <|
                \v1 ->
                    Outcome.toMaybe (validP1ToMaybeForJust v1)
                    |> summarizeToMaybeForJust
                    |> Expect.equal ok1
               ,fuzz fuzzyV1ToMaybe "toMaybe should return nothing" <|
                \v1 ->
                    Outcome.toMaybe (validP1ToMaybeForNothing v1)
                    |> summarizeToMaybeForNothing
                    |> Expect.equal ok1
            ]
            
        ]