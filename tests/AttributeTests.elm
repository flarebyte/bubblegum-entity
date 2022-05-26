module AttributeTests exposing (suite)

{-| Unit tests for testing the Bubblegum.Entity.Attribute

**generated** in scripts/\*.py

-}

import AttributeTestData exposing (..)
import Bubblegum.Entity.Attribute as Attribute
import Expect as Expect
import FunctionTester exposing (ok, ok1, ok2, ok3)
import Test exposing (..)


suite : Test
suite =
    describe "The Attribute module"
        [ describe "findAttributeByKey"
            [ fuzz2 fuzzyV1FindAttributeByKey fuzzyV2FindAttributeByKey "findAttributeByKey should return just model" <|
                \v1 v2 ->
                    Attribute.findAttributeByKey (validP1FindAttributeByKeyForJustModel v1) (validP2FindAttributeByKeyForJustModel v2)
                        |> summarizeFindAttributeByKeyForJustModel
                        |> Expect.equal ok2
            , fuzz2 fuzzyV1FindAttributeByKey fuzzyV2FindAttributeByKey "findAttributeByKey should return nothing" <|
                \v1 v2 ->
                    Attribute.findAttributeByKey (validP1FindAttributeByKeyForNothing v1) (validP2FindAttributeByKeyForNothing v2)
                        |> summarizeFindAttributeByKeyForNothing
                        |> Expect.equal ok2
            ]
        , describe "deleteAttributeByKey"
            [ fuzz2 fuzzyV1DeleteAttributeByKey fuzzyV2DeleteAttributeByKey "deleteAttributeByKey should return list" <|
                \v1 v2 ->
                    Attribute.deleteAttributeByKey (validP1DeleteAttributeByKeyForList v1) (validP2DeleteAttributeByKeyForList v2)
                        |> summarizeDeleteAttributeByKeyForList
                        |> Expect.equal ok2
            , fuzz2 fuzzyV1DeleteAttributeByKey fuzzyV2DeleteAttributeByKey "deleteAttributeByKey should return empty list" <|
                \v1 v2 ->
                    Attribute.deleteAttributeByKey (validP1DeleteAttributeByKeyForEmptyList v1) (validP2DeleteAttributeByKeyForEmptyList v2)
                        |> summarizeDeleteAttributeByKeyForEmptyList
                        |> Expect.equal ok2
            ]
        , describe "findAttributeFirstValueByKey"
            [ fuzz2 fuzzyV1FindAttributeFirstValueByKey fuzzyV2FindAttributeFirstValueByKey "findAttributeFirstValueByKey should return just string" <|
                \v1 v2 ->
                    Attribute.findAttributeFirstValueByKey (validP1FindAttributeFirstValueByKeyForJustString v1) (validP2FindAttributeFirstValueByKeyForJustString v2)
                        |> summarizeFindAttributeFirstValueByKeyForJustString
                        |> Expect.equal ok2
            , fuzz2 fuzzyV1FindAttributeFirstValueByKey fuzzyV2FindAttributeFirstValueByKey "findAttributeFirstValueByKey should return nothing" <|
                \v1 v2 ->
                    Attribute.findAttributeFirstValueByKey (validP1FindAttributeFirstValueByKeyForNothing v1) (validP2FindAttributeFirstValueByKeyForNothing v2)
                        |> summarizeFindAttributeFirstValueByKeyForNothing
                        |> Expect.equal ok2
            ]
        , describe "findOutcomeByKey"
            [ fuzz2 fuzzyV1FindOutcomeByKey fuzzyV2FindOutcomeByKey "findOutcomeByKey should return valid outcome" <|
                \v1 v2 ->
                    Attribute.findOutcomeByKey (validP1FindOutcomeByKeyForValidOutcome v1) (validP2FindOutcomeByKeyForValidOutcome v2)
                        |> summarizeFindOutcomeByKeyForValidOutcome
                        |> Expect.equal ok2
            , fuzz2 fuzzyV1FindOutcomeByKey fuzzyV2FindOutcomeByKey "findOutcomeByKey should return none outcome" <|
                \v1 v2 ->
                    Attribute.findOutcomeByKey (validP1FindOutcomeByKeyForNoneOutcome v1) (validP2FindOutcomeByKeyForNoneOutcome v2)
                        |> summarizeFindOutcomeByKeyForNoneOutcome
                        |> Expect.equal ok2
            ]
        , describe "findOutcomeByKeyTuple"
            [ fuzz2 fuzzyV1FindOutcomeByKeyTuple fuzzyV2FindOutcomeByKeyTuple "findOutcomeByKeyTuple should return valid outcome" <|
                \v1 v2 ->
                    Attribute.findOutcomeByKeyTuple (validP1FindOutcomeByKeyTupleForValidOutcome v1) (validP2FindOutcomeByKeyTupleForValidOutcome v2)
                        |> summarizeFindOutcomeByKeyTupleForValidOutcome
                        |> Expect.equal ok2
            , fuzz2 fuzzyV1FindOutcomeByKeyTuple fuzzyV2FindOutcomeByKeyTuple "findOutcomeByKeyTuple should return outcome with first none" <|
                \v1 v2 ->
                    Attribute.findOutcomeByKeyTuple (validP1FindOutcomeByKeyTupleForOutcomeWithFirstNone v1) (validP2FindOutcomeByKeyTupleForOutcomeWithFirstNone v2)
                        |> summarizeFindOutcomeByKeyTupleForOutcomeWithFirstNone
                        |> Expect.equal ok2
            ]
        , describe "replaceAttributeByKey"
            [ fuzz3 fuzzyV1ReplaceAttributeByKey fuzzyV2ReplaceAttributeByKey fuzzyV3ReplaceAttributeByKey "replaceAttributeByKey should return list" <|
                \v1 v2 v3 ->
                    Attribute.replaceAttributeByKey (validP1ReplaceAttributeByKeyForList v1) (validP2ReplaceAttributeByKeyForList v2) (validP3ReplaceAttributeByKeyForList v3)
                        |> summarizeReplaceAttributeByKeyForList
                        |> Expect.equal ok2
            , fuzz3 fuzzyV1ReplaceAttributeByKey fuzzyV2ReplaceAttributeByKey fuzzyV3ReplaceAttributeByKey "replaceAttributeByKey should return empty list" <|
                \v1 v2 v3 ->
                    Attribute.replaceAttributeByKey (validP1ReplaceAttributeByKeyForEmptyList v1) (validP2ReplaceAttributeByKeyForEmptyList v2) (validP3ReplaceAttributeByKeyForEmptyList v3)
                        |> summarizeReplaceAttributeByKeyForEmptyList
                        |> Expect.equal ok2
            ]
        ]
