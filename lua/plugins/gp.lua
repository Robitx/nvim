local config = {
	-- required openai api key
	openai_api_key = os.getenv("OPENAI_API_KEY"),
	-- prefix for all commands
	cmd_prefix = "Gp",
	-- example hook functions
	hooks = {
		InspectPlugin = function(plugin, params)
			print(string.format("Plugin structure:\n%s", vim.inspect(plugin)))
			print(string.format("Command params:\n%s", vim.inspect(params)))
		end,

		-- -- example of making :%GpChatNew a dedicated command which
		-- -- opens new chat with the entire current buffer as a context
		-- BufferChatNew = function(plugin, _)
		--     -- call GpChatNew command in range mode on whole buffer
		--     vim.api.nvim_command("%" .. plugin.config.cmd_prefix .. "ChatNew")
		-- end,

		-- example of adding command which explains the selected code
		Explain = function(gp, params)
			local template = "I have the following code from {{filename}}:\n\n"
				.. "```{{filetype}}\n{{selection}}\n```\n\n"
				.. "Please respond by explaining the code above."
			gp.Prompt(params, gp.Target.popup, nil, gp.config.command_model, template, gp.config.chat_system_prompt)
		end,
	},

	-- directory for storing chat files
	chat_dir = "/zaloha/gp_chats",
	-- chat model (string with model name or table with model name and parameters)
	chat_model = { model = "gpt-3.5-turbo-16k", temperature = 0.7, top_p = 1 },
	-- chat model system prompt
	chat_system_prompt = "You are a general AI assistant.",
	-- chat user prompt prefix
	chat_user_prefix = "🗨:",
	-- chat assistant prompt prefix
	chat_assistant_prefix = "🤖:",
	-- chat topic generation prompt
	chat_topic_gen_prompt = "Summarize the topic of our conversation above"
		.. " in two or three words. Respond only with those words.",
	-- chat topic model (string with model name or table with model name and parameters)
	chat_topic_gen_model = "gpt-3.5-turbo-16k",
	-- explicitly confirm deletion of a chat file
	chat_confirm_delete = false,
	-- conceal model parameters in chat
	chat_conceal_model_params = true,
	-- local shortcuts bound to the chat buffer
	-- (be careful to choose something which will work across specified modes)
	chat_shortcut_respond = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g><C-g>" },
	chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>d" },

	-- command prompt prefix for asking user for input
	command_prompt_prefix = "🤖 ~ ",
	-- command model (string with model name or table with model name and parameters)
	command_model = { model = "gpt-3.5-turbo-16k", temperature = 1.1, top_p = 1 },
	-- command system prompt
	command_system_prompt = "You are an AI that strictly generates just the formated final code.",

	-- templates
	template_selection = "I have the following code from {{filename}}:\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}",
	template_rewrite = "I have the following code from {{filename}}:\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}"
		.. "\n\nRespond just with the formated final code. !!And please: No ``` code ``` blocks.",
	template_command = "{{command}}",
}

return {
	"robitx/gp.nvim",
	dev = true,

	config = function()
		require("gp").setup(config)
	end,
}