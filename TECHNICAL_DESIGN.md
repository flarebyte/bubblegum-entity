# Technical Design

The TextArea widget should eventually be part of a suite of widgets for the Bubblegum Document Suite.

## Overview of Bubblegum Document Suite

The Bubblegum Document Suite should make it easy to create structured documents that satisfy a schema.

### Audience

The Bubblegum Document Suite should be useful for rapid application development of document oriented applications.
The document creators will be expected to be a small group of trusted users that know each other well enough.

This should be ideal for small teams of 2 to 10 people either working in the same company or part of the same creative community.

Most of the code needed to support the suite will be open-sourced, but it is expected that most communities will want to add some customizations and enhancements, especially if they deploy their solution to the cloud.

A special effort will be made to cater for the need of [Creative Commons](https://creativecommons.org/) and other open source communities who want to use this suite to create shared documents.

The audience is expected to be international and best effort should be made to make the documents and the tools [accessible](https://www.w3.org/standards/webdesign/accessibility).

The users should be able to use mobile phones, tablets, or desktops.  

### Structured Document

The schema of the document and the user interface should be created by an administrator using the [UI Builder](https://github.com/flarebyte/bubblegum-ui-builder). Please note, that the UI Builder is not available yet.

The document could eventually be exported to a markdown document (pdf, ...), but the internal schema should give some constraints about the different headlines and sections that the document should have.

The main purpose of the schema is to guide the user in his writing rather than validating some fields. In other words, often the UI will warn the user about some possible issues with the document rather than preventing them.

The structure of the document should be able to evolve over time.

In order to foster collaboration, it should be easy to link documents together.

### Document format

A document should be able to be imported/exported as a file that can be easily saved on a local machine or in the cloud.
Each document should have a reference to a document schema which should be a file as well.
Document should be able to reference other documents.

The document file format should be compatible with [RDF](https://en.wikipedia.org/wiki/Resource_Description_Framework) and the default serialization should be [N-Triples](https://en.wikipedia.org/wiki/N-Triples). This should give the following benefits:

 * Rely on common data formats and exchange protocols on the Web.
 * Facilitate Automated reasoning systems.
 * Very flexible.

Using RDF instead of JSON is quite a gamble because it is technology that has limited developer support and understanding.
Part of the challenge will be to provide libraries in Elm that deal with triples and RDF.

RDF is simple on paper but picking up the right vocabularies for the job could be challenging. For this reason, we will create our own vocabulary and eventually link back these new terms to existing terms if any. In other words, we will postpone the details of the RDF mapping to a later date. In addition, for performance reasons and simplification, we will assume that the language is the same for the whole document and we will store all the values as strings.

### Widget settings

#### Adapter

Each widget requires a parameter "adapter" that allows to plug some [event handlers](https://www.w3schools.com/tags/ref_eventattributes.asp) such as oninput, onclick, etc ... depending what is relevant to the widget.

#### Settings

 * User settings are global settings that are relevant for all documents. For example the language of the user.
 * (Normal) Settings are used to configure the behaviour of the widget.

 There is a balance to strike between flexibility and simplicity:
 * Too many settings would make the widget slow and difficult to understand.
 * Too few settings will reduce the flexibility of the widget.
 * The widget should have a purpose and the settings should help toward achieving this goal.
 * We can't have a setting for every single html feature.
 * We should try to make our widget smarter, by trying to guess the lower level configuration.
 * To avoid to pollute the settings with too many options, many parts of the configuration will be hard coded. For example, that will lead to the translation of labels in many languages. 

Settings are mostly a list of attributes with each attribute:
 * having possibly an unique id that could be useful for serialization.
 * a key which is a compact uri (predicate) from the ui vocabulary.
 * One or more string values. Each value should be unique and the order should not matter. This would be the case if the value is the "object" part in the **subject predicate object** statement.
 * In some advanced cases, you could have a list of facets that would allow to represent more complex configurations.

#### State 

The state represent the content and the state of the widget. The same widget model can be used to represent different contents. For instance, you can have a widget "City" that is used several times in the same document.

Internally, the model for state is similar to the model for settings. However they have different types to make it easier to evolve these models in the future if required.


## Entity utility

### Purpose

### Code structure

#### Source

The source code is in the src/Bubblegum/Entity folder.

#### Unit tests

The unit test code is under the tests folder:

You can run the unit-test:
```
elm-test
```

#### Code generation

Code generation is usually not very developer friendly as it increases the level of abstraction. However, it is acually a good fit with strongly typed language like Elm. It helps with naming conventions and reduces the amount of boring repetitive tasks.
However, when this libary is more mature, we could decide to get rid of them, a bit like you would get rid of the scaffolding once the house is built. Still, they can be a helpful boost when building a different widget.

The code generators are written for Python 2.7 and do not require any dependencies. They work out of the box on Mac Os and probably on Linux. 

It is probably easier to understand how the generators work by looking at the files they are trying to produce.

The code for the python code generators is under the folder scripts.

You can run the generators:

```
make generate
``` 












