module Bubblegum.Entity.Validation
    exposing
        ( asBool
        , asFloat
        , asFloatRange
        , asFloatTuple
        , asInt
        , asIntRange
        , asIntTuple
        , asSingle
        , asTuple
        , asUnique
        , listEqual
        , listLessThan
        , listMoreThan
        , listStrictlyLessThan
        , listStrictlyMoreThan
        , matchAbsoluteUrl
        , matchCompactUri
        , matchEnum
        , matchNormalizedString
        , matchRegex
        , stringContains
        , stringEndsWith
        , stringStartsWith
        , withinFloatRange
        , withinIntRange
        , withinListStringCharsRange
        , withinStringCharsRange
        )

{-| Setting key

@docs Model

-}

import Bubblegum.Entity.Outcome as Outcome exposing (Outcome(..))
import List
import Regex
import Set
import Tuple exposing (first, second)


asSingle : Outcome (List String) -> Outcome String
asSingle outcome =
    Outcome.check (matchListSize 1) "unsatisfied-constraint:single" outcome |> Outcome.map onlyOne


asTuple : Outcome ( List String, List String ) -> Outcome ( String, String )
asTuple outcome =
    Outcome.check (\o -> (first o |> matchListSize 1) && (second o |> matchListSize 1)) "unsatisfied-constraint:tuple" outcome |> Outcome.map onlyTuple


listEqual : Int -> Outcome (List String) -> Outcome (List String)
listEqual size outcome =
    Outcome.check (matchListSize size) ("unsatisfied-constraint:list-equal-" ++ toString size) outcome


listMoreThan : Int -> Outcome (List String) -> Outcome (List String)
listMoreThan size outcome =
    Outcome.check (helperMoreThan size) ("unsatisfied-constraint:list-more-than-" ++ toString size) outcome


listStrictlyMoreThan : Int -> Outcome (List String) -> Outcome (List String)
listStrictlyMoreThan size outcome =
    Outcome.check (helperStrictlyMoreThan size) ("unsatisfied-constraint:list-strictly-more-than-" ++ toString size) outcome


listLessThan : Int -> Outcome (List String) -> Outcome (List String)
listLessThan size outcome =
    Outcome.check (helperLessThan size) ("unsatisfied-constraint:list-less-than-" ++ toString size) outcome


listStrictlyLessThan : Int -> Outcome (List String) -> Outcome (List String)
listStrictlyLessThan size outcome =
    Outcome.check (helperStrictlyLessThan size) ("unsatisfied-constraint:list-strictly-less-than-" ++ toString size) outcome


asUnique : Outcome (List String) -> Outcome (List String)
asUnique outcome =
    Outcome.map (\list -> Set.fromList list |> Set.toList) outcome


asInt : Outcome String -> Outcome Int
asInt outcome =
    Outcome.check isInt "unsatisfied-constraint:int" outcome |> Outcome.map intOrZero


asFloat : Outcome String -> Outcome Float
asFloat outcome =
    Outcome.check isFloat "unsatisfied-constraint:float" outcome |> Outcome.map floatOrZero


asBool : Outcome String -> Outcome Bool
asBool outcome =
    Outcome.check isBool "unsatisfied-constraint:bool" outcome |> Outcome.map stringToBool


intMoreThan : Int -> Outcome Int -> Outcome Int
intMoreThan limit outcome =
    Outcome.check (\v -> v >= limit) ("unsatisfied-constraint:int-more-than-" ++ toString limit) outcome


intStrictlyMoreThan : Int -> Outcome Int -> Outcome Int
intStrictlyMoreThan limit outcome =
    Outcome.check (\v -> v > limit) ("unsatisfied-constraint:int-strictly-more-than-" ++ toString limit) outcome


intLessThan : Int -> Outcome Int -> Outcome Int
intLessThan limit outcome =
    Outcome.check (\v -> v <= limit) ("unsatisfied-constraint:int-less-than-" ++ toString limit) outcome


intStrictlyLessThan : Int -> Outcome Int -> Outcome Int
intStrictlyLessThan limit outcome =
    Outcome.check (\v -> v < limit) ("unsatisfied-constraint:int-strictly-less-than-" ++ toString limit) outcome


floatMoreThan : Float -> Outcome Float -> Outcome Float
floatMoreThan limit outcome =
    Outcome.check (\v -> v >= limit) ("unsatisfied-constraint:float-more-than-" ++ toString limit) outcome


floatStrictlyMoreThan : Float -> Outcome Float -> Outcome Float
floatStrictlyMoreThan limit outcome =
    Outcome.check (\v -> v > limit) ("unsatisfied-constraint:float-strictly-more-than-" ++ toString limit) outcome


