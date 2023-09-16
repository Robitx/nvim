-- vim.g.rehash256 = 1
-- vim.g.molokai_original = 1
-- local colorscheme = "molokai"

-- local colorscheme = "monokai"
-- colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
local colorscheme = "srcery"
local loaded = false

local load_scheme = function()
	if loaded then
		return
	end

	local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
	if not status_ok then
		return
	end

	loaded = true
end

return {
	-- Colorschemes
	{ "folke/tokyonight.nvim", config = load_scheme },
	{ "lunarvim/darkplus.nvim", config = load_scheme },
	{ "rebelot/kanagawa.nvim", config = load_scheme },
	-- use { "tanvirtin/monokai.nvim", config = load_scheme},
	{ "ray-x/starry.nvim", config = load_scheme },
	{ "malbernaz/monokai.nvim", config = load_scheme },
	{ "phanviet/vim-monokai-pro", config = load_scheme },
	{ "marko-cerovac/material.nvim", config = load_scheme },
	{ "cpea2506/one_monokai.nvim", config = load_scheme },
	{ "sainnhe/sonokai", config = load_scheme },
	{ "ChristianChiarulli/nvcode-color-schemes.vim", config = load_scheme },
	{ "patstockwell/vim-monokai-tasty", config = load_scheme },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000, config = load_scheme },
	{ "srcery-colors/srcery-vim", config = load_scheme },
}
