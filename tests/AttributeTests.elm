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
               fuzz fuzzySetId "setId should work with valid parameters" <|
                \value ->
                    Attribute.setId (validSetId value |> .a) (validSetId value |> .b)
                    |> summarizeSetId
                    |> Expect.equal expectedValidSetId
                
                , fuzz fuzzySetId "setId should work when id is nothing" <|
                \value ->
                    Attribute.setId Nothing (validSetId value |> .b)
                    |> summarizeSetIdWithIdNothing
                    |> Expect.equal expectedValidSetId
             ]
        ]
