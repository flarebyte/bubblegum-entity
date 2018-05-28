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

unitTestHeader = """
            describe "${name}"
            [
"""

unitTestValid1 = """
               fuzz fuzzyV1${nameU} "${name} should return ${state}" <|
                \\v1 ->
                    ${moduleName}.${name} (validP1${nameU}For${stateU} v1)
                    |> summarize${nameU}For${stateU}
                    |> Expect.equal ${ok}
"""

unitTestValid2 = """
               fuzz2 fuzzyV1${nameU} fuzzyV2${nameU} "${name} should return ${state}" <|
                \\v1 v2 ->
                    ${moduleName}.${name} (validP1${nameU}For${stateU} v1) (validP2${nameU}For${stateU} v2)
                    |> summarize${nameU}For${stateU}
                    |> Expect.equal ${ok}
"""

unitTestValid3 = """
               fuzz3 fuzzyV1${nameU} fuzzyV2${nameU} fuzzyV3${nameU} "${name} should return ${state}" <|
                \\v1 v2 v3->
                    ${moduleName}.${name} (validP1${nameU}For${stateU} v1) (validP2${nameU}For${stateU} v2) (validP3${nameU}For${stateU} v3)
                    |> summarize${nameU}For${stateU}
                    |> Expect.equal ${ok}
"""

unitTestValid = [unitTestValid1, unitTestValid2, unitTestValid3]

unitTestDataHeader1 = """
-- ${name}
fuzzyV1${nameU} : Fuzzer String -- should produce ${paramType0}
fuzzyV1${nameU} = string 
"""

unitTestDataHeader2 = """
-- ${name}
fuzzyV1${nameU} : Fuzzer String -- should produce ${paramType0}
fuzzyV1${nameU} = string 

fuzzyV2${nameU} : Fuzzer String -- should produce ${paramType1}
fuzzyV2${nameU} = string 
"""

unitTestDataHeader3 = """
-- ${name}
fuzzyV1${nameU} : Fuzzer String -- should produce ${paramType0}
fuzzyV1${nameU} = string 

fuzzyV2${nameU} : Fuzzer String -- should produce ${paramType1}
fuzzyV2${nameU} = string

fuzzyV3${nameU} : Fuzzer String -- should produce ${paramType2}
fuzzyV3${nameU} = string 
 
"""
unitTestDataHeader=[unitTestDataHeader1, unitTestDataHeader2, unitTestDataHeader3]

unitTestDataState1 = """
validP1${nameU}For${stateU}: String -> ${paramType0}
validP1${nameU}For${stateU} value =
    value
    
summarize${nameU}For${stateU}: ${returned} -> List String
summarize${nameU}For${stateU} result =
    [
        justOrErr "attr is missing" result.attr
        , ok
    ]
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
        justOrErr "attr is missing" result.attr
        , ok
    ]
"""

unitTestDataState3 = """
validP1${nameU}For${stateU}: String -> ${paramType0}
validP1${nameU}For${stateU} value =
    value

validP2${nameU}For${stateU}: String -> ${paramType1}
validP2${nameU}For${stateU} value =
    value

validP3${nameU}For${stateU}: String -> ${paramType2}
validP3${nameU}For${stateU} value =
    value
    
summarize${nameU}For${stateU}: ${returned} -> List String
summarize${nameU}For${stateU} result =
    [
        justOrErr "attr is missing" result.attr
        , ok
    ]
"""

unitTestDataState = [unitTestDataState1, unitTestDataState2, unitTestDataState3]