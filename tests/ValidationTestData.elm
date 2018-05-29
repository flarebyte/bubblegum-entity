module ValidationTestData exposing (..)

{-| Unit tests for testing the Bubblegum.Entity.Validation

-}
import Fuzz exposing (Fuzzer, int, list, string, float, intRange, floatRange, constant, tuple)
import Bubblegum.Entity.Outcome as Outcome exposing (Outcome(..))
import Bubblegum.Entity.Outcome as Validation exposing (..)
import OutcomeTestHelper exposing(..)

-- asIntRange
fuzzyV1AsIntRange : Fuzzer Int -- should produce Outcome ( Int, Int )
fuzzyV1AsIntRange = int


validP1AsIntRangeForValid: Int -> Outcome ( Int, Int ) -- about outcome
validP1AsIntRangeForValid value =
    Valid (value, value + 100)

summarizeAsIntRangeForValid: Outcome ( Int, Int ) -> List String
summarizeAsIntRangeForValid result =
    [
        expectValid result
    ]

validP1AsIntRangeForInvalid: Int -> Outcome ( Int, Int ) -- about outcome
validP1AsIntRangeForInvalid value =
    Valid (value + 100, value)

summarizeAsIntRangeForInvalid: Outcome ( Int, Int ) -> List String
summarizeAsIntRangeForInvalid result =
    [
        expectWarning result
    ]

-- asFloatRange
fuzzyV1AsFloatRange : Fuzzer Float -- should produce Outcome ( Float, Float )
fuzzyV1AsFloatRange = float


validP1AsFloatRangeForValid: Float -> Outcome ( Float, Float ) -- about outcome
validP1AsFloatRangeForValid value =
     Valid (value, value + 100.3)

summarizeAsFloatRangeForValid: Outcome ( Float, Float ) -> List String
summarizeAsFloatRangeForValid result =
    [
        expectValid result
    ]


validP1AsFloatRangeForInvalid: Float -> Outcome ( Float, Float ) -- about outcome
validP1AsFloatRangeForInvalid value =
    Valid (value + 13.5, value)

summarizeAsFloatRangeForInvalid: Outcome ( Float, Float ) -> List String
summarizeAsFloatRangeForInvalid result =
    [
        expectWarning result
    ]

-- withinIntRange
fuzzyV1WithinIntRange : Fuzzer Int -- should produce ( Int, Int )
fuzzyV1WithinIntRange = intRange 100 10000

fuzzyV2WithinIntRange : Fuzzer Int -- should produce Outcome ( Int, Int )
fuzzyV2WithinIntRange = intRange -80 80


validP1WithinIntRangeForInsideRange: Int -> ( Int, Int ) -- about range
validP1WithinIntRangeForInsideRange value =
    (-1 * value, value)

validP2WithinIntRangeForInsideRange: Int -> Outcome ( Int, Int ) -- about outcome
validP2WithinIntRangeForInsideRange value =
    Valid (value, value + 5)

summarizeWithinIntRangeForInsideRange: Outcome ( Int, Int ) -> List String
summarizeWithinIntRangeForInsideRange result =
    [
        expectValid result
    ]

validP1WithinIntRangeForOutsideRange: Int -> ( Int, Int ) -- about range
validP1WithinIntRangeForOutsideRange value =
     (-1 * value, value)

validP2WithinIntRangeForOutsideRange: Int -> Outcome ( Int, Int ) -- about outcome
validP2WithinIntRangeForOutsideRange value =
    Valid ( value + 20000, value + 30000)

summarizeWithinIntRangeForOutsideRange: Outcome ( Int, Int ) -> List String
summarizeWithinIntRangeForOutsideRange result =
    [
        expectWarning result
    ]


-- withinFloatRange
fuzzyV1WithinFloatRange : Fuzzer Float -- should produce ( Float, Float )
fuzzyV1WithinFloatRange = floatRange 100 10000

fuzzyV2WithinFloatRange : Fuzzer Float -- should produce Outcome ( Float, Float )
fuzzyV2WithinFloatRange = floatRange -80 80


validP1WithinFloatRangeForInsideRange: Float -> ( Float, Float ) -- about range
validP1WithinFloatRangeForInsideRange value =
    (-1 * value, value)

validP2WithinFloatRangeForInsideRange: Float -> Outcome ( Float, Float ) -- about outcome
validP2WithinFloatRangeForInsideRange value =
    Valid (value, value + 5)

summarizeWithinFloatRangeForInsideRange: Outcome ( Float, Float ) -> List String
summarizeWithinFloatRangeForInsideRange result =
    [
        expectValid result
    ]


validP1WithinFloatRangeForOutsideRange: Float -> ( Float, Float ) -- about range
validP1WithinFloatRangeForOutsideRange value =
     (-1 * value, value)

validP2WithinFloatRangeForOutsideRange: Float -> Outcome ( Float, Float ) -- about outcome
validP2WithinFloatRangeForOutsideRange value =
    Valid ( value + 20000, value + 30000)

summarizeWithinFloatRangeForOutsideRange: Outcome ( Float, Float ) -> List String
summarizeWithinFloatRangeForOutsideRange result =
    [
        expectWarning result
    ]

-- listStrictlyLessThan
fuzzyV1ListStrictlyLessThan : Fuzzer Int -- should produce Int
fuzzyV1ListStrictlyLessThan = intRange 20 50

fuzzyV2ListStrictlyLessThan : Fuzzer Int -- should produce Outcome (List String)
fuzzyV2ListStrictlyLessThan = intRange 0 10


validP1ListStrictlyLessThanForValid: Int -> Int -- about size
validP1ListStrictlyLessThanForValid value =
    value

validP2ListStrictlyLessThanForValid: Int -> Outcome (List String) -- about outcome
validP2ListStrictlyLessThanForValid value =
    String.repeat value "a," |> String.split "," |> Valid

summarizeListStrictlyLessThanForValid: Outcome (List String) -> List String
summarizeListStrictlyLessThanForValid result =
    [
        expectValid result
    ]

validP1ListStrictlyLessThanForInvalid: Int -> Int -- about size
validP1ListStrictlyLessThanForInvalid value =
    value

validP2ListStrictlyLessThanForInvalid: Int -> Outcome (List String) -- about outcome
validP2ListStrictlyLessThanForInvalid value =
    String.repeat (value + 100) "a," |> String.split "," |> Valid

summarizeListStrictlyLessThanForInvalid: Outcome (List String) -> List String
summarizeListStrictlyLessThanForInvalid result =
    [
        expectWarning result
    ]
