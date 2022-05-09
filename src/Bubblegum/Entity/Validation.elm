module Bubblegum.Entity.Validation exposing
    ( asSingle, asTuple, asBool, asFloat, asInt, asIntTuple, asFloatTuple, asUnique
    , asIntRange, asFloatRange, withinIntRange, withinFloatRange
    , listEqual, listLessThan, listMoreThan, listStrictlyLessThan, listStrictlyMoreThan
    , matchAbsoluteUrl, matchCompactUri, matchEnum, matchNormalizedString, matchRegex, stringContains, stringStartsWith, stringEndsWith, withinListStringCharsRange, withinStringCharsRange
    )

{-| List of validations with implicit transformations that can be applied to an outcome

For most validations:

  - None will propagate as None.
  - Warning will propagate as Warning.
  - A failure to validate the outcome will produce a Warning.


## Simple conversion

@docs asSingle, asTuple, asBool, asFloat, asInt, asIntTuple, asFloatTuple, asUnique


## Range validation

@docs asIntRange, asFloatRange, withinIntRange, withinFloatRange


## List validation

@docs listEqual, listLessThan, listMoreThan, listStrictlyLessThan, listStrictlyMoreThan


## String validation

@docs matchAbsoluteUrl, matchCompactUri, matchEnum, matchNormalizedString, matchRegex, stringContains, stringStartsWith, stringEndsWith, withinListStringCharsRange, withinStringCharsRange

-}

import Bubblegum.Entity.Outcome as Outcome exposing (Outcome(..))
import List
import Regex
import Set
import Tuple exposing (first, second)


{-| Convert a list with only one string to a single string.

    Valid [ "alpha" ] |> asSingle -- Valid "alpha"

-}
asSingle : Outcome (List String) -> Outcome String
asSingle outcome =
    Outcome.check (matchListSize 1) "unsatisfied-constraint:single" outcome |> Outcome.map onlyOne


{-| Convert a tuple of singleton list to a tuple of String

    Valid ( [ "min" ], [ "max" ] ) |> asTuple -- Valid ("min", "max")

-}
asTuple : Outcome ( List String, List String ) -> Outcome ( String, String )
asTuple outcome =
    Outcome.check (\o -> (first o |> matchListSize 1) && (second o |> matchListSize 1)) "unsatisfied-constraint:tuple" outcome |> Outcome.map onlyTuple


{-| Ensure that the list equal a given size otherwise raise a warning

    Valid [ "alpha", "beta" ] |> listEqual 2 -- Valid ["alpha", "beta"]

-}
listEqual : Int -> Outcome (List String) -> Outcome (List String)
listEqual size outcome =
    Outcome.check (matchListSize size) ("unsatisfied-constraint:list-equal-" ++ toString size) outcome


{-| Ensure that the list equal or more than a given size otherwise raise a warning

    Valid [ "alpha", "beta" ] |> listMoreThan 2 -- Valid ["alpha", "beta"]

-}
listMoreThan : Int -> Outcome (List String) -> Outcome (List String)
listMoreThan size outcome =
    Outcome.check (helperMoreThan size) ("unsatisfied-constraint:list-more-than-" ++ toString size) outcome


{-| Ensure that the list is strictly more than a given size otherwise raise a warning

    Valid [ "alpha", "beta" ] |> listStrictlyMoreThan 1 -- Valid ["alpha", "beta"]

-}
listStrictlyMoreThan : Int -> Outcome (List String) -> Outcome (List String)
listStrictlyMoreThan size outcome =
    Outcome.check (helperStrictlyMoreThan size) ("unsatisfied-constraint:list-strictly-more-than-" ++ toString size) outcome


{-| Ensure that the list equal or less than a given size otherwise raise a warning

    Valid [ "alpha", "beta" ] |> listLessThan 2 -- Valid ["alpha", "beta"]

-}
listLessThan : Int -> Outcome (List String) -> Outcome (List String)
listLessThan size outcome =
    Outcome.check (helperLessThan size) ("unsatisfied-constraint:list-less-than-" ++ toString size) outcome


{-| Ensure that the list is strictly less than a given size otherwise raise a warning

    Valid [ "alpha", "beta" ] |> listStrictlyLessThan 3 -- Valid ["alpha", "beta"]

-}
listStrictlyLessThan : Int -> Outcome (List String) -> Outcome (List String)
listStrictlyLessThan size outcome =
    Outcome.check (helperStrictlyLessThan size) ("unsatisfied-constraint:list-strictly-less-than-" ++ toString size) outcome


