local config = {
	-- api_key = os.getenv("OPENAI_API_KEY")
}

return {
	"robitx/gpt.nvim",
	dependencies = { "MunifTanjim/nui.nvim", "nvim-telescope/telescope.nvim" },
	dev = true,

	config = function()
		require("gpt").setup(config)
	end,
}
