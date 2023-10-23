local config = {
	-- directory for storing chat files
	chat_dir = "/zaloha/gp_chats",
	-- explicitly confirm deletion of a chat file
	chat_confirm_delete = false,
}

return {
	"robitx/gp.nvim",
	dev = not os.getenv("RUNNING_IN_DOCKER"),

	config = function()
		require("gp").setup(config)
	end,
}
