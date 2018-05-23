module AttributeTests exposing (..)

{-| Unit tests for testing the Bubblegum.Entity.Attribute
    
-}
import Test exposing (..)


suite : Test
suite =
    describe "The Attribute module"
        [ describe "Widget.view"
            [

                fuzz fuzzyContentId "Correct settings for The unique id of the content" <|
                \value -> viewWidgetWithState (withStateContentId value)
                    |> findComponent selectorsContentId

             ]
        ]
