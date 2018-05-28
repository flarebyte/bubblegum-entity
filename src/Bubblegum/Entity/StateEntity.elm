module Bubblegum.Entity.StateEntity exposing (Model, asAttributesIn, setAttributes)

{-| A state entity represents the state that could be applied to a widget

@docs Model, setAttributes, asAttributesIn

-}

import Bubblegum.Entity.Attribute as Attribute


{-| The core representation of state entity is mostly a list of attributes.
-}
type alias Model =
    { attributes : List Attribute.Model
    }


{-| Assign attributes to an entity
-}
setAttributes : List Attribute.Model -> Model -> Model
setAttributes attributes model =
    { model | attributes = attributes }


{-| Assign attributes to an entity
-}
asAttributesIn : Model -> List Attribute.Model -> Model
asAttributesIn =
    flip setAttributes
