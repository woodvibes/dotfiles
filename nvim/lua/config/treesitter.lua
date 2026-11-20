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
