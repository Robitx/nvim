local config = function()
	local status_ok, _ = pcall(require, "lspconfig")
	if not status_ok then
		return
	end

	require("lsp.handlers").setup()
	require("lsp.null-ls")
end

return {
	-- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		-- automatically install lsps to stdpath for neovim
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },

		-- { "williamboman/nvim-lsp-installer" }, -- simple to use language server installer
		{ "jose-elias-alvarez/null-ls.nvim" }, -- for formatters and linters

		-- Useful status updates for LSP
		-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
		{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },

		-- Additional lua configuration, makes nvim stuff amazing!
		"folke/neodev.nvim",
	},
	config = config,
}
