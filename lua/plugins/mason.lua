local config = function()
	local status_ok, mason, mason_lspconfig, lspconfig

	status_ok, mason = pcall(require, "mason")
	if not status_ok then
		return
	end

	status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
	if not status_ok then
		return
	end

	status_ok, lspconfig = pcall(require, "lspconfig")
	if not status_ok then
		return
	end

	mason.setup({
		ui = {
			icons = {
				package_installed = "✓",
			},
		},
	})

	local lsp_install = {
		"pyright",
		"yamlls",
		"jsonls",
		"html",
		"cssls",
	}

    local enable_lsp = {
		"efm",
		"clangd",
		"lua_ls",
		"ts_ls",
		"pyright",
		"bashls",
		"gopls",
        "rust_analyzer",
    }

    for _, server in pairs(enable_lsp) do
        vim.lsp.enable(server)
    end

	mason_lspconfig.setup({
		ensure_installed = lsp_install,
		automatic_enable = true,
	})

	return

	-- local servers = {
	-- 	"efm",
	-- 	"clangd",
	-- 	"lua_ls",
	-- 	"cssls",
	-- 	"html",
	-- 	"ts_ls",
	-- 	"pyright",
	-- 	"bashls",
	-- 	"jsonls",
	-- 	"yamlls",
	-- 	"gopls",
	-- }
	--
	--
	-- local custom_configs = {
	-- 	lua_ls = require("lsp.settings.lua_ls"),
	-- 	gopls = require("lsp.settings.gopls"),
	-- 	pyright = require("lsp.settings.pyright"),
	-- }
	--
	-- local opts = {}
	-- for _, server in pairs(servers) do
	-- 	opts = {
	-- 		on_attach = require("lsp.handlers").on_attach,
	-- 		capabilities = require("lsp.handlers").capabilities,
	-- 		-- print capabilities
	-- 	}
	-- 	-- print all options
	--
	-- 	if custom_configs[server] then
	-- 		opts = vim.tbl_deep_extend("force", custom_configs[server], opts)
	-- 	end
	--
	-- 	-- print(server, vim.inspect(opts))
	--
	-- 	lspconfig[server].setup(opts)
	-- end
end

return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
	config = config,
}
