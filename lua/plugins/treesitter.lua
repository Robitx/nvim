local config = function()
	local status_ok, tsc = pcall(require, "nvim-treesitter.configs")
	if not status_ok then
		return
	end

	---@diagnostic disable-next-line missing-fields
	tsc.setup({

		-- Add languages to be installed here that you want installed for treesitter
		ensure_installed = {
			"bash",
			"c",
			"cpp",
			"go",
			"lua",
			"python",
			"rust",
			"tsx",
			"javascript",
			"typescript",
			"vimdoc",
			"vim",
			"markdown",
			"markdown_inline",
		},

		-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
		auto_install = false,

		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<c-space>",
				node_incremental = "<c-space>",
				scope_incremental = "<c-s>",
				node_decremental = "<M-space>",
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["aa"] = "@parameter.outer",
					["ia"] = "@parameter.inner",
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = "@class.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer",
				},
			},
			swap = {
				enable = true,
				swap_next = {
					["<leader>a"] = "@parameter.inner",
				},
				swap_previous = {
					["<leader>A"] = "@parameter.inner",
				},
			},
		},

		ignore_install = { "" }, -- List of parsers to ignore installing
		highlight = {
			enable = true, -- false will disable the whole extension
			disable = { "css" }, -- list of language that will be disabled
		},
		indent = {
			enable = true,
			disable = {
				"python",
				"css",
			},
		},
	})
end

return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-refactor",
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-context",
		"nvim-treesitter/playground",
	},
	config = config,
	build = ":TSUpdate",
}
