# Bubblegum Entity Access

> Access to settings and states for widgets of the Bubblegum UI toolkit

[![Build Status](https://semaphoreci.com/api/v1/olih/bubblegum-entity/branches/master/badge.svg)](https://semaphoreci.com/olih/bubblegum-entity)

## Installing Elm packages

There is no dependency.

```
elm-app package install flarebyte/bubblegum-entity
```
## Model

### Attribute

An attribute represents a small piece of information such as a [Semantic triple](https://en.wikipedia.org/wiki/Semantic_triple).

```
attrLabel =
     { id = Just "id:1234"
    , key = "ui:label"
    , facets = ["blue"]
    , values = ["Some label"]
    }  

```

### Outcome

An outcome is a type which borrows concepts from both Elm Maybe and Result.

```
type Outcome value
    = Valid value
    | None
    | Warning String
```

### Settings

A settings entity represents some configuration that is applied to a widget.

```
 {
     attributes = [
         attr "ui:label" "some label"
         , attr "ui:font" "Arial"
     ]
 }

```

### State

A state entity is similar to settings but represents the live state that is applied to a widget.

```
 {
     attributes = [
         attr "ui:selection" "first item"
     ]
 }

```
### Validation

List of validations that can be applied to an outcome.

For most validations:

  - None will propagate as None.
  - Warning will propagate as Warning.
  - A failure to validate the outcome will produce a Warning.

## Technical design

See [Technical design](TECHNICAL_DESIGN.md)

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

Managed automatically by [Elm version rules](https://github.com/elm-lang/elm-package#version-rules).

## Authors

* **Olivier Huin** - *Initial work* - [olih](https://github.com/olih)

See also the list of [contributors](https://github.com/flarebyte/bubblegum-entity/graphs/contributors) who participated in this project.

## License

This project is licensed under the BSD 3-Clause License - see the [LICENSE.md](LICENSE) file for details
