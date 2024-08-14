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
		local lint = require("lint")
		lint.linters_by_ft = linters

		lint.linters.luacheck.args = {
			args = { "--globals", "vim" },
		}

		local project_dir = vim.fs.dirname(vim.fs.find({ ".revive.toml" }, { upward = true })[1])
		if project_dir then
			lint.linters.revive.args = {
				"-config",
				project_dir .. "/.revive.toml",
				vim.fn.expand("%"),
			}
		end

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