{-| Enforce that the list to be unique

    Valid [ "alpha", "beta", "alpha" ] |> asUnique -- Valid ["alpha", "beta"]

-}
asUnique : Outcome (List String) -> Outcome (List String)
asUnique outcome =
    Outcome.map (\list -> Set.fromList list |> Set.toList) outcome


{-| Convert a String to an Int otherwise raise a warning

    Valid "12" |> asInt -- Valid 12

-}
asInt : Outcome String -> Outcome Int
asInt outcome =
    Outcome.check isInt "unsatisfied-constraint:int" outcome |> Outcome.map intOrZero


{-| Convert a String to a Float otherwise raise a warning

    Valid "12.3" |> asFloat -- Valid 12.3

-}
asFloat : Outcome String -> Outcome Float
asFloat outcome =
    Outcome.check isFloat "unsatisfied-constraint:float" outcome |> Outcome.map floatOrZero


{-| Convert a String to a Float otherwise raise a warning

    Valid "true" |> asBool -- Valid True

-}
asBool : Outcome String -> Outcome Bool
asBool outcome =
    Outcome.check isBool "unsatisfied-constraint:bool" outcome |> Outcome.map stringToBool


{-| Check that an int is equal or more than a given value otherwise raise a warning

    Valid 12 |> intMoreThan 12 -- Valid 12

-}
intMoreThan : Int -> Outcome Int -> Outcome Int
intMoreThan limit outcome =
    Outcome.check (\v -> v >= limit) ("unsatisfied-constraint:int-more-than-" ++ toString limit) outcome


{-| Check that an int is equal or more than a given value otherwise raise a warning

    Valid 12 |> intStrictlyMoreThan 5 -- Valid 12

-}
intStrictlyMoreThan : Int -> Outcome Int -> Outcome Int
intStrictlyMoreThan limit outcome =
    Outcome.check (\v -> v > limit) ("unsatisfied-constraint:int-strictly-more-than-" ++ toString limit) outcome


{-| Check that an int is equal or less than a given value otherwise raise a warning

    Valid 12 |> intLessThan 12 -- Valid 12

-}
intLessThan : Int -> Outcome Int -> Outcome Int
intLessThan limit outcome =
    Outcome.check (\v -> v <= limit) ("unsatisfied-constraint:int-less-than-" ++ toString limit) outcome


{-| Check that an int is strictly less than a given value otherwise raise a warning

    Valid 12 |> intStrictlyLessThan 20 -- Valid 12

-}
intStrictlyLessThan : Int -> Outcome Int -> Outcome Int
intStrictlyLessThan limit outcome =
    Outcome.check (\v -> v < limit) ("unsatisfied-constraint:int-strictly-less-than-" ++ toString limit) outcome


{-| Check that an int is equal or more than a given value otherwise raise a warning

    Valid 12.4 |> floatMoreThan 5.0 -- Valid 12.4

-}
floatMoreThan : Float -> Outcome Float -> Outcome Float
floatMoreThan limit outcome =
    Outcome.check (\v -> v >= limit) ("unsatisfied-constraint:float-more-than-" ++ toString limit) outcome


{-| Check that an int is strictly more than a given value otherwise raise a warning

    Valid 12.4 |> floatStrictlyMoreThan 5.3 -- Valid 12.4

-}
floatStrictlyMoreThan : Float -> Outcome Float -> Outcome Float
floatStrictlyMoreThan limit outcome =
    Outcome.check (\v -> v > limit) ("unsatisfied-constraint:float-strictly-more-than-" ++ toString limit) outcome


{-| Check that an int is equal or less than a given value otherwise raise a warning

    Valid 12.4 |> floatLessThan 12.4 -- Valid 12.4

-}
floatLessThan : Float -> Outcome Float -> Outcome Float
floatLessThan limit outcome =
    Outcome.check (\v -> v <= limit) ("unsatisfied-constraint:float-less-than-" ++ toString limit) outcome


{-| Check that an int is strictly less than a given value otherwise raise a warning

    Valid 12.4 |> floatStrictlyLessThan 20 -- Valid 12.4

-}
floatStrictlyLessThan : Float -> Outcome Float -> Outcome Float
floatStrictlyLessThan limit outcome =
    Outcome.check (\v -> v < limit) ("unsatisfied-constraint:float-strictly-less-than-" ++ toString limit) outcome


