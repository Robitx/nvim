local config = {
	-- directory for storing chat files
	chat_dir = "/backup/gp_chats",
	-- explicitly confirm deletion of a chat file
	chat_confirm_delete = false,

	hooks = {
		Joke = function(gp, params)
			local template = "Tell me random joke using pseudo code."
			local agent = gp.get_command_agent()
			gp.Prompt(params, gp.Target.vnew, nil, agent.model, template, agent.system_prompt)
		end,

		UnitTests = function(gp, params)
			local template = "I have the following code from {{filename}}:\n\n"
				.. "```{{filetype}}\n{{selection}}\n```\n\n"
				.. "Please respond by writing table driven unit tests for the code above."
			local agent = gp.get_command_agent()
			gp.Prompt(params, gp.Target.vnew, nil, agent.model, template, agent.system_prompt)
		end,

		Translator = function(gp, params)
			local chat_system_prompt = "You are a Translator, help me translate between English and Chinese."
			gp.cmd.ChatNew(params, nil, chat_system_prompt)
		end,

		ProofReader = function(gp, params)
			local chat_system_prompt = "I want you act as a proofreader. I will"
				.. "provide you texts and I would like you to review them for any"
				.. "spelling, grammar, or punctuation errors. Once you have finished"
				.. "reviewing the text, provide me with any necessary corrections or"
				.. "suggestions for improve the text. Highlight the corrections with"
				.. "markdown bold or italics style."
			gp.cmd.ChatNew(params, nil, chat_system_prompt)
		end,
	},
}

