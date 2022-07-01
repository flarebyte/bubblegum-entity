# Technical Design

> Guide for the implementation, including detailed design, priorities,
> coding conventions, and testing

The TextArea widget should eventually be part of a suite of widgets for the
Bubblegum Document Suite.

## Code structure

-   **src**: Elm source code

-   **tests**: Unit and fuzz tests for Elm code

-   **script**: Folder for bash, python or ts-node scripts

-   **script/data**: Folder for data (YAML, JSON, ...) that should be
    manually edited

-   **script/schema**: Folder for JSON Schemas that are used to validate
    data and often available in vscode

-   **script/template**: Folder for handlebars templates used by the code
    generators

-   **generated**: Folder for generated code or data (YAML, JSON, ...)

-   **elm-stuff**: Temporary folder for building distribution code

-   **report**: Temporary folder for reporting; usually for continuous
    integration

-   **.github**: Folder for github pipeline

-   **.vscode**: Folder for visual code snippets

## Useful links

-   Introduction to [Elm](https://guide.elm-lang.org/)