floatLessThan : Float -> Outcome Float -> Outcome Float
floatLessThan limit outcome =
    Outcome.check (\v -> v <= limit) ("unsatisfied-constraint:float-less-than-" ++ toString limit) outcome


floatStrictlyLessThan : Float -> Outcome Float -> Outcome Float
floatStrictlyLessThan limit outcome =
    Outcome.check (\v -> v < limit) ("unsatisfied-constraint:float-strictly-less-than-" ++ toString limit) outcome


matchEnum : List String -> Outcome String -> Outcome String
matchEnum enum outcome =
    Outcome.check (\v -> List.member v enum) "unsatisfied-constraint:enum-match" outcome


stringStartsWith : String -> Outcome String -> Outcome String
stringStartsWith prefix outcome =
    Outcome.check (\v -> String.startsWith prefix v) ("unsatisfied-constraint:starts-with:" ++ prefix) outcome


stringEndsWith : String -> Outcome String -> Outcome String
stringEndsWith suffix outcome =
    Outcome.check (\v -> String.endsWith suffix v) ("unsatisfied-constraint:ends-with:" ++ suffix) outcome


stringContains : String -> Outcome String -> Outcome String
stringContains str outcome =
    Outcome.check (\v -> String.contains str v) ("unsatisfied-constraint:contains:" ++ str) outcome


matchNormalizedString : Outcome String -> Outcome String
matchNormalizedString outcome =
    Outcome.check (\v -> String.contains "\n" v) "unsatisfied-constraint:normalized-string" outcome


matchRegex : String -> Outcome String -> Outcome String
matchRegex regExp outcome =
    let
        re =
            "^" ++ regExp ++ "$" |> Regex.regex
    in
    matchNormalizedString outcome |> Outcome.check (\v -> Regex.contains re v) "unsatisfied-constraint:regex"



-- https://mathiasbynens.be/demo/url-regex
-- based on regex from @stephenhay which mostly pass


matchAbsoluteUrl : Outcome String -> Outcome String
matchAbsoluteUrl outcome =
    let
        re =
            Regex.regex "^https?://[^\\s/$.?#].[^\\s]*$"
    in
    matchNormalizedString outcome |> Outcome.check (\v -> Regex.contains re v) "unsatisfied-constraint:absolute-url"



-- prefix should not exceed 15 chars


matchCompactUri : Outcome String -> Outcome String
matchCompactUri outcome =
    let
        re =
            Regex.regex "^[a-z][a-z0-9_.-]{1,15}:\\w[^\\s]*$"
    in
    matchNormalizedString outcome |> Outcome.check (\v -> Regex.contains re v) "unsatisfied-constraint:compact-uri"


asIntTuple : Outcome ( String, String ) -> Outcome ( Int, Int )
asIntTuple outcome =
    Outcome.check (\t -> (first t |> isInt) && (second t |> isInt)) "unsatisfied-constraint:int-tuple" outcome
        |> Outcome.map (\t -> ( first t |> intOrZero, second t |> intOrZero ))


asFloatTuple : Outcome ( String, String ) -> Outcome ( Float, Float )
asFloatTuple outcome =
    Outcome.check (\t -> (first t |> isFloat) && (second t |> isFloat)) "unsatisfied-constraint:float-tuple" outcome
        |> Outcome.map (\t -> ( first t |> floatOrZero, second t |> floatOrZero ))


asIntRange : Outcome ( Int, Int ) -> Outcome ( Int, Int )
asIntRange outcome =
    Outcome.check (\t -> first t < second t) "unsatisfied-constraint:int-range" outcome


asFloatRange : Outcome ( Float, Float ) -> Outcome ( Float, Float )
asFloatRange outcome =
    Outcome.check (\t -> first t < second t) "unsatisfied-constraint:float-range" outcome


withinIntRange : ( Int, Int ) -> Outcome ( Int, Int ) -> Outcome ( Int, Int )
withinIntRange range outcome =
    Outcome.check (\t -> (first t >= first range) && (second t < second range)) ("unsatisfied-constraint:within-int-range:" ++ toString range) outcome


withinFloatRange : ( Float, Float ) -> Outcome ( Float, Float ) -> Outcome ( Float, Float )
withinFloatRange range outcome =
    Outcome.check (\t -> (first t >= first range) && (second t < second range)) ("unsatisfied-constraint:within-float-range:" ++ toString range) outcome


withinStringCharsRange : ( Int, Int ) -> Outcome String -> Outcome String
withinStringCharsRange range outcome =
    Outcome.check (helperCharsRange range) ("unsatisfied-constraint:within-string-chars-range:" ++ toString range) outcome


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
