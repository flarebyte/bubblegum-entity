module AttributeTests exposing (suite)

{-| Unit tests for testing the Bubblegum.Entity.Attribute

    generated

-}

import Test exposing (..)
import AttributeTestData exposing(..)
import Bubblegum.Entity.Attribute as Attribute
import Expect exposing(equal)
suite : Test
suite =
    describe "The Attribute module"
        [ describe "setId"
            [
               fuzz2 fuzzyV1SetId fuzzyV2SetId "setId should work with valid parameters" <|
                \v1 v2 ->
                    Attribute.setId (validP1SetId v1) (validP2SetId v2)
                    |> summarizeSetId
                    |> Expect.equal expectedValidSetId
                
                , fuzz2 fuzzyV1SetId fuzzyV2SetId "setId should work when id is nothing" <|
                \v1 v2 ->
                    Attribute.setId Nothing (validP2SetId v2)
                    |> summarizeSetIdWithIdNothing
                    |> Expect.equal expectedValidSetId
             ]
        ]
