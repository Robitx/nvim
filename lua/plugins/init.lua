return {

	-- Useful lua functions used by lots of plugins
	{ "nvim-lua/plenary.nvim" },

	{ "moll/vim-bbye" },

	-- Plugin to read .evn files
	{ "tpope/vim-dotenv" },

	-- Database plugins
	{ "tpope/vim-dadbod" },
	{ "kristijanhusak/vim-dadbod-ui" },
	{ "kristijanhusak/vim-dadbod-completion" },

	{
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	-- TODO:
	-- use { 'monaqa/dial.nvim' }
	-- use { 'simrat39/symbols-outline.nvim' }
	-- use { 'metakirby5/codi.vim' }
	-- use { 'folke/lua-dev.nvim' }
	-- use { 'karb94/neoscroll.nvim' }
	-- use { 'folke/todo-comments.nvim' }
	-- use { 'pedro757/emmet' }
	-- use { 'aca/emmet-ls' }
}
