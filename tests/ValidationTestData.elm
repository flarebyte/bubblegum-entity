module ValidationTestData exposing (..)

{-| Unit tests for testing the Bubblegum.Entity.Validation
-}

import Bubblegum.Entity.Outcome exposing (..)
import Debug exposing (log)
import Fuzz exposing (Fuzzer, constant, float, floatRange, int, intRange, oneOf, string, tuple)
import OutcomeTestHelper exposing (..)
import Tuple exposing (mapSecond)



-- asIntRange


fuzzyV1AsIntRange : Fuzzer Int



-- should produce Outcome ( Int, Int )


fuzzyV1AsIntRange =
    int


validP1AsIntRangeForValid :
    Int
    -> Outcome ( Int, Int ) -- about outcome
validP1AsIntRangeForValid value =
    Valid ( value, value + 100 )


summarizeAsIntRangeForValid : Outcome ( Int, Int ) -> List String
summarizeAsIntRangeForValid result =
    [ expectValid result
    ]


validP1AsIntRangeForInvalid :
    Int
    -> Outcome ( Int, Int ) -- about outcome
validP1AsIntRangeForInvalid value =
    Valid ( value + 100, value )


summarizeAsIntRangeForInvalid : Outcome ( Int, Int ) -> List String
summarizeAsIntRangeForInvalid result =
    [ expectWarning result
    ]



-- asFloatRange


fuzzyV1AsFloatRange : Fuzzer Float



-- should produce Outcome ( Float, Float )


fuzzyV1AsFloatRange =
    float


validP1AsFloatRangeForValid :
    Float
    -> Outcome ( Float, Float ) -- about outcome
validP1AsFloatRangeForValid value =
    Valid ( value, value + 100.3 )


summarizeAsFloatRangeForValid : Outcome ( Float, Float ) -> List String
summarizeAsFloatRangeForValid result =
    [ expectValid result
    ]


validP1AsFloatRangeForInvalid :
    Float
    -> Outcome ( Float, Float ) -- about outcome
validP1AsFloatRangeForInvalid value =
    Valid ( value + 13.5, value )


summarizeAsFloatRangeForInvalid : Outcome ( Float, Float ) -> List String
summarizeAsFloatRangeForInvalid result =
    [ expectWarning result
    ]



-- withinIntRange


fuzzyV1WithinIntRange : Fuzzer ( Int, Int )



-- should produce ( Int, Int )


fuzzyV1WithinIntRange =
    tuple ( constant -1000, constant 1000 )


fuzzyV2WithinIntRange : Fuzzer ( Int, Int )



-- should produce Outcome ( Int, Int )


fuzzyV2WithinIntRange =
    oneOf
        [ tuple ( constant -500, constant 500 )
        , tuple ( constant 0, constant 500 )
        , tuple ( constant -1000, constant 0 )
        ]


validP1WithinIntRangeForValid :
    ( Int, Int )
    -> ( Int, Int ) -- about range
validP1WithinIntRangeForValid value =
    value


validP2WithinIntRangeForValid :
    ( Int, Int )
    -> Outcome ( Int, Int ) -- about outcome
validP2WithinIntRangeForValid value =
    Valid value


summarizeWithinIntRangeForValid : Outcome ( Int, Int ) -> List String
summarizeWithinIntRangeForValid result =
    [ expectValid result
    ]


validP1WithinIntRangeForInvalid :
    ( Int, Int )
    -> ( Int, Int ) -- about range
validP1WithinIntRangeForInvalid value =
    value


validP2WithinIntRangeForInvalid :
    ( Int, Int )
    -> Outcome ( Int, Int ) -- about outcome
validP2WithinIntRangeForInvalid value =
    mapSecond (\y -> y + 1000000) value |> Valid


summarizeWithinIntRangeForInvalid : Outcome ( Int, Int ) -> List String
summarizeWithinIntRangeForInvalid result =
    [ expectWarningOutcomeRegex "within-int-range:\\(-\\d+,\\d+\\)" result
    ]



-- withinFloatRange


fuzzyV1WithinFloatRange : Fuzzer ( Float, Float )



-- should produce ( Float, Float )


fuzzyV1WithinFloatRange =
    tuple ( constant -1000, constant 1000 )


fuzzyV2WithinFloatRange : Fuzzer ( Float, Float )



-- should produce Outcome ( Float, Float )


fuzzyV2WithinFloatRange =
    oneOf
        [ tuple ( constant -500, constant 500 )
        , tuple ( constant 0, constant 500 )
        , tuple ( constant -1000, constant 0 )
        ]


validP1WithinFloatRangeForValid :
    ( Float, Float )
    -> ( Float, Float ) -- about range
validP1WithinFloatRangeForValid value =
    value


validP2WithinFloatRangeForValid :
    ( Float, Float )
    -> Outcome ( Float, Float ) -- about outcome
validP2WithinFloatRangeForValid value =
    Valid value


