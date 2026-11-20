# nvim

## Pre-requisites

- [git](https://git-scm.com/downloads) - required by vim.pack to install plugins, and by vim-fugitive and vim-gitgutter
- [make and a C compiler](https://developer.apple.com/xcode/resources/) - required to build telescope-fzf-native.nvim and treesitter parsers
- [tree-sitter-cli](https://tree-sitter.github.io/tree-sitter/creating-parsers/1-getting-started.html?highlight=install#installation) - required by nvim-treesitter to build parsers
- [Node.js](https://nodejs.org/en/download) - required to build some parsers (e.g. javascript, typescript); must be the arm64 build (`node -p process.arch`)

### Language servers

- [lua-language-server](https://luals.github.io/#install) - lua_ls
- [gopls](https://go.dev/gopls/) - Go
- [clangd](https://clangd.llvm.org/installation) - C
- [typescript-language-server](https://github.com/typescript-language-server/typescript-language-server) - ts_ls (requires Node.js)
- [marksman](https://github.com/artempyanykh/marksman/blob/main/docs/install.md) - Markdown
- [vscode-langservers-extracted](https://github.com/hrsh7th/vscode-langservers-extracted#usage) - eslint via `vscode-eslint-language-server` (requires Node.js); only attaches in projects with an ESLint config file

### Formatters

- [stylua](https://github.com/JohnnyMorganz/StyLua) - Lua
- [prettier](https://prettier.io/docs/install) - Markdown (requires Node.js)

### Search

- [ripgrep](https://github.com/BurntSushi/ripgrep#installation) - Telescope live grep
