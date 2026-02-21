# CHANGELOG

## 2026-02-21

### Added

- installed the following packages
  - catppuccino/nvim (theme)
  - nvim-lspconfig (default lsp settings)
  - nvim-treesitter (syntax highlighting and folding)
  - conform (formatting)
  - telescope (fuzzy search)
  - vim-fugitive (git tools)
  - vim-gitgutter (git file highlights)
- configured gopls and lua_ls language servers
- configured diagnostics display
- configured install of go, markdown, typescript and javascript parsers for treesitter
- set up folding and syntax highlighting in treesitter
- set up lua and markdown with conform
- added hooks for formatting for go
- configured telescope and set up keybinds for common searches
- applied catppuccino theme

### Changed

- disable lazy.vim in favor of new built-in package manager

## 2025-09-07

### Added

- Create `init.lua` file - import lazy
- Create `lua/config/lazy.lua` - use default setup from https://lazy.folke.io/installation
- Create `lua/plugins/conform.lua` - use default entry from https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#lazy-loading-with-lazynvim
- Add prettier for Markdown
