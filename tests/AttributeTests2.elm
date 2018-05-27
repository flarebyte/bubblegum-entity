
module AttributeTests exposing (suite)

{-| Unit tests for testing the Bubblegum.Entity.Attribute

  **generated** in scripts/*.py

-}
import Test exposing (..)


suite : Test
suite =
    describe "The Attribute module"
            [ 


            describe "findAttributeByKey expecting just model"
            [
               fuzz2 fuzzyV1FindAttributeByKey fuzzyV2FindAttributeByKey "findAttributeByKey should return just model for a valid key" <|
                \v1 v2 ->
                    Attribute.findAttributeByKey (validP1FindAttributeByKeyForJustModel v1) (validP2FindAttributeByKeyForJustModel v2)
                    |> summarizeFindAttributeByKeyForJustModel
                    |> Expect.equal ok2
               
               , fuzz2 fuzzyV1FindAttributeByKey fuzzyV2FindAttributeByKey "findAttributeByKey should return just model for a valid attributes" <|
                \v1 v2 ->
                    Attribute.findAttributeByKey (validP1FindAttributeByKeyForJustModel v1) (validP2FindAttributeByKeyForJustModel v2)
                    |> summarizeFindAttributeByKeyForJustModel
                    |> Expect.equal ok2
            ]

            ,
            describe "findAttributeByKey expecting nothing"
            [
               fuzz2 fuzzyV1FindAttributeByKey fuzzyV2FindAttributeByKey "findAttributeByKey should return nothing for a valid key" <|
                \v1 v2 ->
                    Attribute.findAttributeByKey (validP1FindAttributeByKeyForNothing v1) (validP2FindAttributeByKeyForNothing v2)
                    |> summarizeFindAttributeByKeyForNothing
                    |> Expect.equal ok2
               
               , fuzz2 fuzzyV1FindAttributeByKey fuzzyV2FindAttributeByKey "findAttributeByKey should return nothing for a valid attributes" <|
                \v1 v2 ->
                    Attribute.findAttributeByKey (validP1FindAttributeByKeyForNothing v1) (validP2FindAttributeByKeyForNothing v2)
                    |> summarizeFindAttributeByKeyForNothing
                    |> Expect.equal ok2
            ]

