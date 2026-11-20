-- make lua_ls aware of the neovim runtime (vim.* globals, API docs, completion)
-- ref: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/lua_ls.lua
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME },
			},
		},
	},
})

-- leave js/ts formatting to ts_ls; conform's lsp fallback would otherwise format with both
-- ref: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/eslint.lua
vim.lsp.config("eslint", {
	settings = { format = false },
})

vim.lsp.enable({ "lua_ls", "gopls", "clangd", "ts_ls", "marksman", "eslint" })

-- completion
-- ref: https://neovim.io/doc/user/lsp.html#lsp-completion
vim.opt.completeopt = { "menuone", "noselect", "popup" }
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Enable built-in LSP completion",
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})

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
