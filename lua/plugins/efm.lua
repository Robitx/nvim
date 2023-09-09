local config = function()
	local eslint = require("efmls-configs.linters.eslint")
	local prettier = require("efmls-configs.formatters.prettier")
	local stylua = require("efmls-configs.formatters.stylua")

	local languages = {
		typescript = { eslint, prettier },
		lua = { stylua },
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
