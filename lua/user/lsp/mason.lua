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

mason_lspconfig.setup({
	ensure_installed = { "lua_ls" },
	automatic_installation = false,
})

mason_lspconfig.setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup({})
	end,
	["lua_ls"] = function()
		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
	end,
})

local servers = {
	"clangd",
	"lua_ls",
	"cssls",
	"html",
	"tsserver",
	"pyright",
	"bashls",
	"jsonls",
	"yamlls",
	"gopls",
}

--
local custom_configs = {
	lua_ls = require("user.lsp.settings.lua_ls"),
	gopls = require("user.lsp.settings.gopls"),
	pyright = require("user.lsp.settings.pyright"),
}

local opts = {}
for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
		-- print capabilities
	}
	-- print all options

	if custom_configs[server] then
		opts = vim.tbl_deep_extend("force", custom_configs[server], opts)
	end

	-- print(server, vim.inspect(opts))

	lspconfig[server].setup(opts)
end
