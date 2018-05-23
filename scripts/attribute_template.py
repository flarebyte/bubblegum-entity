#!/usr/bin/python


headerTestFile = """
module ${moduleName}Tests exposing (suite)

{-| Unit tests for testing the Bubblegum.Entity.${moduleName}

    generated

-}
import Test exposing (..)


suite : Test
suite =
    describe "The ${moduleName} module"
""" 

unitTestValid = """
module ${moduleName}Tests exposing (..)

{-| Unit tests for testing the Bubblegum.Entity.${moduleName}

    generated

-}
import Test exposing (..)


suite : Test
suite =
    describe "The ${moduleName} module"
"""       