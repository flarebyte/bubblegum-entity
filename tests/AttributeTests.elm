module AttributeTests exposing (suite)

{-| Unit tests for testing the Bubblegum.Entity.Attribute

  **generated** in scripts/*.py

-}
import Test exposing (..)
import Expect as Expect
import FunctionTester exposing (ok,ok1,ok2,ok3)
import AttributeTestData exposing (..)
import Bubblegum.Entity.Attribute as Attribute


suite : Test
suite =
    describe "The Attribute module"
        [ 

            describe "findAttributeByKey"
            [

               fuzz2 fuzzyV1FindAttributeByKey fuzzyV2FindAttributeByKey "findAttributeByKey should return just model when testing key" <|
                \v1 v2 ->
                    Attribute.findAttributeByKey (validP1FindAttributeByKeyForJustModel v1) (validP2FindAttributeByKeyForJustModel v2)
                    |> summarizeFindAttributeByKeyForJustModel
                    |> Expect.equal ok2
            ,
               fuzz2 fuzzyV1FindAttributeByKey fuzzyV2FindAttributeByKey "findAttributeByKey should return nothing when testing key" <|
                \v1 v2 ->
                    Attribute.findAttributeByKey (validP1FindAttributeByKeyForNothing v1) (validP2FindAttributeByKeyForNothing v2)
                    |> summarizeFindAttributeByKeyForNothing
                    |> Expect.equal ok2

            ]
        ]