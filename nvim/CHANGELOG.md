# CHANGELOG

## 2026-11-20

### Added

- marksman language server for Markdown
- eslint language server for JS/TS diagnostics and code actions; its
  formatting is disabled so ts_ls remains the only formatter on save
- enabled built-in LSP completion with autotrigger for any attached server that supports it
- treesitter highlighting and folds for JavaScript, TypeScript, JSX, and TSX buffers
- `tsx` treesitter parser, since the `typescript` parser can't parse TSX
- prettier formatting on save for JSON and JSONC files (e.g. `tsconfig.json`, `.eslintrc.json`)

### Changed

- configured gopls to format with gofumpt (applied on save via conform's LSP
  fallback) and enabled staticcheck plus the `unusedparams` and `QF1006` analyzers
- split `init.lua` into modules under `lua/config/` (options, plugins, lsp,
  treesitter, format, telescope, git, theme, go); `init.lua` now only requires
  them in load order, with no change in behavior
- consolidated language server setup into a single `vim.lsp.enable` call
- configured lua_ls to recognize the Neovim runtime (LuaJIT, `$VIMRUNTIME` library) so `vim.*` globals resolve with docs and completion

### Fixed

- Go files no longer formatted twice on save; conform handles formatting and the Go autocmd only organizes imports
- Go organize-imports on save no longer emits the `make_range_params`
  `position_encoding` warning; it now only runs when gopls is attached and
  uses gopls' offset encoding for requests and edits

### Removed

- leftover lazy.nvim files no longer loaded by `init.lua`
  - `lua/config/lazy.lua`
  - `lua/plugins/conform.lua`
  - `lazy-lock.json`

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
