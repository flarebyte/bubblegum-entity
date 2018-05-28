module OutcomeTestData exposing (..)

{-| Unit tests for testing the Bubblegum.Entity.Outcome

-}
import Bubblegum.Entity.Outcome as Outcome exposing (..)

import FunctionTester exposing(..)
import Fuzz exposing (Fuzzer, int, list, string, intRange, constant, tuple)
import Regex as Regex exposing(regex)

expectValid: Outcome a -> String
expectValid outcome =
    if Outcome.isValid outcome then ok else "outcome should be Valid"

expectNone: Outcome a -> String
expectNone outcome =
    if Outcome.isNone outcome then ok else "outcome should be None"

expectWarning: Outcome a -> String
expectWarning outcome =
    if Outcome.isWarning outcome then ok else "outcome should be warning"


expectValidOutcomeString: String -> Outcome String -> String
expectValidOutcomeString term outcome =
    case outcome of
        Valid s ->
            if s == term then ok else s ++ " is not " ++ term
        None ->
            "should not be none"
        Warning s ->
            "should not be warning " ++ s

expectValidOutcomeRegex: String -> Outcome String -> String
expectValidOutcomeRegex term outcome =
    case outcome of
        Valid s ->
            if Regex.contains (regex term) s then ok else s ++ " does not match " ++ term
        None ->
            "should not be none"
        Warning s ->
            "should not be warning " ++ s

expectWarningOutcomeRegex: String -> Outcome String -> String
expectWarningOutcomeRegex term outcome =
    case outcome of
        Valid s ->
            "should not be valid " ++ s
        None ->
            "should not be none"
        Warning s ->
            if Regex.contains (regex term) s then ok else s ++ " does not match warning " ++ term
            
isNotEmpty: String -> Bool
isNotEmpty value =
    String.isEmpty value |> not

-- withDefault
fuzzyV1WithDefault : Fuzzer String -- should produce a
fuzzyV1WithDefault = string

fuzzyV2WithDefault : Fuzzer String -- should produce Outcome a
fuzzyV2WithDefault = string 


validP1WithDefaultForValid: String -> String
validP1WithDefaultForValid value =
    value

validP2WithDefaultForValid: String -> Outcome String
validP2WithDefaultForValid value =
    Valid "expected"
    
summarizeWithDefaultForValid: Outcome String -> List String
summarizeWithDefaultForValid result =
    [
        expectValid result
        , expectValidOutcomeString "expected" result
    ]


validP1WithDefaultForNone: String -> String
validP1WithDefaultForNone value =
    "default"

validP2WithDefaultForNone: String -> Outcome String
validP2WithDefaultForNone value =
    None
    
summarizeWithDefaultForNone: Outcome String -> List String
summarizeWithDefaultForNone result =
    [
        expectValid result
        , expectValidOutcomeString "default" result
    ]

-- map
fuzzyV1Map : Fuzzer Int -- should produce (a -> value)
fuzzyV1Map = constant 0

fuzzyV2Map : Fuzzer Int -- should produce Outcome a
fuzzyV2Map = int


validP1MapForValid: Int -> (Int -> String)
validP1MapForValid value =
    toString

validP2MapForValid: Int -> Outcome Int
validP2MapForValid value =
    Valid value

summarizeMapForValid: Outcome String -> List String
summarizeMapForValid result =
    [
        expectValid result
        , expectValidOutcomeRegex "[0-9]" result
    ]


validP1MapForNone: Int -> (Int -> String)
validP1MapForNone value =
    toString

validP2MapForNone: Int -> Outcome Int
validP2MapForNone value =
    None

summarizeMapForNone: Outcome value -> List String
summarizeMapForNone result =
    [
        expectNone result
        , ok
    ]


validP1MapForWarning: Int -> (Int -> String)
validP1MapForWarning value =
    toString

validP2MapForWarning: Int -> Outcome Int
validP2MapForWarning value =
    Warning "warning"

summarizeMapForWarning: Outcome value -> List String
summarizeMapForWarning result =
    [
        expectWarning result
        , ok
    ]

-- map2
fuzzyV1Map2 : Fuzzer Int -- should produce (a -> b -> value)
fuzzyV1Map2 = constant 0

fuzzyV2Map2 : Fuzzer Int -- should produce Outcome a
fuzzyV2Map2 = int

fuzzyV3Map2 : Fuzzer Int -- should produce Outcome b
fuzzyV3Map2 = int

addNumbers : Int -> Int -> String
addNumbers a b =
    a + b |> toString

