
module AttributeTests exposing (suite)

{-| Unit tests for testing the Bubblegum.Entity.Attribute

  **generated** in scripts/*.py

-}
import Test exposing (..)


suite : Test
suite =
    describe "The Attribute module"
            [ 


               fuzz2 fuzzyV1Findattributebykey fuzzyV2Findattributebykey "findAttributeByKey should return a valid List Model for a valid ['alpha', 'beta']" <|
                1 v2 ->
                    Attribute.findAttributeByKey (validP1Findattributebykey v1) (validP2Findattributebykey v2)
                    |> summarizeFindattributebykey
                    |> Expect.equal expectedValidFindattributebykey

