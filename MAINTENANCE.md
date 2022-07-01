# Maintenance of the code

## Overall workflow

The typical developer workflow goes as follow:

| Mode                   | Code analysis | Testing                          | Building   | Publishing |
| ---------------------- | ------------- | -------------------------------- | ---------- | ---------- |
| Checking               | make analyze  | make test                        | make build | make ready |
| Fixing                 | Fix the code  | Update dependencies and make doc |            |            |
| Continuous integration | make build    |                                  |            |            |

## Commands

### Run GitHub Actions locally

> Run GitHub Actions inside a docker container

**Motivation:** Test GitHub Actions locally

**When to use it:** When changing github actions

**Run:** `act`

**From package:** [act](https://github.com/nektos/act) of
[brew](https://docs.brew.sh/) : Run GitHub Actions locally

***

### Build the library

> Transpile all the Elm source code to javascript

**Motivation:** The code has to be build before been published

**When to use it:** Before building

**Run:** `make build`

**From package:**
[makefile](https://opensource.com/article/18/8/what-how-makefile) of
[brew](https://docs.brew.sh/) : Build management

***

### Generate the documentation

> Generate the markdown documentation for the Elm project

**Motivation:** Good documentation is essential for developer experience

**When to use it:** Before publishing

**Run:** `make doc`

**From package:**
[makefile](https://opensource.com/article/18/8/what-how-makefile) of
[brew](https://docs.brew.sh/) : Build management

***

### Preview the documentation

> Generate the markdown documentation for the Elm project

**Motivation:** Good documentation is essential for developer experience

**When to use it:** Before publishing

**Run:** `make preview-doc`

**From package:**
[makefile](https://opensource.com/article/18/8/what-how-makefile) of
[brew](https://docs.brew.sh/) : Build management

***

### Update github repository

> Enable useful features for the github project repository

**Motivation:** Create consistent settings

**When to use it:** After creating

**Run:** `make github`

**From package:** [gh](https://cli.github.com/) of
[brew](https://docs.brew.sh/) : GitHub CLI brings GitHub to your terminal

***

### Static code analysis

> Find problems in Elm code

**Motivation:** Make the code more consistent and avoid bugs

**When to use it:** Before compilation

**Run:** `make analyze`

**From package:**
[makefile](https://opensource.com/article/18/8/what-how-makefile) of
[brew](https://docs.brew.sh/) : Build management

***

### Beautify Elm source code

> Formats Elm source code according to a standard set of rules based on
> the official Elm Style Guide

**Motivation:** Make the code more consistent and avoid bugs

**When to use it:** Before compilation

**Run:** `make beautify`

**From package:**
[makefile](https://opensource.com/article/18/8/what-how-makefile) of
[brew](https://docs.brew.sh/) : Build management

***

### Detects Elm code API changes

> See what changed in the package between versions

**Motivation:** Sometimes a MAJOR change is not actually very big, so this
can help you plan your upgrade timelines

**When to use it:** Before compilation

**Run:** `make diff`

**From package:** [elm](https://guide.elm-lang.org/install/elm.html) of
[npm](https://www.npmjs.com/) : Dependency management

***

### Markdown check

> Checks that the markdown documents follows some consistent guidelines

**Motivation:** Make the markdown documents consistent in style

**When to use it:** Before publishing

**Run:** `make md`

**From package:**
[makefile](https://opensource.com/article/18/8/what-how-makefile) of
[brew](https://docs.brew.sh/) : Build management

***

### Markdown fix

> Modify the markdown documents to ensure they follow some consistent
> guidelines

**Motivation:** Make the markdown documents consistent in style

**When to use it:** Before publishing

**Run:** `make md-fix`

**From package:**
[makefile](https://opensource.com/article/18/8/what-how-makefile) of
[brew](https://docs.brew.sh/) : Build management

***

### Install local dependencies

> Install some dependencies

**Motivation:** Before running most commands

**When to use it:** Before building

**Run:** `make install`

**From package:** [elm](https://guide.elm-lang.org/install/elm.html) of
[npm](https://www.npmjs.com/) : Dependency management

***

### Install global dependencies

> Install some dependencies globally

**Motivation:** Before running most commands

**When to use it:** Before building

**Run:** `make install-global`

**From package:** [yarn](https://classic.yarnpkg.com/en/) of
[npm](https://www.npmjs.com/) : Dependency management

***

### Ready for publishing

> Run a sequence of commands to check that the library is ready to be
> published

**Motivation:** Detect quality flaws before pushing the code

**When to use it:** Before pushing a branch

**Run:** `make ready`

**From package:**
[makefile](https://opensource.com/article/18/8/what-how-makefile) of
[brew](https://docs.brew.sh/) : Build management

***

### Reset distribution and report folders

> Delete the dist and report folder

**Motivation:** Start from a clean slate

**When to use it:** Before building

**Run:** `make reset`

**From package:**
[makefile](https://opensource.com/article/18/8/what-how-makefile) of
[brew](https://docs.brew.sh/) : Build management

***

### Unit testing

> Run the unit tests

**Motivation:** Check that the units of code behave as intended

**When to use it:** After compilation, before build

**Run:** `make test`

**From package:**
[makefile](https://opensource.com/article/18/8/what-how-makefile) of
[brew](https://docs.brew.sh/) : Build management

***

### Help for commands

> Summarize all the yarn and shell commands

**Motivation:** Assist the developer in quickly finding commands

**When to use it:** Before running a command

**Run:** `make help`

**From package:**
[makefile](https://opensource.com/article/18/8/what-how-makefile) of
[brew](https://docs.brew.sh/) : Build management

***

### Git commit from file

> Git commit a message that has been saved in the .message file

**Motivation:** Quicker commit for pre-defined use cases

**When to use it:** When commit to github

**Run:** `gcf`

**From package:** [zsh](https://www.zsh.org/) of
[brew](https://docs.brew.sh/) : Shell designed for interactive use

***

### Reset generated folders

> Delete the generated folder

**Motivation:** Start generation from a clean slate

**When to use it:** Before generation

**Run:** `make reset-generated`

**From package:**
[makefile](https://opensource.com/article/18/8/what-how-makefile) of
[brew](https://docs.brew.sh/) : Build management

***

### Prepare scripts for code generation

> Generate the scripts used for code generation

**Motivation:** The generation scripts contain a fair amount of boilerplate
code that can be easily generated

**When to use it:** Before generation

**Run:** `make pre-generate`

**From package:** [zsh](https://www.zsh.org/) of
[brew](https://docs.brew.sh/) : Shell designed for interactive use

***

### Generate some Elm Code

> Generate some of the boilerplate code for the Elm project

**Motivation:** Standardize and boost the development process

**When to use it:** When changing model

**Run:** `make generate`

**From package:** [zsh](https://www.zsh.org/) of
[brew](https://docs.brew.sh/) : Shell designed for interactive use

***

### Generate some code in the console

> Generate some of the boilerplate code that has to be manually added

**Motivation:** Boost the development process with contextual snippets

**When to use it:** When changing model

**Run:** `make assist`

**From package:** [zsh](https://www.zsh.org/) of
[brew](https://docs.brew.sh/) : Shell designed for interactive use

***

### Normalize the project with baldrick-whisker

> Generate some scaffolding using some handlebars templates

**Motivation:** Externalize scaffolding outside close source code

**When to use it:** Before running normalization

**Run:** `make whisker-norm`

**From package:**
[makefile](https://opensource.com/article/18/8/what-how-makefile) of
[brew](https://docs.brew.sh/) : Build management

***

### Normalize the code structure

> Normalize the code structure using baldrick (global version)

**Motivation:** Create a consistent developer experience

**When to use it:** When changing github actions

**Run:** `make norm`

**From package:** [baldrick-elm](https://github.com/flarebyte/baldrick-elm)
of [npm](https://www.npmjs.com/) : Elm scaffolding assistant

***
