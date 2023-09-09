return {

	-- Useful lua functions used by lots of plugins
	{ "nvim-lua/plenary.nvim" },

	-- Autopairs, integrates with both cmp and treesitter
	{ "windwp/nvim-autopairs" },

	{ "moll/vim-bbye" },

	-- Plugin to read .evn files
	{ "tpope/vim-dotenv" },

	-- Database plugins
	{ "tpope/vim-dadbod" },
	{ "kristijanhusak/vim-dadbod-ui" },
	{ "kristijanhusak/vim-dadbod-completion" },

	-- cmp plugins
	{ "hrsh7th/nvim-cmp" }, -- The completion plugin
	{ "hrsh7th/cmp-buffer" }, -- buffer completions
	{ "hrsh7th/cmp-path" }, -- path completions
	{ "saadparwaiz1/cmp_luasnip" }, -- snippet completions
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-nvim-lua" },

	-- snippets
	{ "L3MON4D3/LuaSnip" }, --snippet engine
	{ "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use

	-- LSP
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" }, -- enable LSP
	-- { "williamboman/nvim-lsp-installer" }, -- simple to use language server installer
	{ "jose-elias-alvarez/null-ls.nvim" }, -- for formatters and linters

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

	-- Git
	{
		"lewis6991/gitsigns.nvim",
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
