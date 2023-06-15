local config = {
	-- api_key = os.getenv("OPENAI_API_KEY")
	hooks = {
		dummy = function(plugin, text)
			print("inspect: " .. vim.inspect(plugin))
			print("echo: " .. text)
		end,
	},
}

return {
	"robitx/gpt.nvim",
	dependencies = { "MunifTanjim/nui.nvim", "nvim-telescope/telescope.nvim" },
	dev = true,

	config = function()
		require("gpt").setup(config)
	end,
}
