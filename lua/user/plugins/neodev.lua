local config = function()
	local status_ok, neodev = pcall(require, "neodev")
	if not status_ok then
		return
	end

    neodev.setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    })
end

return {
	"folke/neodev.nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	opts = {},
	config = config,
}