summarizeWithinFloatRangeForValid : Outcome ( Float, Float ) -> List String
summarizeWithinFloatRangeForValid result =
    [ expectValid result
    ]


validP1WithinFloatRangeForInvalid :
    ( Float, Float )
    -> ( Float, Float ) -- about range
validP1WithinFloatRangeForInvalid value =
    value


validP2WithinFloatRangeForInvalid :
    ( Float, Float )
    -> Outcome ( Float, Float ) -- about outcome
validP2WithinFloatRangeForInvalid value =
    mapSecond (\y -> y + 1000000) value |> Valid


summarizeWithinFloatRangeForInvalid : Outcome ( Float, Float ) -> List String
summarizeWithinFloatRangeForInvalid result =
    [ expectWarningOutcomeRegex "within-float-range:\\(-\\d+,\\d+\\)" result
    ]



-- listStrictlyLessThan


fuzzyV1ListStrictlyLessThan : Fuzzer Int



-- should produce Int


fuzzyV1ListStrictlyLessThan =
    intRange 20 50


fuzzyV2ListStrictlyLessThan : Fuzzer Int



-- should produce Outcome (List String)


fuzzyV2ListStrictlyLessThan =
    intRange 0 10


validP1ListStrictlyLessThanForValid :
    Int
    -> Int -- about size
validP1ListStrictlyLessThanForValid value =
    value


validP2ListStrictlyLessThanForValid :
    Int
    -> Outcome (List String) -- about outcome
validP2ListStrictlyLessThanForValid value =
    String.repeat value "a," |> String.split "," |> Valid


summarizeListStrictlyLessThanForValid : Outcome (List String) -> List String
summarizeListStrictlyLessThanForValid result =
    [ expectValid result
    ]


validP1ListStrictlyLessThanForInvalid :
    Int
    -> Int -- about size
validP1ListStrictlyLessThanForInvalid value =
    value


validP2ListStrictlyLessThanForInvalid :
    Int
    -> Outcome (List String) -- about outcome
validP2ListStrictlyLessThanForInvalid value =
    String.repeat (value + 100) "a," |> String.split "," |> Valid


summarizeListStrictlyLessThanForInvalid : Outcome (List String) -> List String
summarizeListStrictlyLessThanForInvalid result =
    [ expectWarning result
    ]



-- listStrictlyMoreThan


fuzzyV1ListStrictlyMoreThan : Fuzzer Int



-- should produce Int


fuzzyV1ListStrictlyMoreThan =
    intRange 1 5


fuzzyV2ListStrictlyMoreThan : Fuzzer Int



-- should produce Outcome (List String)


fuzzyV2ListStrictlyMoreThan =
    intRange 10 50


validP1ListStrictlyMoreThanForValid :
    Int
    -> Int -- about size
validP1ListStrictlyMoreThanForValid value =
    value


validP2ListStrictlyMoreThanForValid :
    Int
    -> Outcome (List String) -- about outcome
validP2ListStrictlyMoreThanForValid value =
    String.repeat value "a," |> String.split "," |> Valid


summarizeListStrictlyMoreThanForValid : Outcome (List String) -> List String
summarizeListStrictlyMoreThanForValid result =
    [ expectValid result
    ]


validP1ListStrictlyMoreThanForInvalid :
    Int
    -> Int -- about size
validP1ListStrictlyMoreThanForInvalid value =
    value + 10


validP2ListStrictlyMoreThanForInvalid :
    Int
    -> Outcome (List String) -- about outcome
validP2ListStrictlyMoreThanForInvalid value =
    String.repeat 2 "a," |> String.split "," |> Valid


summarizeListStrictlyMoreThanForInvalid : Outcome (List String) -> List String
summarizeListStrictlyMoreThanForInvalid result =
    [ expectWarning result
    ]



-- matchAbsoluteUrl


fuzzyV1MatchAbsoluteUrl : Fuzzer Int



-- should produce Outcome String


fuzzyV1MatchAbsoluteUrl =
    intRange 1 30


validP1MatchAbsoluteUrlForValid :
    Int
    -> Outcome String -- about outcome
validP1MatchAbsoluteUrlForValid value =
    "http://a" ++ String.repeat value "/b" |> Valid


summarizeMatchAbsoluteUrlForValid : Outcome String -> List String
summarizeMatchAbsoluteUrlForValid result =
    [ expectValid result
    ]


validP1MatchAbsoluteUrlForInvalid :
    Int
    -> Outcome String -- about outcome
validP1MatchAbsoluteUrlForInvalid value =
    "ssh://" ++ String.repeat value "/b" |> Valid


summarizeMatchAbsoluteUrlForInvalid : Outcome String -> List String
summarizeMatchAbsoluteUrlForInvalid result =
    [ expectWarning result
    ]



-- matchEnum


fuzzyV1MatchEnum : Fuzzer (List String)



-- should produce List String


