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

__Motivation:__ Test GitHub Actions locally

__When to use it:__ When changing github actions

__Run:__ ```act```

__From package:__ [act](https://github.com/nektos/act) of [brew](https://docs.brew.sh/) :  Run GitHub Actions locally

---

### Build the library

> Transpile all the Elm source code to javascript

__Motivation:__ The code has to be build before been published

__When to use it:__ Before building

__Run:__ ```make build```

__From package:__ [makefile](https://opensource.com/article/18/8/what-how-makefile) of [brew](https://docs.brew.sh/) :  Build management

---

### Generate the documentation

> Generate the markdown documentation for the Elm project

__Motivation:__ Good documentation is essential for developer experience

__When to use it:__ Before publishing

__Run:__ ```make doc```

__From package:__ [makefile](https://opensource.com/article/18/8/what-how-makefile) of [brew](https://docs.brew.sh/) :  Build management

---

### Preview the documentation

> Generate the markdown documentation for the Elm project

__Motivation:__ Good documentation is essential for developer experience

__When to use it:__ Before publishing

__Run:__ ```make preview-doc```

__From package:__ [makefile](https://opensource.com/article/18/8/what-how-makefile) of [brew](https://docs.brew.sh/) :  Build management

---

### Update github repository

> Enable useful features for the github project repository

__Motivation:__ Create consistent settings

__When to use it:__ After creating

__Run:__ ```make github```

__From package:__ [gh](https://cli.github.com/) of [brew](https://docs.brew.sh/) :  GitHub CLI brings GitHub to your terminal

---

### Static code analysis

> Find problems in Elm code

__Motivation:__ Make the code more consistent and avoid bugs

__When to use it:__ Before compilation

__Run:__ ```make analyze```

__From package:__ [makefile](https://opensource.com/article/18/8/what-how-makefile) of [brew](https://docs.brew.sh/) :  Build management

---

### Beautify Elm source code

> Formats Elm source code according to a standard set of rules based on the official Elm Style Guide

__Motivation:__ Make the code more consistent and avoid bugs

__When to use it:__ Before compilation

__Run:__ ```make beautify```

__From package:__ [makefile](https://opensource.com/article/18/8/what-how-makefile) of [brew](https://docs.brew.sh/) :  Build management

---

### Detects Elm code API changes

> See what changed in the package between versions

__Motivation:__ Sometimes a MAJOR change is not actually very big, so this can help you plan your upgrade timelines

__When to use it:__ Before compilation

__Run:__ ```make diff```

__From package:__ [elm](https://guide.elm-lang.org/install/elm.html) of [npm](https://www.npmjs.com/) :  Dependency management

---

### Markdown check

> Checks that the markdown documents follows some consistent guidelines

__Motivation:__ Make the markdown documents consistent in style

__When to use it:__ Before publishing

__Run:__ ```make md```

__From package:__ [makefile](https://opensource.com/article/18/8/what-how-makefile) of [brew](https://docs.brew.sh/) :  Build management

---

### Markdown fix

> Modify the markdown documents to ensure they follow some consistent guidelines

__Motivation:__ Make the markdown documents consistent in style

__When to use it:__ Before publishing

__Run:__ ```make md-fix```

__From package:__ [makefile](https://opensource.com/article/18/8/what-how-makefile) of [brew](https://docs.brew.sh/) :  Build management

---

### Install local dependencies

> Install some dependencies

__Motivation:__ Before running most commands

__When to use it:__ Before building

__Run:__ ```make install```

__From package:__ [elm](https://guide.elm-lang.org/install/elm.html) of [npm](https://www.npmjs.com/) :  Dependency management

---

### Install global dependencies

> Install some dependencies globally

__Motivation:__ Before running most commands

__When to use it:__ Before building

__Run:__ ```make install-global```

__From package:__ [yarn](https://classic.yarnpkg.com/en/) of [npm](https://www.npmjs.com/) :  Dependency management

---

### Ready for publishing

> Run a sequence of commands to check that the library is ready to be published

__Motivation:__ Detect quality flaws before pushing the code

__When to use it:__ Before pushing a branch

__Run:__ ```make ready```

__From package:__ [makefile](https://opensource.com/article/18/8/what-how-makefile) of [brew](https://docs.brew.sh/) :  Build management

---

### Reset distribution and report folders

> Delete the dist and report folder

__Motivation:__ Start from a clean slate

__When to use it:__ Before building

__Run:__ ```make reset```

__From package:__ [makefile](https://opensource.com/article/18/8/what-how-makefile) of [brew](https://docs.brew.sh/) :  Build management

---

### Unit testing

> Run the unit tests

__Motivation:__ Check that the units of code behave as intended

__When to use it:__ After compilation, before build

__Run:__ ```make test```

__From package:__ [makefile](https://opensource.com/article/18/8/what-how-makefile) of [brew](https://docs.brew.sh/) :  Build management

---

### Help for commands

> Summarize all the yarn and shell commands

__Motivation:__ Assist the developer in quickly finding commands

__When to use it:__ Before running a command

__Run:__ ```make help```

__From package:__ [makefile](https://opensource.com/article/18/8/what-how-makefile) of [brew](https://docs.brew.sh/) :  Build management

---

### Git commit from file

> Git commit a message that has been saved in the .message file

__Motivation:__ Quicker commit for pre-defined use cases

__When to use it:__ When commit to github

__Run:__ ```gcf```

__From package:__ [zsh](https://www.zsh.org/) of [brew](https://docs.brew.sh/) :  Shell designed for interactive use

---

### Reset generated folders

> Delete the generated folder

__Motivation:__ Start generation from a clean slate

__When to use it:__ Before generation

__Run:__ ```make reset-generated```

__From package:__ [makefile](https://opensource.com/article/18/8/what-how-makefile) of [brew](https://docs.brew.sh/) :  Build management

---

### Prepare scripts for code generation

> Generate the scripts used for code generation

__Motivation:__ The generation scripts contain a fair amount of boilerplate code that can be easily generated

__When to use it:__ Before generation

__Run:__ ```make pre-generate```

__From package:__ [zsh](https://www.zsh.org/) of [brew](https://docs.brew.sh/) :  Shell designed for interactive use

---

### Generate some Elm Code

> Generate some of the boilerplate code for the Elm project

__Motivation:__ Standardize and boost the development process

__When to use it:__ When changing model

__Run:__ ```make generate```

__From package:__ [zsh](https://www.zsh.org/) of [brew](https://docs.brew.sh/) :  Shell designed for interactive use

---

### Generate some code in the console

> Generate some of the boilerplate code that has to be manually added

__Motivation:__ Boost the development process with contextual snippets

__When to use it:__ When changing model

__Run:__ ```make assist```

__From package:__ [zsh](https://www.zsh.org/) of [brew](https://docs.brew.sh/) :  Shell designed for interactive use

---

### Normalize the project with baldrick-whisker

> Generate some scaffolding using some handlebars templates

__Motivation:__ Externalize scaffolding outside close source code

__When to use it:__ Before running normalization

__Run:__ ```make whisker-norm```

__From package:__ [makefile](https://opensource.com/article/18/8/what-how-makefile) of [brew](https://docs.brew.sh/) :  Build management

---

### Normalize the code structure

> Normalize the code structure using baldrick (global version)

__Motivation:__ Create a consistent developer experience

__When to use it:__ When changing github actions

__Run:__ ```make norm```

__From package:__ [baldrick-elm](https://github.com/flarebyte/baldrick-elm) of [npm](https://www.npmjs.com/) :  Elm scaffolding assistant

---