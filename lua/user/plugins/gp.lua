local config = {
	-- api_key = os.getenv("OPENAI_API_KEY")
}

return {
	"robitx/gp.nvim",
	dependencies = {
        -- Telescope
        { "nvim-telescope/telescope.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
	dev = true,

	config = function()
		require("gp").setup(config)
	end,
}
