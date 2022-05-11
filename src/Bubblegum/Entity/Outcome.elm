module Bubblegum.Entity.Outcome exposing
    ( Outcome, withDefault, map, map2, or, fromMaybe, toMaybe
    , check, checkOrNone, trueMapToConstant, isValid, isNone, isWarning
    )

{-| An outcome is a type which borrows concepts from both Elm Maybe and Result


# Basics

@docs Outcome, withDefault, map, map2, or, fromMaybe, toMaybe


# Checking

@docs check, checkOrNone, trueMapToConstant, isValid, isNone, isWarning

-}


{-| Representation of an outcome which can be:

  - Valid: a valid value, similar to Just of Maybe.
  - None: no value, similar to Nothing of Maybe.
  - Warning: a warning message, similar to Err of Result.

-}
type Outcome value
    = Valid value
    | None
    | Warning String -- message


{-| If the outcome is `Valid` return the value. If the outcome is a `None` then
return a given default value. If the outcome is a `Warning` then propagate this warning.
-}
withDefault : a -> Outcome a -> Outcome a
withDefault def outcome =
    case outcome of
        Valid a ->
            Valid a

        None ->
            Valid def

        Warning msg ->
            Warning msg


{-| Apply a function to an outcome. If the result is `Valid`, it will be converted.
If the outcome is a `Warning` or `None`, the same value will propagate through.
map sqrt (Valid 4.0) == Valid 2.0
-}
map : (a -> value) -> Outcome a -> Outcome value
map func ra =
    case ra of
        Valid a ->
            Valid (func a)

        None ->
            None

        Warning msg ->
            Warning msg


{-| Apply a function to two outcomes, if both outcome are `Valid`. If not,
a valid outcome and a None will propagate None, a Warning will always propagate.
Two warnings will be merged
-}
map2 : (a -> b -> value) -> Outcome a -> Outcome b -> Outcome value
map2 func ra rb =
    case ( ra, rb ) of
        ( Valid a, Valid b ) ->
            Valid (func a b)

        ( None, None ) ->
            None

        ( Valid _, None ) ->
            None

        ( None, Valid _ ) ->
            None

        ( Warning msga, Warning msgb ) ->
            Warning (msga ++ msgb)

        ( Warning msg, _ ) ->
            Warning msg

        ( _, Warning msg ) ->
            Warning msg


{-| Check that a valid outcome verifies the criteria otherwise raise a warning

    check String.isEmpty "should not be empty string" (Valid "some text") -- Valid "some text"

    check String.isEmpty "should not be empty string" (Valid "") -- Warning "should not be empty string"

-}
check : (a -> Bool) -> String -> Outcome a -> Outcome a
check checker warnMsg ra =
    case ra of
        None ->
            None

        Warning msg ->
            Warning msg

        Valid value ->
            if checker value then
                Valid value

            else
                Warning warnMsg


{-| Check that a valid outcome verifies the criteria otherwise return none

    checkOrNone String.isEmpty (Valid "some text") -- Valid "some text"

    checkOrNone String.isEmpty (Valid "") -- None

-}
checkOrNone : (a -> Bool) -> Outcome a -> Outcome a
checkOrNone checker ra =
    case ra of
        None ->
            None

        Warning msg ->
            Warning msg

        Valid value ->
            if checker value then
                Valid value

            else
                None


{-| An outcome with a true value will produce a constant outcome

    trueMapToConstant [ "alpha" ] (Valid True) -- Valid ["alpha"]

    trueMapToConstant [ "alpha" ] (Valid False) -- None

-}
trueMapToConstant : a -> Outcome Bool -> Outcome a
trueMapToConstant const outcome =
    case outcome of
        None ->
            None

        Warning msg ->
            Warning msg

        Valid value ->
            if value then
                Valid const

            else
                None


{-| Like the boolean '||' this will return the first value that is positive ('Valid').

    or None (Valid "str") -- Valid "str"

-}
or : Outcome a -> Outcome a -> Outcome a
or ma mb =
    case ma of
        None ->
            mb

        Valid _ ->
            ma

        Warning msg ->
            Warning msg


{-| Convert a maybe to an outcome

    fromMaybe (Just "str") -- Valid "str"

    fromMaybe Nothing -- None

-}
fromMaybe : Maybe a -> Outcome a
fromMaybe maybe =
    case maybe of
        Just v ->
            Valid v

        Nothing ->
            None


{-| Convert an outcome to a maybe

    toMaybe (Valid "str") -- Just "str"

    toMaybe None -- Nothing

-}
toMaybe : Outcome a -> Maybe a
toMaybe outcome =
    case outcome of
        None ->
            Nothing

        Warning _ ->
            Nothing

        Valid value ->
            Just value


{-| Return true if the outcome is valid
-}
isValid : Outcome a -> Bool
isValid outcome =
    case outcome of
        Valid _ ->
            True

        _ ->
            False


{-| Return true if the outcome is none
-}
isNone : Outcome a -> Bool
isNone outcome =
    case outcome of
        None ->
            True

        _ ->
            False


{-| Return true if the outcome is none
-}
isWarning : Outcome a -> Bool
isWarning outcome =
    case outcome of
        Warning _ ->
            True

        _ ->
            False
