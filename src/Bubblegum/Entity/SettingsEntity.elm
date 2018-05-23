module Bubblegum.Entity.SettingsEntity exposing (Model, asAttributesIn, setAttributes)

{-| Setting key

@docs Model

-}

import Bubblegum.Entity.Attribute as Attribute


{-| The core representation of a field.
-}
type alias Model =
    { attributes : List Attribute.Model
    }


setAttributes : List Attribute.Model -> Model -> Model
setAttributes attributes model =
    { model | attributes = attributes }


asAttributesIn : Model -> List Attribute.Model -> Model
asAttributesIn =
    flip setAttributes
