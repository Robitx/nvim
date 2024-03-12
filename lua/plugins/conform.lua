local config = {
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		go = { "goimports", "golines" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		sh = { "beautysh" },
		zsh = { "beautysh" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		scss = { "prettier" },
		nix = { "nixpkgs_fmt" },
	},
}

return {
	"stevearc/conform.nvim",

	config = function()
		require("conform").setup(config)
	end,
}
