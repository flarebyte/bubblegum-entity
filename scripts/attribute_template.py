#!/usr/bin/python


headerTestFile = """
module ${moduleName}Tests exposing (suite)

{-| Unit tests for testing the Bubblegum.Entity.${moduleName}

  **generated** in scripts/*.py

-}
import Test exposing (..)


suite : Test
suite =
    describe "The ${moduleName} module"
            [ 

""" 

unitTestValid2P1 = """
               fuzz2 fuzzyV1${nameU} fuzzyV2${nameU} "${name} should return a valid ${returned} for a valid ${params}" <|
                \v1 v2 ->
                    Attribute.${name} (validP1${nameU} v1) (validP2${nameU} v2)
                    |> summarize${nameU}
                    |> Expect.equal expectedValid${nameU}

"""       