{-| Check that a string belong to an enumeration otherwise raise a warning

    Valid [ "alpha" ] |> matchEnum [ "beta", "alpha" ] -- Valid ["alpha"]

-}
matchEnum : List String -> Outcome String -> Outcome String
matchEnum enum outcome =
    Outcome.check (\v -> List.member v enum) "unsatisfied-constraint:enum-match" outcome


{-| Check that a string starts with a prefix otherwise raise a warning

    Valid [ "ui:label" ] |> stringStartsWith "ui:" -- Valid ["ui:label"]

-}
stringStartsWith : String -> Outcome String -> Outcome String
stringStartsWith prefix outcome =
    Outcome.check (\v -> String.startsWith prefix v) ("unsatisfied-constraint:starts-with:" ++ prefix) outcome


{-| Check that a string ends with a suffix otherwise raise a warning

    Valid [ "image.jpg" ] |> stringEndsWith ".jpg" -- Valid ["image.jpg"]

-}
stringEndsWith : String -> Outcome String -> Outcome String
stringEndsWith suffix outcome =
    Outcome.check (\v -> String.endsWith suffix v) ("unsatisfied-constraint:ends-with:" ++ suffix) outcome


{-| Check that a string contains a term otherwise raise a warning

    Valid [ "blue red green" ] |> stringContains "red" -- Valid ["blue red green"]

-}
stringContains : String -> Outcome String -> Outcome String
stringContains str outcome =
    Outcome.check (\v -> String.contains str v) ("unsatisfied-constraint:contains:" ++ str) outcome


