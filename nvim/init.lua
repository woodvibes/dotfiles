-- TODO: separate into files by language

-- my vim preferences
vim.opt.number = true
vim.opt.relativenumber = true

-- update time - set specifically for git gutter
vim.opt.updatetime = 100

-- needed to build telescope-fzf-native before install
-- https://neovim.io/doc/user/pack/#vim.pack-events
vim.api.nvim_create_autocmd("PackChanged", {
	desc = "Build telescope-fzf-native.nvim on install or update",
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
			-- :wait() ensures compilation finishes before load_extension('fzf') runs
			vim.notify("Building telescope-fzf-native.nvim\n", vim.log.levels.INFO)
			local res = vim.system({ "make" }, { cwd = ev.data.path }):wait()
			if res.code ~= 0 then
				vim.notify("Failed to build telescope-fzf-native.nvim:\n" .. (res.stderr or ""), vim.log.levels.ERROR)
			end
		end
	end,
})

-- add packages
-- ref: https://neovim.io/doc/user/pack.html
vim.pack.add({
	-- themes
	"https://github.com/catppuccin/nvim",
	-- language servers
	-- ref: https://neovim.io/doc/user/lsp.html
	-- starting with nvim-lspconfig for reasonable defaults
	"https://github.com/neovim/nvim-lspconfig",
	-- treesitter for parsers
	-- supported langs: https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
	"https://github.com/nvim-treesitter/nvim-treesitter",
	-- conform - formatting
	"https://github.com/stevearc/conform.nvim",
	-- telescope and dependencies
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	-- git tools
	"https://github.com/tpope/vim-fugitive",
	"https://github.com/airblade/vim-gitgutter",
})

-- set up language servers
vim.lsp.enable({ "lua_ls", "gopls", "clangd", "ts_ls" })

-- diagnostics
-- ref: https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.Opts
vim.diagnostic.config({
	virtual_text = {
		severity = {
			min = vim.diagnostic.severity.HINT,
		},
	},
	signs = {
		severity = {
			min = vim.diagnostic.severity.HINT,
		},
	},
})

-- install parsers

-- keeping this in case I want to troubleshoot an install
-- require("nvim-treesitter").setup({
--	install_dir = vim.fn.stdpath('config')
--})

-- the following command needs to be run once per parser
-- be sure tree-sitter-cli is installed and this runs in a shell
-- with node available and that the node version is arm64 (node -p process.arch)
require("nvim-treesitter").install({ "go" }):wait(300000)
require("nvim-treesitter").install({ "javascript" }):wait(300000)
require("nvim-treesitter").install({ "markdown" }):wait(300000)
require("nvim-treesitter").install({ "typescript" }):wait(300000)

-- set up highlighting
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "go", "lua", "markdown", "c" },
	callback = function()
		-- syntax highlighting
		vim.treesitter.start()
		-- folds
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo.foldmethod = "expr"
	end,
})

-- conform
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		markdown = { "prettier" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

-- telescope
require("telescope").setup({
	defaults = require("telescope.themes").get_ivy({}),
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
		},
	},
	pickers = {
		find_files = {
			hidden = true,
			no_ignore = true,
		},
	},
})

require("telescope").load_extension("fzf")

local telescopeBuiltin = require("telescope.builtin")
vim.keymap.set("n", "<space>ff", telescopeBuiltin.find_files, { desc = "Telescope find files" })

vim.keymap.set(
	"n",
	"<space>ft",
	telescopeBuiltin.lsp_type_definitions,
	{ desc = "Telescope find LSP type definitions" }
)

vim.keymap.set(
	"n",
	"<space>fs",
	telescopeBuiltin.lsp_document_symbols,
	{ desc = "Telescope find LSP document symbols" }
)

vim.keymap.set("n", "<space>fi", telescopeBuiltin.lsp_implementations, { desc = "Telescope find LSP implementations" })

vim.keymap.set("n", "<space>fr", telescopeBuiltin.lsp_references, { desc = "Telescope find LSP references" })

vim.keymap.set("n", "<space>fd", telescopeBuiltin.lsp_definitions, { desc = "Telescope find LSP definitions" })

vim.keymap.set("n", "<space>fg", telescopeBuiltin.live_grep, { desc = "Telescope live grep" })

-- gitgutter
vim.g.gitgutter_highlight_lines = 1

-- theme set up
vim.cmd.colorscheme("catppuccin")

-- extra for Go
-- ref: https://go.dev/gopls/editor/vim#neovim
-- organize imports only; formatting is handled by conform's LSP fallback
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function(args)
		-- only run when gopls is attached; its encoding is used for both the
		-- request params and applying the returned edits
		local client = vim.lsp.get_clients({ bufnr = args.buf, name = "gopls" })[1]
		if not client then
			return
		end
		local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
		params.context = { only = { "source.organizeImports" } }
		-- 1000ms timeout. Depending on your machine and codebase, you may want
		-- longer if you find that you have to write the file twice for changes
		-- to be saved.
		local res = client:request_sync("textDocument/codeAction", params, 1000, args.buf)
		for _, r in pairs((res and res.result) or {}) do
			if r.edit then
				vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding)
			end
		end
	end,
})
