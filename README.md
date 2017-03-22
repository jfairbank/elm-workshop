# Building Web Apps with Elm Workshop

This repo contains setup instructions and demos for the "Building Web Apps with
Elm" workshop.

To access the finished demos, checkout the `completed` branch and look in the
`demos/` folders.

## Set Up Dependencies for Elm Development

These are typical global dependencies you will want installed for developing in
Elm in general. Please follow these steps as well as steps 2, 3, and 4 in the
next [section](#follow-along) to set up ahead of time for the workshop.

Please note that I am a Vim user, so I've only minimally tested the plugins for
other editors below. If you don't see your favorite editor listed, please find
the best Elm plugins for it and submit a PR!

1. Install the latest **LTS** version of Node: currently **6.10.0**
    * **Recommended:** install via a version manager like **nvm**
      * For OS X and Linux install [**nvm**](https://github.com/creationix/nvm)
        * `nvm install --lts`
      * For Windows install [**nvm-windows**](https://github.com/coreybutler/nvm-windows)
        * 64-bit: `nvm install 6.10.0 64`
        * 32-bit: `nvm install 6.10.0 32`
    * Or download from [nodejs.org](https://nodejs.org)
2. Quickly install all dependencies
    * Via **npm**: `npm install -g elm elm-format elm-oracle run-elm create-elm-app`
    * Via **yarn**: `yarn global add elm elm-format elm-oracle run-elm create-elm-app`
3. Or, individually install each dependency
    1. Install **Elm** via **npm** (Node package manager that comes with Node installation)
        * `npm install -g elm`
    2. Install supporting Elm packages via **npm**
        * [**elm-format**](https://github.com/avh4/elm-format)
          * Format Elm code to a unified community standard.
          * `npm install -g elm-format`
        * [**elm-oracle**](https://github.com/ElmCast/elm-oracle)
          * Autocompletion for Elm code.
          * `npm install -g elm-oracle`
        * [**run-elm**](https://github.com/jfairbank/run-elm)
          * Run Elm code from command line.
          * `npm install -g run-elm`
        * [**create-elm-app**](https://github.com/halfzebra/create-elm-app)
          * Easily bootstrap and build Elm apps.
          * `npm install -g create-elm-app`
4. Install helpful plugins for your IDE or text editor
    * **Vim** (with a package manager like [vim-plug](https://github.com/junegunn/vim-plug) or [Vundle](https://github.com/VundleVim/Vundle.vim))
      * [**Valloric/YouCompleteMe**](https://github.com/Valloric/YouCompleteMe)
        * General Vim autocompletion.
      * [**w0rp/ale**](https://github.com/w0rp/ale)
        * **Recommended:** General Vim linting and typechecking.
        * **NOTE:** Requires NeoVim or Vim 8. 
      * [**vim-syntastic/syntastic**](https://github.com/vim-syntastic/syntastic)
        * General Vim linting and typechecking.
        * **NOTE:** Use if you're not using NeoVim or Vim 7. 
      * [**ElmCast/elm-vim**](https://github.com/ElmCast/elm-vim)
        * Syntax highlighting, indentation, autocompletion, autoformatting.
        * Requires previous Vim plugins.
    * [**VS Code**](https://code.visualstudio.com/)
      * [**vscode-elm**](https://github.com/sbrink/vscode-elm)
        * `ext install elm`
    * [**Atom**](https://atom.io/)
      * [**language-elm**](https://github.com/edubkendo/atom-elm)
      * [**linter-elm-make**](https://github.com/mybuddymichael/linter-elm-make)
      * [**elm-format**](https://github.com/triforkse/atom-elm-format)
      * [**elmjutsu**](https://github.com/halohalospecial/atom-elmjutsu)
        * Not necessary, but looks like it has useful snippets.
    * [**Sublime**](https://www.sublimetext.com/)
      * Via [**Package Control**](https://packagecontrol.io/)
        * **Elm Language Support**
        * **Highlight Build Errors**
    * Missing your IDE or editor? Make a PR please!
5. Install workshop dependencies
    * If you plan to code along during the workshop, please complete steps 2, 3, and 4 [**below**](#follow-along) as well.

## Follow Along

1. Install previous dependencies for Elm development
2. Clone this repo
    * `git clone https://github.com/jfairbank/elm-workshop.git`
    * `cd elm-workshop`
3. Install Node dependencies for demos and API server
    * Install via [yarn](https://yarnpkg.com/)
      * `yarn`
    * Or install via npm
      * `npm install`
4. Install Elm dependencies
    * `npm run install:elm-dependencies`
5. Start API server for the GitHub demo
    * `npm run api`
6. Build apps with me in the `demos/` folder
    * `cd demos/`
7. Run a specific demo while building:
    * General Syntax
      * `npm run demo:syntax`
    * Todo List
      * `npm run demo:todo-list`
    * GitHub
      * `npm run demo:github`
    * Components
      * `npm run demo:components`
