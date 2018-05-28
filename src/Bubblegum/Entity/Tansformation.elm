module Bubblegum.Entity.Transformation
    exposing
        ( addStringPrefix
        , addStringSuffix
        )

{-| List of functions that can applied to an Outcome  

@docs addStringPrefix, addStringSuffix

-}

import Bubblegum.Entity.Outcome as Outcome exposing (Outcome(..))

{-| Apply a string prefix to an outcome
-}
addStringPrefix : String -> Outcome String -> Outcome String
addStringPrefix prefix outcome =
    Outcome.map (\v -> prefix ++ v) outcome

{-| Apply a string suffix to an outcome
-}
addStringSuffix : String -> Outcome String -> Outcome String
addStringSuffix suffix outcome =
    Outcome.map (\v -> v ++ suffix) outcome
