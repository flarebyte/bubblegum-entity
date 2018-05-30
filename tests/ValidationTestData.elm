module ValidationTestData exposing (..)

{-| Unit tests for testing the Bubblegum.Entity.Validation

-}
import Fuzz exposing (Fuzzer, int, list, string, float, intRange, floatRange, constant, tuple, oneOf)
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

-- listStrictlyMoreThan
fuzzyV1ListStrictlyMoreThan : Fuzzer Int -- should produce Int
fuzzyV1ListStrictlyMoreThan = intRange 1 5

fuzzyV2ListStrictlyMoreThan : Fuzzer Int -- should produce Outcome (List String)
fuzzyV2ListStrictlyMoreThan = intRange 10 50


validP1ListStrictlyMoreThanForValid: Int -> Int -- about size
validP1ListStrictlyMoreThanForValid value =
    value

validP2ListStrictlyMoreThanForValid: Int -> Outcome (List String) -- about outcome
validP2ListStrictlyMoreThanForValid value =
    String.repeat value "a," |> String.split "," |> Valid

summarizeListStrictlyMoreThanForValid: Outcome (List String) -> List String
summarizeListStrictlyMoreThanForValid result =
    [
        expectValid result
    ]

validP1ListStrictlyMoreThanForInvalid: Int -> Int -- about size
validP1ListStrictlyMoreThanForInvalid value =
    value + 10

validP2ListStrictlyMoreThanForInvalid: Int -> Outcome (List String) -- about outcome
validP2ListStrictlyMoreThanForInvalid value =
    String.repeat 2 "a," |> String.split "," |> Valid

summarizeListStrictlyMoreThanForInvalid: Outcome (List String) -> List String
summarizeListStrictlyMoreThanForInvalid result =
    [
        expectWarning result
    ]

-- matchAbsoluteUrl
fuzzyV1MatchAbsoluteUrl : Fuzzer Int -- should produce Outcome String
fuzzyV1MatchAbsoluteUrl = intRange 1 30


validP1MatchAbsoluteUrlForValid: Int -> Outcome String -- about outcome
validP1MatchAbsoluteUrlForValid value =
   "http://a" ++ (String.repeat value "/b") |> Valid

summarizeMatchAbsoluteUrlForValid: Outcome String -> List String
summarizeMatchAbsoluteUrlForValid result =
    [
        expectValid result
    ]

validP1MatchAbsoluteUrlForInvalid: Int -> Outcome String -- about outcome
validP1MatchAbsoluteUrlForInvalid value =
    "ssh://" ++ (String.repeat value "/b") |> Valid

summarizeMatchAbsoluteUrlForInvalid: Outcome String -> List String
summarizeMatchAbsoluteUrlForInvalid result =
    [
        expectWarning result
    ]

-- matchEnum
fuzzyV1MatchEnum : Fuzzer (List String) -- should produce List String
fuzzyV1MatchEnum = oneOf [
    constant ["alpha","bravo","charlie", "delta", "echo", "fox", "golf", "hotel", "i"]
    , constant ["alpha","bravo","charlie", "delta", "echo", "fox", "india"]
    , constant ["alpha","bravo","charlie", "delta", "echo", "fox", "zulu"]
    ]

fuzzyV2MatchEnum : Fuzzer String -- should produce Outcome String
fuzzyV2MatchEnum = oneOf [
        constant "alpha"
        , constant "bravo"
        , constant "charlie" 
    ]


validP1MatchEnumForValid: List String -> List String -- about enum
validP1MatchEnumForValid value =
    value

validP2MatchEnumForValid: String -> Outcome String -- about outcome
validP2MatchEnumForValid value =
    Valid value

summarizeMatchEnumForValid: Outcome String -> List String
summarizeMatchEnumForValid result =
    [
        expectValid result
    ]


validP1MatchEnumForInvalid: List String -> List String -- about enum
validP1MatchEnumForInvalid value =
    value

