local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- Have packer manage itself
	use({ "wbthomason/packer.nvim" })
	-- Useful lua functions used by lots of plugins
	use({ "nvim-lua/plenary.nvim" })

	-- Autopairs, integrates with both cmp and treesitter
	use({ "windwp/nvim-autopairs" })

	-- Plugins for vs code like commenting
	use({ "numToStr/Comment.nvim" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring" })

	-- File explorer
	use({ "kyazdani42/nvim-web-devicons" })
	use({ "kyazdani42/nvim-tree.lua" })

	use({ "akinsho/bufferline.nvim", tag = "v2.12.0", requires = "kyazdani42/nvim-web-devicons" })
	use({ "moll/vim-bbye" })
	use({ "nvim-lualine/lualine.nvim" })
	use({ "akinsho/toggleterm.nvim" })
	use({ "ahmedkhalf/project.nvim" })
	use({ "lewis6991/impatient.nvim" })
	use({ "lukas-reineke/indent-blankline.nvim" })
	use({ "goolord/alpha-nvim" })

	use("folke/which-key.nvim")

	-- Colorschemes
	use({ "folke/tokyonight.nvim" })
	use({ "lunarvim/darkplus.nvim" })
	use({ "rebelot/kanagawa.nvim" })
	-- use { "tanvirtin/monokai.nvim" }
	use({ "ray-x/starry.nvim" })
	use({ "malbernaz/monokai.nvim" })
	use({ "phanviet/vim-monokai-pro" })
	use({ "marko-cerovac/material.nvim" })
	use({ "cpea2506/one_monokai.nvim" })
	use({ "sainnhe/sonokai" })
	use({ "ChristianChiarulli/nvcode-color-schemes.vim" })
	use({ "patstockwell/vim-monokai-tasty" })

	-- Plugin to read .evn files
	use({ "tpope/vim-dotenv" })

	-- Database plugins
	use({ "tpope/vim-dadbod" })
	use({ "kristijanhusak/vim-dadbod-ui" })
	use({ "kristijanhusak/vim-dadbod-completion" })

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer" }) -- buffer completions
	use({ "hrsh7th/cmp-path" }) -- path completions
	use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lua" })

	-- snippets
	use({ "L3MON4D3/LuaSnip" }) --snippet engine
	use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

	-- LSP
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use({ "neovim/nvim-lspconfig" }) -- enable LSP
	-- use({ "williamboman/nvim-lsp-installer" }) -- simple to use language server installer
	use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
	use({ "RRethy/vim-illuminate" })

	use({
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	-- -- Go plugins
	use({ "ray-x/guihua.lua" }) -- recommanded if need floating window support
	use({ "ray-x/go.nvim" })

	-- Copilot
	use({ "github/copilot.vim" })

	-- Telescope
	use({ "nvim-telescope/telescope.nvim" })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	use({
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
	})
	use({ "nvim-treesitter/nvim-treesitter-context" })
	use({ "nvim-treesitter/playground" })

	-- Git
	use({
		"lewis6991/gitsigns.nvim",
	})

	-- -- DAP
	-- use({ "mfussenegger/nvim-dap" })
	-- use({ "rcarriga/nvim-dap-ui" })
	-- use({ "theHamsta/nvim-dap-virtual-text" })
	-- use({ "ravenxrz/DAPInstall.nvim" })

	-- TODO:
	-- use { 'monaqa/dial.nvim' }
	-- use { 'simrat39/symbols-outline.nvim' }
	-- use { 'metakirby5/codi.vim' }
	-- use { 'folke/lua-dev.nvim' }
	-- use { 'karb94/neoscroll.nvim' }
	-- use { 'folke/todo-comments.nvim' }
	-- use { 'pedro757/emmet' }
	-- use { 'aca/emmet-ls' }

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
