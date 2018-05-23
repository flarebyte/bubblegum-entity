module Bubblegum.Entity.Transformation
    exposing
        ( addStringPrefix
        )

{-| Setting key

@docs Model

-}

import Bubblegum.Entity.Outcome as Outcome exposing (Outcome(..))
import List
import Regex
import Set
import Tuple exposing (first, second)


addStringPrefix : String -> Outcome String -> Outcome String
addStringPrefix prefix outcome =
    Outcome.map (\v -> prefix ++ v) outcome
