require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		markdown = { "prettier" },
		json = { "prettier" },
		jsonc = { "prettier" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
