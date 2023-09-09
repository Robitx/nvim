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
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	},

	-- -- DAP
	-- { "mfussenegger/nvim-dap" },
	-- { "rcarriga/nvim-dap-ui" },
	-- { "theHamsta/nvim-dap-virtual-text" },
	-- { "ravenxrz/DAPInstall.nvim" },

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