validP2MatchEnumForInvalid: String -> Outcome String -- about outcome
validP2MatchEnumForInvalid value =
    Valid "oscar"

summarizeMatchEnumForInvalid: Outcome String -> List String
summarizeMatchEnumForInvalid result =
    [
        expectWarning result
    ]

-- matchCompactUri
fuzzyV1MatchCompactUri : Fuzzer String -- should produce Outcome String
fuzzyV1MatchCompactUri = oneOf [
        constant "uri:a"
        , constant "uri:a/b"
        , constant "uri:a/b123.com"
        , constant "uri:req?a=b"
        , constant "uri:12-56"
    ]


validP1MatchCompactUriForValid: String -> Outcome String -- about outcome
validP1MatchCompactUriForValid value =
    Valid value

summarizeMatchCompactUriForValid: Outcome String -> List String
summarizeMatchCompactUriForValid result =
    [
        expectValid result
    ]


validP1MatchCompactUriForInvalid: String -> Outcome String -- about outcome
validP1MatchCompactUriForInvalid value =
    Valid ("1234567890123456789" ++ value)

summarizeMatchCompactUriForInvalid: Outcome String -> List String
summarizeMatchCompactUriForInvalid result =
    [
        expectWarning result
    ]

-- stringStartsWith
fuzzyV1StringStartsWith : Fuzzer Int -- should produce String
fuzzyV1StringStartsWith = intRange 3 5

fuzzyV2StringStartsWith : Fuzzer String -- should produce Outcome String
fuzzyV2StringStartsWith = string


validP1StringStartsWithForValid: Int -> String -- about prefix
validP1StringStartsWithForValid value =
    String.repeat value "AB"

validP2StringStartsWithForValid: String -> Outcome String -- about outcome
validP2StringStartsWithForValid value =
    Valid (String.repeat 7 "AB" ++ value)

summarizeStringStartsWithForValid: Outcome String -> List String
summarizeStringStartsWithForValid result =
    [
        expectValid result
    ]

validP1StringStartsWithForInvalid: Int -> String -- about prefix
validP1StringStartsWithForInvalid value =
    String.repeat value "AB"

validP2StringStartsWithForInvalid: String -> Outcome String -- about outcome
validP2StringStartsWithForInvalid value =
    Valid value

summarizeStringStartsWithForInvalid: Outcome String -> List String
summarizeStringStartsWithForInvalid result =
    [
        expectWarning result
    ]

-- withinStringCharsRange
fuzzyV1WithinStringCharsRange : Fuzzer Int -- should produce ( Int, Int )
fuzzyV1WithinStringCharsRange = intRange 50 100

fuzzyV2WithinStringCharsRange : Fuzzer Int -- should produce Outcome String
fuzzyV2WithinStringCharsRange = intRange 20 40


validP1WithinStringCharsRangeForValid: Int -> ( Int, Int ) -- about range
validP1WithinStringCharsRangeForValid value =
    (value, value + 200)

validP2WithinStringCharsRangeForValid: Int -> Outcome String -- about outcome
validP2WithinStringCharsRangeForValid value =
    String.repeat (value + 100) "A" |> Valid

summarizeWithinStringCharsRangeForValid: Outcome String -> List String
summarizeWithinStringCharsRangeForValid result =
    [
       expectValid result
    ]

validP1WithinStringCharsRangeForInvalid: Int -> ( Int, Int ) -- about range
validP1WithinStringCharsRangeForInvalid value =
    (value, value + 200)

validP2WithinStringCharsRangeForInvalid: Int -> Outcome String -- about outcome
validP2WithinStringCharsRangeForInvalid value =
    String.repeat (value) "A" |> Valid

summarizeWithinStringCharsRangeForInvalid: Outcome String -> List String
summarizeWithinStringCharsRangeForInvalid result =
    [
        expectWarning result
    ]
