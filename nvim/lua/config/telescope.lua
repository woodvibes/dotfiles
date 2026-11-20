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