validP1Map2ForValid: Int -> (Int -> Int -> String)
validP1Map2ForValid value =
    addNumbers

validP2Map2ForValid: Int -> Outcome Int
validP2Map2ForValid value =
    Valid value

validP3Map2ForValid: Int -> Outcome Int
validP3Map2ForValid value =
    Valid value

summarizeMap2ForValid: Outcome String -> List String
summarizeMap2ForValid result =
    [
        expectValid result
        , expectValidOutcomeRegex "[0-9]" result
    ]


validP1Map2ForNone:  Int -> (Int -> Int -> String)
validP1Map2ForNone value =
    addNumbers

validP2Map2ForNone: Int -> Outcome Int
validP2Map2ForNone value =
    None

validP3Map2ForNone: Int -> Outcome Int
validP3Map2ForNone value =
    Valid value

summarizeMap2ForNone: Outcome String -> List String
summarizeMap2ForNone result =
    [
        expectNone result
        , ok
    ]


validP1Map2ForWarning:  Int -> (Int -> Int -> String)
validP1Map2ForWarning value =
    addNumbers

validP2Map2ForWarning: Int -> Outcome Int
validP2Map2ForWarning value =
    Warning "warning"

validP3Map2ForWarning: Int -> Outcome Int
validP3Map2ForWarning value =
    Valid value

summarizeMap2ForWarning: Outcome String -> List String
summarizeMap2ForWarning result =
    [
        expectWarning result
        , ok
    ]

-- check
fuzzyV1Check : Fuzzer String -- should produce (a -> Bool)
fuzzyV1Check = constant ""

fuzzyV2Check : Fuzzer String -- should produce String
fuzzyV2Check = string

fuzzyV3Check : Fuzzer String -- should produce Outcome a
fuzzyV3Check = string


validP1CheckForValid: String -> (String -> Bool)
validP1CheckForValid value =
   isNotEmpty

validP2CheckForValid: String -> String
validP2CheckForValid value =
    value

validP3CheckForValid: String -> Outcome String
validP3CheckForValid value =
    Valid ("A" ++ value)

summarizeCheckForValid: Outcome String -> List String
summarizeCheckForValid result =
    [
         expectValid result
        , expectValidOutcomeRegex "[A-Za-z]+" result
    ]


validP1CheckForNone: String -> (String -> Bool)
validP1CheckForNone value =
    isNotEmpty

validP2CheckForNone: String -> String
validP2CheckForNone value =
    value

validP3CheckForNone: String -> Outcome String
validP3CheckForNone value =
    None

summarizeCheckForNone: Outcome a -> List String
summarizeCheckForNone result =
    [
        expectNone result
        , ok
    ]


validP1CheckForWarning: String -> (String -> Bool)
validP1CheckForWarning value =
    isNotEmpty

validP2CheckForWarning: String -> String
validP2CheckForWarning value =
    value

validP3CheckForWarning: String -> Outcome String
validP3CheckForWarning value =
    Warning value

summarizeCheckForWarning: Outcome a -> List String
summarizeCheckForWarning result =
    [
        expectWarning result
        , ok
    ]

validP1CheckForCheckFailed: String -> (String -> Bool)
validP1CheckForCheckFailed value =
    String.isEmpty

validP2CheckForCheckFailed: String -> String
validP2CheckForCheckFailed value =
    "warn" ++ value

validP3CheckForCheckFailed: String -> Outcome String
validP3CheckForCheckFailed value =
    Valid ("A" ++ value)

summarizeCheckForCheckFailed: Outcome String -> List String
summarizeCheckForCheckFailed result =
    [
        expectWarning result
        , expectWarningOutcomeRegex "warn" result
    ]

-- checkOrNone
fuzzyV1CheckOrNone : Fuzzer String -- should produce (a -> Bool)
fuzzyV1CheckOrNone = string

fuzzyV2CheckOrNone : Fuzzer String -- should produce Outcome a
fuzzyV2CheckOrNone = string


validP1CheckOrNoneForValid: String -> (String -> Bool) -- about checker
validP1CheckOrNoneForValid value =
    isNotEmpty

validP2CheckOrNoneForValid: String -> Outcome String -- about ra
validP2CheckOrNoneForValid value =
    Valid ("A" ++ value)

summarizeCheckOrNoneForValid: Outcome String -> List String
summarizeCheckOrNoneForValid result =
    [
         expectValid result
        , expectValidOutcomeRegex "[A-Za-z]+" result
    ]


validP1CheckOrNoneForCheckFailed: String -> (String -> Bool) -- about checker
validP1CheckOrNoneForCheckFailed value =
    String.isEmpty

