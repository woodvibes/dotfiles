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
