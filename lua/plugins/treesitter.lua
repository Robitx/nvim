-- nvim-treesitter `main` branch: it only installs parsers and queries,
-- highlighting/indent are enabled per buffer below
local parsers = {
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
}

local highlight_disable = { "css" }
local indent_disable = { "python", "css" }

local config = function()
	require("nvim-treesitter").install(parsers)

	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
		callback = function(args)
			local ft = vim.bo[args.buf].filetype
			if vim.tbl_contains(highlight_disable, ft) then
				return
			end
			if not pcall(vim.treesitter.start, args.buf) then
				return
			end
			if not vim.tbl_contains(indent_disable, ft) then
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
		end,
	})

	-- incremental selection, using the built-in `an` / `in` (Neovim 0.12)
	vim.keymap.set("n", "<c-space>", "van", { remap = true, desc = "Select treesitter node" })
	vim.keymap.set("x", "<c-space>", "an", { remap = true, desc = "Expand to parent node" })
	vim.keymap.set("x", "<M-space>", "in", { remap = true, desc = "Shrink to child node" })
end

local textobjects_config = function()
	require("nvim-treesitter-textobjects").setup({
		select = {
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
		},
		move = {
			set_jumps = true, -- whether to set jumps in the jumplist
		},
	})

	local select = require("nvim-treesitter-textobjects.select")
	local move = require("nvim-treesitter-textobjects.move")
	local swap = require("nvim-treesitter-textobjects.swap")

	local selects = {
		["aa"] = "@parameter.outer",
		["ia"] = "@parameter.inner",
		["af"] = "@function.outer",
		["if"] = "@function.inner",
		["ac"] = "@class.outer",
		["ic"] = "@class.inner",
	}
	for lhs, query in pairs(selects) do
		vim.keymap.set({ "x", "o" }, lhs, function()
			select.select_textobject(query, "textobjects")
		end, { desc = "Select " .. query })
	end

	local moves = {
		goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
		goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
		goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
		goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
	}
	for fn, maps in pairs(moves) do
		for lhs, query in pairs(maps) do
			vim.keymap.set({ "n", "x", "o" }, lhs, function()
				move[fn](query, "textobjects")
			end, { desc = fn .. " " .. query })
		end
	end

	vim.keymap.set("n", "<leader>a", function()
		swap.swap_next("@parameter.inner")
	end, { desc = "Swap with next parameter" })
	vim.keymap.set("n", "<leader>A", function()
		swap.swap_previous("@parameter.inner")
	end, { desc = "Swap with previous parameter" })
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false, -- does not support lazy-loading
		build = ":TSUpdate",
		config = config,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		init = function()
			-- these ftplugins define buffer-local ]] [[ ]m ... which would shadow the moves above
			vim.g.no_python_maps = true
			vim.g.no_go_maps = true
			vim.g.no_rust_maps = true
		end,
		config = textobjects_config,
	},
	{ "nvim-treesitter/nvim-treesitter-context" },
}
