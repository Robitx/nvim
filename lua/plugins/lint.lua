local linters = {
	lua = { "luacheck" },
	javascript = { "eslint_d" },
	typescript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	svelte = { "eslint_d" },
	python = { "flake8" },
	go = { "revive" },
	markdown = { "vale" },
}

return {
	"mfussenegger/nvim-lint",

	config = function()
		require("lint").linters_by_ft = linters

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
