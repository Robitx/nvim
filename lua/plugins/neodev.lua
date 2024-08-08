return {
	"folke/lazydev.nvim", -- Replaces folke/neodev.nvim
	ft = "lua",
	opts = {
		library = {
			{ path = "luvit-meta/library", words = { "vim%.uv" } },
		},
	},
	dependencies = {
		{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
	},
}