{-| Check that a string is a [normalized string](https://www.w3.org/TR/xmlschema11-2/#normalizedString)

    Valid "some string" |> matchNormalizedString -- Valid "some string"

-}
matchNormalizedString : Outcome String -> Outcome String
matchNormalizedString outcome =
    Outcome.check (\v -> String.contains "\n" v |> not) "unsatisfied-constraint:normalized-string" outcome


{-| Check whether a string matches a regular expression otherwise raise a warning

    Valid "abc" |> matchRegex "[a-z]+" -- Valid "abc"

-}
matchRegex : String -> Outcome String -> Outcome String
matchRegex regExp outcome =
    let
        re =
            "^" ++ regExp ++ "$" |> Regex.regex
    in
    matchNormalizedString outcome |> Outcome.check (\v -> Regex.contains re v) "unsatisfied-constraint:regex"



-- https://mathiasbynens.be/demo/url-regex
-- based on regex from @stephenhay which mostly pass


{-| Check whether a string matches an absolute URL otherwise raise a warning

    Valid "http://bbc.co.uk" |> matchAbsoluteUrl -- Valid "http://bbc.co.uk"

-}
matchAbsoluteUrl : Outcome String -> Outcome String
matchAbsoluteUrl outcome =
    let
        re =
            Regex.regex "^https?://[^\\s/$.?#].[^\\s]*$"
    in
    matchNormalizedString outcome |> Outcome.check (\v -> Regex.contains re v) "unsatisfied-constraint:absolute-url"


{-| Check whether a string matches an absolute URL otherwise raise a warning.

    The prefix should not exceed 15 characters.

    Valid "uri:a/b001/c" |> matchCompactUri -- Valid "uri:a/b001/c"

-}
matchCompactUri : Outcome String -> Outcome String
matchCompactUri outcome =
    let
        re =
            Regex.regex "^[a-z][a-z0-9_.-]{1,15}:\\w[^\\s]*$"
    in
    matchNormalizedString outcome |> Outcome.check (\v -> Regex.contains re v) "unsatisfied-constraint:compact-uri"


{-| Convert a tuple of String to a tuple of Int otherwise raise a warning

    Valid ( "3", "5" ) |> asIntTuple -- Valid (3, 5)

-}
asIntTuple : Outcome ( String, String ) -> Outcome ( Int, Int )
asIntTuple outcome =
    Outcome.check (\t -> (first t |> isInt) && (second t |> isInt)) "unsatisfied-constraint:int-tuple" outcome
        |> Outcome.map (\t -> ( first t |> intOrZero, second t |> intOrZero ))


{-| Convert a tuple of String to a tuple of Float otherwise raise a warning

    Valid ( "3.5", "5.5" ) |> asFloatTuple -- Valid (3.5, 5.5)

-}
asFloatTuple : Outcome ( String, String ) -> Outcome ( Float, Float )
asFloatTuple outcome =
    Outcome.check (\t -> (first t |> isFloat) && (second t |> isFloat)) "unsatisfied-constraint:float-tuple" outcome
        |> Outcome.map (\t -> ( first t |> floatOrZero, second t |> floatOrZero ))


{-| Check that first value is strictly less than the second otherwise raise a warning

    Valid ( 3, 5 ) |> asIntRange -- Valid (3, 5)

-}
asIntRange : Outcome ( Int, Int ) -> Outcome ( Int, Int )
asIntRange outcome =
    Outcome.check (\t -> first t < second t) "unsatisfied-constraint:int-range" outcome


{-| Check that first value is strictly less than the second otherwise raise a warning

    Valid ( 3.5, 5.5 ) |> asFloatRange -- Valid (3.5, 5.5)

-}
asFloatRange : Outcome ( Float, Float ) -> Outcome ( Float, Float )
asFloatRange outcome =
    Outcome.check (\t -> first t < second t) "unsatisfied-constraint:float-range" outcome


{-| Check a tuple of Int is within the range of a given range otherwise raise a warning

    Valid ( 3, 5 ) |> withinIntRange ( 2, 7 ) -- Valid (3, 5)

-}
withinIntRange : ( Int, Int ) -> Outcome ( Int, Int ) -> Outcome ( Int, Int )
withinIntRange range outcome =
    Outcome.check (\t -> (first t >= first range) && (second t < second range)) ("unsatisfied-constraint:within-int-range:" ++ toString range) outcome


{-| Check a tuple of Float is within the range of a given range otherwise raise a warning

    Valid ( 3.5, 5.2 ) |> withinFloatRange ( 2.1, 7.2 ) -- Valid (3.5, 5.2)

-}
withinFloatRange : ( Float, Float ) -> Outcome ( Float, Float ) -> Outcome ( Float, Float )
withinFloatRange range outcome =
    Outcome.check (\t -> (first t >= first range) && (second t < second range)) ("unsatisfied-constraint:within-float-range:" ++ toString range) outcome


{-| Check that a string number of characters is within a range otherwise raise a warning

    Valid "abcd" |> withinStringCharsRange ( 2, 7 ) -- Valid "abcd"

-}
withinStringCharsRange : ( Int, Int ) -> Outcome String -> Outcome String
withinStringCharsRange range outcome =
    Outcome.check (helperCharsRange range) ("unsatisfied-constraint:within-string-chars-range:" ++ toString range) outcome


{-| Check that all the strings' number of characters are within a range otherwise raise a warning

    Valid [ "abc", "abcd" ] |> withinListStringCharsRange ( 2, 7 ) -- Valid "abcd"

-}
withinListStringCharsRange : ( Int, Int ) -> Outcome (List String) -> Outcome (List String)
withinListStringCharsRange range outcome =
    Outcome.check (\list -> List.all (helperCharsRange range) list) ("unsatisfied-constraint:within-list-string-chars-range:" ++ toString range) outcome



-- private


helperCharsRange : ( Int, Int ) -> String -> Bool
helperCharsRange range str =
    (String.length str >= first range) && (String.length str < second range)


matchListSize : Int -> List String -> Bool
matchListSize expected list =
    List.length list == expected


helperMoreThan : Int -> List String -> Bool
helperMoreThan expected list =
    List.length list >= expected


helperStrictlyMoreThan : Int -> List String -> Bool
helperStrictlyMoreThan expected list =
    List.length list > expected


helperLessThan : Int -> List String -> Bool
helperLessThan expected list =
    List.length list <= expected


helperStrictlyLessThan : Int -> List String -> Bool
helperStrictlyLessThan expected list =
    List.length list < expected


onlyOne : List String -> String
onlyOne list =
    List.head list |> Maybe.withDefault "should-never-happen"


onlyTuple : ( List String, List String ) -> ( String, String )
onlyTuple listTuple =
    case listTuple of
        ( a :: [], b :: [] ) ->
            ( a, b )

        _ ->
            ( "should-never-happen", "should-never-happen" )


isInt : String -> Bool
isInt value =
    case String.toInt value of
        Ok _ ->
            True

        Err _ ->
            False


isFloat : String -> Bool
isFloat value =
    case String.toFloat value of
        Ok _ ->
            True

        Err _ ->
            False


intOrZero : String -> Int
intOrZero value =
    String.toInt value |> Result.withDefault 0


floatOrZero : String -> Float
floatOrZero value =
    String.toFloat value |> Result.withDefault 0


stringToBool : String -> Bool
stringToBool value =
    value == "true"



-- https://www.w3.org/TR/xmlschema-2/#boolean


isBool : String -> Bool
isBool value =
    List.member (String.toLower value) [ "true", "false" ]
