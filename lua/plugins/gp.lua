local config = {
	-- directory for storing chat files
	chat_dir = "/zaloha/gp_chats",
	-- explicitly confirm deletion of a chat file
	chat_confirm_delete = false,

	chat_model = { model = "gpt-4-1106-preview", temperature = 1.1, top_p = 1 },
	command_model = { model = "gpt-4-1106-preview", temperature = 1.1, top_p = 1 },
}

local register_shortcuts = function()
	-- VISUAL mode mappings
	-- s, x, v modes are handled the same way by which_key
	require("which-key").register({
		-- ...
		["<C-g>"] = {
			c = { ":<C-u>'<,'>GpChatNew<cr>", "Visual Chat New" },
			v = { ":<C-u>'<,'>GpChatPaste<cr>", "Visual Chat Paste" },
			t = { ":<C-u>'<,'>GpChatToggle<cr>", "Visual Popup Chat" },

			["<C-x>"] = { ":'<,'>GpChatNew split<CR>", "Visual Chat New split" },
			["<C-v>"] = { ":'<,'>GpChatNew vsplit<CR>", "Visual Chat New vsplit" },
			["<C-t>"] = { ":'<,'>GpChatNew tabnew<CR>", "Visual Chat New tabnew" },

			r = { ":<C-u>'<,'>GpRewrite<cr>", "Visual Rewrite" },
			a = { ":<C-u>'<,'>GpAppend<cr>", "Visual Append" },
			b = { ":<C-u>'<,'>GpPrepend<cr>", "Visual Prepend" },
			e = { ":<C-u>'<,'>GpEnew<cr>", "Visual Enew" },
			p = { ":<C-u>'<,'>GpPopup<cr>", "Visual Popup" },
			s = { "<cmd>GpStop<cr>", "Stop" },

			-- optional Whisper commands
			w = { ":<C-u>'<,'>GpWhisper<cr>", "Whisper" },
			R = { ":<C-u>'<,'>GpWhisperRewrite<cr>", "Whisper Visual Rewrite" },
			A = { ":<C-u>'<,'>GpWhisperAppend<cr>", "Whisper Visual Append" },
			B = { ":<C-u>'<,'>GpWhisperPrepend<cr>", "Whisper Visual Prepend" },
			E = { ":<C-u>'<,'>GpWhisperEnew<cr>", "Whisper Visual Enew" },
			P = { ":<C-u>'<,'>GpWhisperPopup<cr>", "Whisper Visual Popup" },
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
			t = { "<cmd>GpChatToggle<cr>", "Toggle Popup Chat" },
			f = { "<cmd>GpChatFinder<cr>", "Chat Finder" },

			["<C-x>"] = { "<cmd>GpChatNew split<cr>", "New Chat split" },
			["<C-v>"] = { "<cmd>GpChatNew vsplit<cr>", "New Chat vsplit" },
			["<C-t>"] = { "<cmd>GpChatNew tabnew<cr>", "New Chat tabnew" },

			r = { "<cmd>GpRewrite<cr>", "Inline Rewrite" },
			a = { "<cmd>GpAppend<cr>", "Append" },
			b = { "<cmd>GpPrepend<cr>", "Prepend" },
			e = { "<cmd>GpEnew<cr>", "Enew" },
			p = { "<cmd>GpPopup<cr>", "Popup" },
			s = { "<cmd>GpStop<cr>", "Stop" },

			-- optional Whisper commands
			w = { "<cmd>GpWhisper<cr>", "Whisper" },
			R = { "<cmd>GpWhisperRewrite<cr>", "Whisper Inline Rewrite" },
			A = { "<cmd>GpWhisperAppend<cr>", "Whisper Append" },
			B = { "<cmd>GpWhisperPrepend<cr>", "Whisper Prepend" },
			E = { "<cmd>GpWhisperEnew<cr>", "Whisper Enew" },
			P = { "<cmd>GpWhisperPopup<cr>", "Whisper Popup" },
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
			t = { "<cmd>GpChatToggle<cr>", "Toggle Popup Chat" },
			f = { "<cmd>GpChatFinder<cr>", "Chat Finder" },

			["<C-x>"] = { "<cmd>GpChatNew split<cr>", "New Chat split" },
			["<C-v>"] = { "<cmd>GpChatNew vsplit<cr>", "New Chat vsplit" },
			["<C-t>"] = { "<cmd>GpChatNew tabnew<cr>", "New Chat tabnew" },

			r = { "<cmd>GpRewrite<cr>", "Inline Rewrite" },
			a = { "<cmd>GpAppend<cr>", "Append" },
			b = { "<cmd>GpPrepend<cr>", "Prepend" },
			e = { "<cmd>GpEnew<cr>", "Enew" },
			p = { "<cmd>GpPopup<cr>", "Popup" },
			s = { "<cmd>GpStop<cr>", "Stop" },

			-- optional Whisper commands
			w = { "<cmd>GpWhisper<cr>", "Whisper" },
			R = { "<cmd>GpWhisperRewrite<cr>", "Whisper Inline Rewrite" },
			A = { "<cmd>GpWhisperAppend<cr>", "Whisper Append" },
			B = { "<cmd>GpWhisperPrepend<cr>", "Whisper Prepend" },
			E = { "<cmd>GpWhisperEnew<cr>", "Whisper Enew" },
			P = { "<cmd>GpWhisperPopup<cr>", "Whisper Popup" },
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

	config = function()
		require("gp").setup(config)
		register_shortcuts()
	end,
}
