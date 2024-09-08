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

	local install = {
        -- These are handled by nix-config:
		-- "revive",
		-- "vale",
		-- "eslint_d",
		-- "flake8",
		-- "isort",
		-- "black",
		-- "goimports",
		-- "golines",
		-- "prettier",
		-- "beautysh",
		-- "luacheck",
	}

	mason.setup({
		ensure_installed = install,
		ui = {
			icons = {
				package_installed = "✓",
			},
		},
	})

	vim.api.nvim_create_user_command("MasonInstallAll", function()
		vim.cmd("MasonInstall " .. table.concat(install, " "))
	end, {})

	local servers = {
		"efm",
		"clangd",
		"lua_ls",
		"cssls",
		"html",
		"ts_ls",
		"pyright",
		"bashls",
		"jsonls",
		"yamlls",
		"gopls",
	}

    local lsp_install = {
        "pyright"
    }

	mason_lspconfig.setup({
		ensure_installed = lsp_install,
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

	--
	local custom_configs = {
		lua_ls = require("lsp.settings.lua_ls"),
		gopls = require("lsp.settings.gopls"),
		pyright = require("lsp.settings.pyright"),
	}

	local opts = {}
	for _, server in pairs(servers) do
		opts = {
			on_attach = require("lsp.handlers").on_attach,
			capabilities = require("lsp.handlers").capabilities,
			-- print capabilities
		}
		-- print all options

		if custom_configs[server] then
			opts = vim.tbl_deep_extend("force", custom_configs[server], opts)
		end

		-- print(server, vim.inspect(opts))

		lspconfig[server].setup(opts)
	end
end

return {
	-- LSP Configuration & Plugins
	"williamboman/mason.nvim",

	dependencies = {
		-- automatically install lsps to stdpath for neovim
		"williamboman/mason-lspconfig.nvim",
	},
	config = config,
}
