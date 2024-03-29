module OutcomeTestHelper exposing (..)

{-| A few function to facilitate testing of outcomes
-}

import Bubblegum.Entity.Outcome as Outcome exposing (..)
import FunctionTester exposing (..)
import Regex


expectValid : Outcome a -> String
expectValid outcome =
    if Outcome.isValid outcome then
        ok

    else
        "outcome should be Valid"


expectNone : Outcome a -> String
expectNone outcome =
    if Outcome.isNone outcome then
        ok

    else
        "outcome should be None"


expectWarning : Outcome a -> String
expectWarning outcome =
    if Outcome.isWarning outcome then
        ok

    else
        "outcome should be warning"


expectValidOutcomeString : String -> Outcome String -> String
expectValidOutcomeString term outcome =
    case outcome of
        Valid s ->
            if s == term then
                ok

            else
                s ++ " is not " ++ term

        None ->
            "should not be none"

        Warning s ->
            "should not be warning " ++ s


expectValidOutcomeRegex : String -> Outcome String -> String
expectValidOutcomeRegex term outcome =
    case outcome of
        Valid s ->
            if Regex.contains (Maybe.withDefault Regex.never <| Regex.fromString term) s then
                ok

            else
                s ++ " does not match " ++ term

        None ->
            "should not be none"

        Warning s ->
            "should not be warning " ++ s


expectWarningOutcomeRegex : String -> Outcome a -> String
expectWarningOutcomeRegex term outcome =
    case outcome of
        Valid _ ->
            "should not be valid "

        None ->
            "should not be none"

        Warning s ->
            if Regex.contains (Maybe.withDefault Regex.never <| Regex.fromString term) s then
                ok

            else
                s ++ " does not match warning " ++ term
