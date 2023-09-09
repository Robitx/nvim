local config = function()
	local eslint = require("efmls-configs.linters.eslint")
	local prettier = require("efmls-configs.formatters.prettier")
	local stylelint = require("efmls-configs.linters.stylelint")

	local languages = {
		typescript = { eslint, prettier },
		javascript = { eslint, prettier },
		html = { prettier },
		css = { prettier, stylelint },
		scss = { prettier, stylelint },
		sass = { prettier, stylelint },
		less = { prettier, stylelint },
		markdown = {
			prettier,
		},
		lua = { require("efmls-configs.formatters.stylua") },
		go = {
			require("efmls-configs.linters.staticcheck"),
			require("efmls-configs.formatters.golines"),
			require("efmls-configs.linters.go_revive"),
			require("efmls-configs.formatters.goimports"),
		},
		python = {
			require("efmls-configs.formatters.black"),
			require("efmls-configs.linters.flake8"),
		},
		dockerfile = {
			require("efmls-configs.linters.hadolint"),
		},
		json = {
			require("efmls-configs.formatters.jq"),
			require("efmls-configs.linters.jq"),
		},
	}

	local efmls_config = {
		filetypes = vim.tbl_keys(languages),
		settings = {
			rootMarkers = { ".git/" },
			languages = languages,
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
		},
	}

	require("lspconfig").efm.setup(vim.tbl_extend("force", efmls_config, {
		-- Pass your custom lsp config below like on_attach and capabilities
		--
		-- on_attach = on_attach,
		-- capabilities = capabilities,
	}))
end

return {
	"creativenull/efmls-configs-nvim",
	version = "v1.x.x", -- version is optional, but recommended
	dependencies = { "neovim/nvim-lspconfig" },
	config = config,
}
