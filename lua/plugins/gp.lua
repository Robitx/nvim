local config = {
	-- directory for storing chat files
	chat_dir = "/zaloha/gp_chats",
	-- explicitly confirm deletion of a chat file
	chat_confirm_delete = false,

	chat_model = { model = "gpt-4-1106-preview", temperature = 1.1, top_p = 1 },
	command_model = { model = "gpt-4-1106-preview", temperature = 1.1, top_p = 1 },
}

return {
	"robitx/gp.nvim",
	dev = not os.getenv("RUNNING_IN_DOCKER"),

	config = function()
		require("gp").setup(config)
	end,
}