validP2CheckOrNoneForCheckFailed: String -> Outcome String -- about ra
validP2CheckOrNoneForCheckFailed value =
    Valid ("A" ++ value)

summarizeCheckOrNoneForCheckFailed: Outcome String -> List String
summarizeCheckOrNoneForCheckFailed result =
    [
        expectNone result
        , ok
    ]


validP1CheckOrNoneForWarning: String -> (String -> Bool) -- about checker
validP1CheckOrNoneForWarning value =
    isNotEmpty

validP2CheckOrNoneForWarning: String -> Outcome String -- about ra
validP2CheckOrNoneForWarning value =
    Warning ("warn" ++ value)

summarizeCheckOrNoneForWarning: Outcome String -> List String
summarizeCheckOrNoneForWarning result =
    [
        expectWarning result
        , expectWarningOutcomeRegex "warn" result
    ]

-- trueMapToConstant
fuzzyV1TrueMapToConstant : Fuzzer String -- should produce a
fuzzyV1TrueMapToConstant = string

fuzzyV2TrueMapToConstant : Fuzzer Bool -- should produce Outcome Bool
fuzzyV2TrueMapToConstant = constant True


validP1TrueMapToConstantForTrue: String -> String -- about const
validP1TrueMapToConstantForTrue value =
    "constant" ++ value

validP2TrueMapToConstantForTrue: Bool -> Outcome Bool -- about outcome
validP2TrueMapToConstantForTrue value =
    Valid True

summarizeTrueMapToConstantForTrue: Outcome String -> List String
summarizeTrueMapToConstantForTrue result =
    [
        expectValid result
        , expectValidOutcomeRegex "constant" result
    ]


validP1TrueMapToConstantForFalse: String -> String -- about const
validP1TrueMapToConstantForFalse value =
    value

validP2TrueMapToConstantForFalse: Bool -> Outcome Bool -- about outcome
validP2TrueMapToConstantForFalse value =
    Valid False

summarizeTrueMapToConstantForFalse: Outcome String -> List String
summarizeTrueMapToConstantForFalse result =
    [
        expectNone result
        , ok
    ]

-- or
fuzzyV1Or : Fuzzer String -- should produce Outcome a
fuzzyV1Or = string

fuzzyV2Or : Fuzzer String -- should produce Outcome a
fuzzyV2Or = string


validP1OrForFirst: String -> Outcome String -- about ma
validP1OrForFirst value =
    Valid ("first" ++ value)

validP2OrForFirst: String -> Outcome String -- about mb
validP2OrForFirst value =
    None

summarizeOrForFirst: Outcome String -> List String
summarizeOrForFirst result =
    [
        expectValid result
        , expectValidOutcomeRegex "first" result
    ]


validP1OrForSecond: String -> Outcome String -- about ma
validP1OrForSecond value =
    None

validP2OrForSecond: String -> Outcome String -- about mb
validP2OrForSecond value =
    Valid ("second" ++ value)

summarizeOrForSecond: Outcome String -> List String
summarizeOrForSecond result =
    [
        expectValid result
        , expectValidOutcomeRegex "second" result
    ]

-- fromMaybe
fuzzyV1FromMaybe : Fuzzer String -- should produce Maybe a
fuzzyV1FromMaybe = string


validP1FromMaybeForValid: String -> Maybe String -- about maybe
validP1FromMaybeForValid value =
    Just ("good" ++ value)

summarizeFromMaybeForValid: Outcome String -> List String
summarizeFromMaybeForValid result =
    [
        expectValid result
        , expectValidOutcomeRegex "good" result
    ]


validP1FromMaybeForNone: String -> Maybe String -- about maybe
validP1FromMaybeForNone value =
    Nothing

summarizeFromMaybeForNone: Outcome String -> List String
summarizeFromMaybeForNone result =
    [
        expectNone result
        , ok
    ]

-- toMaybe
fuzzyV1ToMaybe : Fuzzer String -- should produce Outcome a
fuzzyV1ToMaybe = string


validP1ToMaybeForJust: String -> Outcome String -- about outcome
validP1ToMaybeForJust value =
    Valid value

summarizeToMaybeForJust: Maybe String -> List String
summarizeToMaybeForJust result =
    [
        justOrErr "valid string missing" result
    ]

validP1ToMaybeForNothing: String -> Outcome String -- about outcome
validP1ToMaybeForNothing value =
    None

summarizeToMaybeForNothing: Maybe String -> List String
summarizeToMaybeForNothing result =
    [
        nothingOrErr "should be nothing" result
    ]
