module TestData exposing (..)

{-| Unit tests for testing the Bubblegum.Entity.Attribute

    generated

-}
import Test exposing (..)
import Bubblegum.Entity.SettingsEntity as SettingsEntity
import Bubblegum.Entity.StateEntity as StateEntity
import Bubblegum.Entity.Attribute as Attribute
import Fuzz exposing (Fuzzer, int, list, string, intRange, constant)


attr: String -> String -> Attribute.Model
attr key value =
     { id = Nothing
    , key = key
    , facets = []
    , values = [value]
    }  

ipsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer mauris dolor, suscipit at nulla a, molestie scelerisque lectus. Nullam quis leo a felis auctor mollis ac vel turpis. Praesent eleifend ut sem et hendrerit. Vivamus sagittis tortor ipsum, eu suscipit lectus accumsan a. Vivamus elit ante, ornare vitae sem at, ornare eleifend nibh. Mauris venenatis nunc sit amet leo aliquam, in ornare quam vehicula. Morbi consequat ante sed felis semper egestas. Donec efficitur suscipit ipsum vitae ultrices. Quisque eget vehicula odio. Aliquam vitae posuere mauris. Nulla ac pulvinar felis. Integer odio libero, vulputate in erat in, tristique cursus erat."

createString: Int -> String
createString size  =
    if size > 500 then
        String.repeat size "A"
    else
        String.left size ipsum

type alias AB a b= {
    a: a
    , b: b
 }

ab: a -> b -> AB a b
ab a b = {
    a = a
    , b = b
 }


defaultAttributeModel: Attribute.Model
defaultAttributeModel =
    attr "key:default" "default value"

-- SetId
fuzzySetId : Fuzzer String
fuzzySetId = string 


validSetId: String -> AB (Maybe String) Attribute.Model
validSetId value =
    ab (Just value) defaultAttributeModel

expectedValidSetId: Attribute.Model
expectedValidSetId =
   defaultAttributeModel