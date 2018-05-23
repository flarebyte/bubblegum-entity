module Bubblegum.Entity.Outcome exposing (..)

{-| Setting key

@docs Model

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

        ( Valid a, None ) ->
            None

        ( None, Valid b ) ->
            None

        ( Warning msga, Warning msgb ) ->
            Warning (msga ++ msgb)

        ( Warning msg, _ ) ->
            Warning msg

        ( _, Warning msg ) ->
            Warning msg


{-| -}
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


{-| -}
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


fromMaybe : Maybe a -> Outcome a
fromMaybe maybe =
    case maybe of
        Just v ->
            Valid v

        Nothing ->
            None


toMaybe : Outcome a -> Maybe a
toMaybe outcome =
    case outcome of
        None ->
            Nothing

        Warning msg ->
            Nothing

        Valid value ->
            Just value


isValid : Outcome a -> Bool
isValid outcome =
    case outcome of
        Valid v ->
            True

        _ ->
            False


isNone : Outcome a -> Bool
isNone outcome =
    case outcome of
        None ->
            True

        _ ->
            False


isWarning : Outcome a -> Bool
isWarning outcome =
    case outcome of
        Warning w ->
            True

        _ ->
            False