fuzzyV1MatchEnum =
    oneOf
        [ constant [ "alpha", "bravo", "charlie", "delta", "echo", "fox", "golf", "hotel", "i" ]
        , constant [ "alpha", "bravo", "charlie", "delta", "echo", "fox", "india" ]
        , constant [ "alpha", "bravo", "charlie", "delta", "echo", "fox", "zulu" ]
        ]


fuzzyV2MatchEnum : Fuzzer String



-- should produce Outcome String


fuzzyV2MatchEnum =
    oneOf
        [ constant "alpha"
        , constant "bravo"
        , constant "charlie"
        ]


validP1MatchEnumForValid :
    List String
    -> List String -- about enum
validP1MatchEnumForValid value =
    value


validP2MatchEnumForValid :
    String
    -> Outcome String -- about outcome
validP2MatchEnumForValid value =
    Valid value


summarizeMatchEnumForValid : Outcome String -> List String
summarizeMatchEnumForValid result =
    [ expectValid result
    ]


validP1MatchEnumForInvalid :
    List String
    -> List String -- about enum
validP1MatchEnumForInvalid value =
    value


validP2MatchEnumForInvalid :
    String
    -> Outcome String -- about outcome
validP2MatchEnumForInvalid value =
    Valid "oscar"


summarizeMatchEnumForInvalid : Outcome String -> List String
summarizeMatchEnumForInvalid result =
    [ expectWarning result
    ]



-- matchCompactUri


fuzzyV1MatchCompactUri : Fuzzer String



-- should produce Outcome String


fuzzyV1MatchCompactUri =
    oneOf
        [ constant "uri:a"
        , constant "uri:a/b"
        , constant "uri:a/b123.com"
        , constant "uri:req?a=b"
        , constant "uri:12-56"
        ]


validP1MatchCompactUriForValid :
    String
    -> Outcome String -- about outcome
validP1MatchCompactUriForValid value =
    Valid value


summarizeMatchCompactUriForValid : Outcome String -> List String
summarizeMatchCompactUriForValid result =
    [ expectValid result
    ]


validP1MatchCompactUriForInvalid :
    String
    -> Outcome String -- about outcome
validP1MatchCompactUriForInvalid value =
    Valid ("1234567890123456789" ++ value)


summarizeMatchCompactUriForInvalid : Outcome String -> List String
summarizeMatchCompactUriForInvalid result =
    [ expectWarning result
    ]



-- stringStartsWith


fuzzyV1StringStartsWith : Fuzzer Int



-- should produce String


fuzzyV1StringStartsWith =
    intRange 3 5


fuzzyV2StringStartsWith : Fuzzer String



-- should produce Outcome String


fuzzyV2StringStartsWith =
    string


validP1StringStartsWithForValid :
    Int
    -> String -- about prefix
validP1StringStartsWithForValid value =
    String.repeat value "AB"


validP2StringStartsWithForValid :
    String
    -> Outcome String -- about outcome
validP2StringStartsWithForValid value =
    Valid (String.repeat 7 "AB" ++ value)


summarizeStringStartsWithForValid : Outcome String -> List String
summarizeStringStartsWithForValid result =
    [ expectValid result
    ]


validP1StringStartsWithForInvalid :
    Int
    -> String -- about prefix
validP1StringStartsWithForInvalid value =
    String.repeat value "AB"


validP2StringStartsWithForInvalid :
    String
    -> Outcome String -- about outcome
validP2StringStartsWithForInvalid value =
    Valid value


summarizeStringStartsWithForInvalid : Outcome String -> List String
summarizeStringStartsWithForInvalid result =
    [ expectWarning result
    ]



-- withinStringCharsRange


fuzzyV1WithinStringCharsRange : Fuzzer Int



-- should produce ( Int, Int )


fuzzyV1WithinStringCharsRange =
    intRange 50 100


fuzzyV2WithinStringCharsRange : Fuzzer Int



-- should produce Outcome String


fuzzyV2WithinStringCharsRange =
    intRange 20 40


validP1WithinStringCharsRangeForValid :
    Int
    -> ( Int, Int ) -- about range
validP1WithinStringCharsRangeForValid value =
    ( value, value + 200 )


validP2WithinStringCharsRangeForValid :
    Int
    -> Outcome String -- about outcome
validP2WithinStringCharsRangeForValid value =
    String.repeat (value + 100) "A" |> Valid


summarizeWithinStringCharsRangeForValid : Outcome String -> List String
summarizeWithinStringCharsRangeForValid result =
    [ expectValid result
    ]


validP1WithinStringCharsRangeForInvalid :
    Int
    -> ( Int, Int ) -- about range
validP1WithinStringCharsRangeForInvalid value =
    ( value, value + 200 )


validP2WithinStringCharsRangeForInvalid :
    Int
    -> Outcome String -- about outcome
validP2WithinStringCharsRangeForInvalid value =
    String.repeat value "A" |> Valid


summarizeWithinStringCharsRangeForInvalid : Outcome String -> List String
summarizeWithinStringCharsRangeForInvalid result =
    [ expectWarningOutcomeRegex "within-string-chars-range:\\(\\d+,\\d+\\)" result
    ]
