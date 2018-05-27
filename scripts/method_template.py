#!/usr/bin/python


headerTestFile = """module ${moduleName}Tests exposing (suite)

{-| Unit tests for testing the Bubblegum.Entity.${moduleName}

  **generated** in scripts/*.py

-}
import Test exposing (..)
import Expect as Expect
import FunctionTester exposing (ok,ok1,ok2,ok3)
import ${moduleName}TestData exposing (..)
import ${packageNameDot}.${moduleName} as ${moduleName}


suite : Test
suite =
    describe "The ${moduleName} module"
        [ 
""" 

unitTestHeader2 = """
            describe "${name}"
            [
"""
unitTestValid2 = """
               fuzz2 fuzzyV1${nameU} fuzzyV2${nameU} "${name} should return ${state} when testing ${paramName0}" <|
                \\v1 v2 ->
                    ${moduleName}.${name} (validP1${nameU}For${stateU} v1) (validP2${nameU}For${stateU} v2)
                    |> summarize${nameU}For${stateU}
                    |> Expect.equal ${ok}
"""

unitTestDataHeader2 = """
-- ${name}
fuzzyV1${nameU} : Fuzzer String -- should produce ${paramType0}
fuzzyV1${nameU} = string 

fuzzyV2${nameU} : Fuzzer String -- should produce  ${paramType1}
fuzzyV2${nameU} = string 
"""

unitTestDataState2 = """
validP1${nameU}For${stateU}: String -> ${paramType0}
validP1${nameU}For${stateU} value =
    value

validP2${nameU}For${stateU}: String -> ${paramType1}
validP2${nameU}For${stateU} value =
    value
    
summarize${nameU}For${stateU}: ${returned} -> List String
summarize${nameU}For${stateU} result =
    [
        justOrErr/nonEmptyStringOrErr/atLeastOneStringOrErr "attr is missing" result.attr
    ]
"""