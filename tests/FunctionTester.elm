module FunctionTester exposing (..)

{-| Helper for testing functions
-}


ipsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer mauris dolor, suscipit at nulla a, molestie scelerisque lectus. Nullam quis leo a felis auctor mollis ac vel turpis. Praesent eleifend ut sem et hendrerit. Vivamus sagittis tortor ipsum, eu suscipit lectus accumsan a. Vivamus elit ante, ornare vitae sem at, ornare eleifend nibh. Mauris venenatis nunc sit amet leo aliquam, in ornare quam vehicula. Morbi consequat ante sed felis semper egestas. Donec efficitur suscipit ipsum vitae ultrices. Quisque eget vehicula odio. Aliquam vitae posuere mauris. Nulla ac pulvinar felis. Integer odio libero, vulputate in erat in, tristique cursus erat."


createString : Int -> String
createString size =
    if size > 500 then
        String.repeat size "A"

    else
        String.left size ipsum


ok =
    "OK"


ok1 =
    [ ok ]


ok2 =
    [ ok, ok ]


ok3 =
    [ ok, ok, ok ]


setOk : a -> String
setOk a =
    ok


justOrErr : String -> Maybe a -> String
justOrErr err maybe =
    Maybe.map setOk maybe |> Maybe.withDefault err


nothingOrErr : String -> Maybe a -> String
nothingOrErr err maybe =
    case maybe of
        Nothing ->
            ok

        Just a ->
            err


nonEmptyStringOrErr : String -> String -> String
nonEmptyStringOrErr err str =
    if String.isEmpty str then
        err

    else
        ok


atLeastOneStringOrErr : String -> List String -> String
atLeastOneStringOrErr err list =
    if List.isEmpty list then
        err

    else
        List.head list |> Maybe.withDefault "" |> nonEmptyStringOrErr err


withStringInListMatching : String -> List String -> String
withStringInListMatching search list =
    if List.member search list then
        ok

    else
        "list should contain " ++ search


withoutStringInListMatching : String -> List String -> String
withoutStringInListMatching search list =
    if List.member search list then
        "list should not contain " ++ search

    else
        ok


expectNoResult : Maybe a -> String
expectNoResult result =
    nothingOrErr "should not get any result" result


expectResult : Maybe a -> String
expectResult result =
    justOrErr "result is missing" result


expectEmptyList : List a -> String
expectEmptyList list =
    if List.isEmpty list then
        ok

    else
        "list should be empty"


expectNotEmptyList : List a -> String
expectNotEmptyList list =
    if List.isEmpty list then
        "list should be not empty"

    else
        ok