local register_shortcuts = function()
	-- VISUAL mode mappings
	-- s, x, v modes are handled the same way by which_key
	require("which-key").register({
		-- ...
		["<C-g>"] = {
			c = { ":<C-u>'<,'>GpChatNew<cr>", "Visual Chat New" },
			p = { ":<C-u>'<,'>GpChatPaste<cr>", "Visual Chat Paste" },
			t = { ":<C-u>'<,'>GpChatToggle<cr>", "Visual Toggle Chat" },

			["<C-x>"] = { ":<C-u>'<,'>GpChatNew split<cr>", "Visual Chat New split" },
			["<C-v>"] = { ":<C-u>'<,'>GpChatNew vsplit<cr>", "Visual Chat New vsplit" },
			["<C-t>"] = { ":<C-u>'<,'>GpChatNew tabnew<cr>", "Visual Chat New tabnew" },

			r = { ":<C-u>'<,'>GpRewrite<cr>", "Visual Rewrite" },
			a = { ":<C-u>'<,'>GpAppend<cr>", "Visual Append (after)" },
			b = { ":<C-u>'<,'>GpPrepend<cr>", "Visual Prepend (before)" },
			i = { ":<C-u>'<,'>GpImplement<cr>", "Implement selection" },

			g = {
				name = "generate into new ..",
				p = { ":<C-u>'<,'>GpPopup<cr>", "Visual Popup" },
				e = { ":<C-u>'<,'>GpEnew<cr>", "Visual GpEnew" },
				n = { ":<C-u>'<,'>GpNew<cr>", "Visual GpNew" },
				v = { ":<C-u>'<,'>GpVnew<cr>", "Visual GpVnew" },
				t = { ":<C-u>'<,'>GpTabnew<cr>", "Visual GpTabnew" },
			},

			n = { "<cmd>GpNextAgent<cr>", "Next Agent" },
			s = { "<cmd>GpStop<cr>", "GpStop" },
			x = { ":<C-u>'<,'>GpContext<cr>", "Visual GpContext" },

			w = {
				name = "Whisper",
				w = { ":<C-u>'<,'>GpWhisper<cr>", "Whisper" },
				r = { ":<C-u>'<,'>GpWhisperRewrite<cr>", "Whisper Rewrite" },
				a = { ":<C-u>'<,'>GpWhisperAppend<cr>", "Whisper Append (after)" },
				b = { ":<C-u>'<,'>GpWhisperPrepend<cr>", "Whisper Prepend (before)" },
				p = { ":<C-u>'<,'>GpWhisperPopup<cr>", "Whisper Popup" },
				e = { ":<C-u>'<,'>GpWhisperEnew<cr>", "Whisper Enew" },
				n = { ":<C-u>'<,'>GpWhisperNew<cr>", "Whisper New" },
				v = { ":<C-u>'<,'>GpWhisperVnew<cr>", "Whisper Vnew" },
				t = { ":<C-u>'<,'>GpWhisperTabnew<cr>", "Whisper Tabnew" },
			},
		},
		-- ...
	}, {
		mode = "v", -- VISUAL mode
		prefix = "",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = true,
	})

	-- NORMAL mode mappings
	require("which-key").register({
		-- ...
		["<C-g>"] = {
			c = { "<cmd>GpChatNew<cr>", "New Chat" },
			t = { "<cmd>GpChatToggle<cr>", "Toggle Chat" },
			f = { "<cmd>GpChatFinder<cr>", "Chat Finder" },

			["<C-x>"] = { "<cmd>GpChatNew split<cr>", "New Chat split" },
			["<C-v>"] = { "<cmd>GpChatNew vsplit<cr>", "New Chat vsplit" },
			["<C-t>"] = { "<cmd>GpChatNew tabnew<cr>", "New Chat tabnew" },

			r = { "<cmd>GpRewrite<cr>", "Inline Rewrite" },
			a = { "<cmd>GpAppend<cr>", "Append (after)" },
			b = { "<cmd>GpPrepend<cr>", "Prepend (before)" },

			g = {
				name = "generate into new ..",
				p = { "<cmd>GpPopup<cr>", "Popup" },
				e = { "<cmd>GpEnew<cr>", "GpEnew" },
				n = { "<cmd>GpNew<cr>", "GpNew" },
				v = { "<cmd>GpVnew<cr>", "GpVnew" },
				t = { "<cmd>GpTabnew<cr>", "GpTabnew" },
			},

			n = { "<cmd>GpNextAgent<cr>", "Next Agent" },
			s = { "<cmd>GpStop<cr>", "GpStop" },
			x = { "<cmd>GpContext<cr>", "Toggle GpContext" },

			w = {
				name = "Whisper",
				w = { "<cmd>GpWhisper<cr>", "Whisper" },
				r = { "<cmd>GpWhisperRewrite<cr>", "Whisper Inline Rewrite" },
				a = { "<cmd>GpWhisperAppend<cr>", "Whisper Append (after)" },
				b = { "<cmd>GpWhisperPrepend<cr>", "Whisper Prepend (before)" },
				p = { "<cmd>GpWhisperPopup<cr>", "Whisper Popup" },
				e = { "<cmd>GpWhisperEnew<cr>", "Whisper Enew" },
				n = { "<cmd>GpWhisperNew<cr>", "Whisper New" },
				v = { "<cmd>GpWhisperVnew<cr>", "Whisper Vnew" },
				t = { "<cmd>GpWhisperTabnew<cr>", "Whisper Tabnew" },
			},
		},
		-- ...
	}, {
		mode = "n", -- NORMAL mode
		prefix = "",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = true,
	})

	-- INSERT mode mappings
	require("which-key").register({
		-- ...
		["<C-g>"] = {
			c = { "<cmd>GpChatNew<cr>", "New Chat" },
			t = { "<cmd>GpChatToggle<cr>", "Toggle Chat" },
			f = { "<cmd>GpChatFinder<cr>", "Chat Finder" },

			["<C-x>"] = { "<cmd>GpChatNew split<cr>", "New Chat split" },
			["<C-v>"] = { "<cmd>GpChatNew vsplit<cr>", "New Chat vsplit" },
			["<C-t>"] = { "<cmd>GpChatNew tabnew<cr>", "New Chat tabnew" },

			r = { "<cmd>GpRewrite<cr>", "Inline Rewrite" },
			a = { "<cmd>GpAppend<cr>", "Append (after)" },
			b = { "<cmd>GpPrepend<cr>", "Prepend (before)" },

			g = {
				name = "generate into new ..",
				p = { "<cmd>GpPopup<cr>", "Popup" },
				e = { "<cmd>GpEnew<cr>", "GpEnew" },
				n = { "<cmd>GpNew<cr>", "GpNew" },
				v = { "<cmd>GpVnew<cr>", "GpVnew" },
				t = { "<cmd>GpTabnew<cr>", "GpTabnew" },
			},

			x = { "<cmd>GpContext<cr>", "Toggle GpContext" },
			s = { "<cmd>GpStop<cr>", "GpStop" },
			n = { "<cmd>GpNextAgent<cr>", "Next Agent" },

			w = {
				name = "Whisper",
				w = { "<cmd>GpWhisper<cr>", "Whisper" },
				r = { "<cmd>GpWhisperRewrite<cr>", "Whisper Inline Rewrite" },
				a = { "<cmd>GpWhisperAppend<cr>", "Whisper Append (after)" },
				b = { "<cmd>GpWhisperPrepend<cr>", "Whisper Prepend (before)" },
				p = { "<cmd>GpWhisperPopup<cr>", "Whisper Popup" },
				e = { "<cmd>GpWhisperEnew<cr>", "Whisper Enew" },
				n = { "<cmd>GpWhisperNew<cr>", "Whisper New" },
				v = { "<cmd>GpWhisperVnew<cr>", "Whisper Vnew" },
				t = { "<cmd>GpWhisperTabnew<cr>", "Whisper Tabnew" },
			},
		},
		-- ...
	}, {
		mode = "i", -- INSERT mode
		prefix = "",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = true,
	})
end

return {
	"robitx/gp.nvim",
	dev = not os.getenv("RUNNING_IN_DOCKER"),
	-- version = "v1.13.0",

	config = function()
		require("gp").setup(config)
		register_shortcuts()
	end,
}
