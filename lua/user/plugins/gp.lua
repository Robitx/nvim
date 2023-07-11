local config = {
	-- required openai api key
	openai_api_key = os.getenv("OPENAI_API_KEY"),
	-- prefix for all commands
	cmd_prefix = "Gp",
	-- example hook functions
	hooks = {
		InspectPlugin = function(plugin)
			print(string.format("Plugin structure:\n%s", vim.inspect(plugin)))
		end,
	},

	-- directory for storing chat files
	chat_dir = "/zaloha/gpt_chats",
	-- chat model
	chat_model = "gpt-3.5-turbo-16k",
	-- chat temperature
	chat_temperature = 0.7,
	-- chat model system prompt
	chat_system_prompt = "You are a general AI assistant.",
	-- chat user prompt prefix
	chat_user_prefix = "🗨:",
	-- chat assistant prompt prefix
	chat_assistant_prefix = "🤖:",
	-- chat topic generation prompt
	chat_topic_gen_prompt = "Summarize the topic of our conversation above"
		.. " in two or three words. Respond only with those words.",
	-- chat topic model
	chat_topic_gen_model = "gpt-3.5-turbo-16k",

	-- command prompt prefix for asking user for input
	command_prompt_prefix = "🤖 ~ ",
	-- command model
	command_model = "gpt-4",
	-- command system prompt
	command_system_prompt = "You are an AI that strictly generates pure formated final code, without providing any comments or explanations.",

	-- templates
	template_selection = "I have the following code from {{filename}}:\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}",
	template_rewrite = "I have the following code from {{filename}}:\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}"
		.. "\n\nRespond just with the pure formated final code. !!And please: No ``` code ``` blocks.",
	template_command = "{{command}}",
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
