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
