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
               fuzz2 fuzzyV1${nameU} fuzzyV2${nameU} "${name} should return ${state} when testing ${paramName0}" <|
                \\v1 v2 ->
                    Attribute.${name} (underTestP1${nameU}For${stateU} v1) (validP2${nameU}For${stateU} v2)
                    |> summarize${nameU}For${stateU}
                    |> Expect.equal ${ok}
               
               , fuzz2 fuzzyV1${nameU} fuzzyV2${nameU} "${name} should return ${state} when testing ${paramName1}" <|
                \\v1 v2 ->
                    Attribute.${name} (validP1${nameU}For${stateU} v1) (underTestP2${nameU}For${stateU} v2)
                    |> summarize${nameU}For${stateU}
                    |> Expect.equal ${ok}
            ]

"""

unitTestDataValid2 = """
-- ${name}
fuzzyV1${nameU} : Fuzzer String
fuzzyV1${nameU} = string 

fuzzyV2${nameU} : Fuzzer String
fuzzyV2${nameU} = string 


validP1${nameU}For${stateU}: String -> ${paramType0}
validP1${nameU}For${stateU} value =
    value

validP2${nameU}For${stateU}: String -> ${paramType1}
validP2${nameU}For${stateU} value =
    value

underTestP1${nameU}For${stateU}: String -> ${paramType0}
underTestP1${nameU}For${stateU} value =
    value

underTestP2${nameU}For${stateU}: String -> ${paramType1}
underTestP2${nameU}For${stateU} value =
    value
    

summarize${nameU}For${stateU}: ${returned} -> List String
summarize${nameU}For${stateU} result =
    [
        justOrErr/nonEmptyStringOrErr/atLeastOneStringOrErr "attr is missing" result.attr
    ]

"""

