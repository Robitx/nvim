return {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					vim.fn.expand("$VIMRUNTIME/lua"),
					vim.fn.stdpath("config") .. "/lua",
					-- Make the server aware of Neovim runtime files
					vim.api.nvim_get_runtime_file("", true),
				},
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
