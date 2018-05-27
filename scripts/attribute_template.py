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

unitTestValid2 = """
            describe "${name} expecting ${state}"
            [
               fuzz2 fuzzyV1${nameU} fuzzyV2${nameU} "${name} should return ${state} for a valid ${paramName0}" <|
                \\v1 v2 ->
                    Attribute.${name} (validP1${nameU}For${stateU} v1) (validP2${nameU}For${stateU} v2)
                    |> summarize${nameU}For${stateU}
                    |> Expect.equal ${ok}
               
               , fuzz2 fuzzyV1${nameU} fuzzyV2${nameU} "${name} should return ${state} for a valid ${paramName1}" <|
                \\v1 v2 ->
                    Attribute.${name} (validP1${nameU}For${stateU} v1) (validP2${nameU}For${stateU} v2)
                    |> summarize${nameU}For${stateU}
                    |> Expect.equal ${ok}
            ]

"""

