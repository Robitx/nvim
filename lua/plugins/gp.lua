return {
	"robitx/gp.nvim",
	dev = not os.getenv("RUNNING_IN_DOCKER"),
	dependencies = {
		"hrsh7th/nvim-cmp",
		"folke/which-key.nvim",
	},
	-- branch = "codebase_cleanup",
	-- version = "v1.13.0",

	config = function()
		local ts_picker = function()
			local pickers = require("telescope.pickers")
			local finders = require("telescope.finders")
			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")
			local conf = require("telescope.config").values

			local models = function(opts)
				local buf = vim.api.nvim_get_current_buf()
				local file_name = vim.api.nvim_buf_get_name(buf)
				local is_chat = require("gp").not_chat(buf, file_name) == nil

				opts = opts or {}
				pickers
					.new(opts, {
						prompt_title = "Models",
						finder = finders.new_table({
							results = is_chat and require("gp")._chat_agents or require("gp")._command_agents,
						}),
						sorter = conf.generic_sorter(opts),
						attach_mappings = function(prompt_bufnr)
							actions.select_default:replace(function()
								local selection = action_state.get_selected_entry()
								actions.close(prompt_bufnr)
								require("gp").cmd.Agent({ args = selection[1] })
							end)
							return true
						end,
					})
					:find()
			end

			vim.keymap.set("n", "<C-g>z", function()
				models(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, {
				noremap = true,
				silent = false,
				nowait = true,
				desc = "GPT prompt Choose Agent",
			})
		end

		ts_picker()

		local conf = {
			log_sensitive = true,
			-- image_prompt_prefix_template = "dummy",
			-- image_prompt_save = "dummy",
			-- image_agents = {
			-- 	{ name == "dummy", disable = true },
			-- },
			-- image_dir = (os.getenv("TMPDIR") or os.getenv("TEMP") or "/tmp") .. "/gp_images",
			image = {
				-- disable = true,
				-- openai_api_key = "dummy",
				-- openai_api_key = os.getenv("OPENAI_API_KEY"),

				store_dir = "/tmp/gp_images_test2",

				agents = {
					{
						disable = true,
						name = "DALL-E-3-1024x1024-vivid",
					},

					-- {
					-- 	name = "invalid_agent",
					-- },

					{
						name = "DALL-E-3-1024x1024-natural-dummy",
						model = "dall-e-3",
						quality = "standard",
						style = "natural",
						size = "1024x1024",
					},
				},
			},

			default_chat_agent = nil,
			default_command_agent = nil,

			-- directory for storing chat files
			-- chat_dir = "/backup/gp_chats",
			chat_dir = "/backup/notes",
			-- explicitly confirm deletion of a chat file
			chat_confirm_delete = false,

			-- chat_prompt_buf_type = true,

			whisper = {
				-- disable = true,
				-- endpoint = "http://localhost:8000/v1/audio/transcriptions",
				endpoint = "https://api.openai.com/v1/audio/transcriptions",
			},

			-- whisper_api_endpoint = "https://api.openai.com/v1/audio/transcriptions",
			-- whisper_api_endpoint = "http://localhost:8000/v1/audio/transcriptions",
			--          whisper_dir = "/tmp/gp_whispers",

			-- chat_template = require("gp.defaults").short_chat_template,
			-- chat_template = require("gp.defaults").chat_template,

			-- -- deprecated options for ocasional testing
			-- chat_model = "test",
			-- openai_api_endpoint = "blah",

			providers = {
				openai = {
					-- disable = true,
					endpoint = "https://api.openai.com/v1/chat/completions",
					-- secret = os.getenv("OPENAI_API_KEY"),
					-- secret = { "bash", "-c", "cat /persist/secrets/openai_api_key" },
				},

				-- azure = {...},

				copilot = {
					endpoint = "https://api.githubcopilot.com/chat/completions",
					secret = {
						"bash",
						"-c",
						"cat ~/.config/github-copilot/hosts.json | sed -e 's/.*oauth_token...//;s/\".*//'",
					},
				},

				pplx = {
					endpoint = "https://api.perplexity.ai/chat/completions",
					secret = os.getenv("PPLX_API_KEY_DUMMY"),
					-- secret = "dummy",
				},

				ollama = {
					endpoint = "http://localhost:11434/v1/chat/completions",
				},

				googleai = {
					endpoint = "https://generativelanguage.googleapis.com/v1beta/models/{{model}}:streamGenerateContent?key={{secret}}",
					secret = os.getenv("GOOGLEAI_API_KEY"),
				},

				anthropic = {
					endpoint = "https://api.anthropic.com/v1/messages",
					secret = os.getenv("ANTHROPIC_API_KEY"),
				},
			},

			agents = {
				{
					name = "ChatGPT3-5",
					disable = true,
				},
				{ name = "ChatOllamaLlama3", disable = true },
				{ name = "CodeOllamaLlama3", disable = true },
				{
					name = "MyCustomAgent",
					provider = "copilot",
					chat = true,
					command = true,
					model = { model = "gpt-4-turbo" },
					system_prompt = "Answer any query with just: Sure thing..",
				},
				{
					provider = "ollama",
					name = "ChatOllamaDeepseekCoderV2",
					chat = true,
					command = false,
					model = {
						model = "deepseek-coder-v2",
						num_ctx = 8192,
					},
					system_prompt = "You are a general AI assistant.",
				},
				{
					provider = "ollama",
					name = "CodeOllamaDeepseekCoderV2",
					chat = false,
					command = true,
					model = {
						model = "deepseek-coder-v2",
						temperature = 1.9,
						top_p = 1,
						num_ctx = 8192,
					},
					system_prompt = "You are an AI working as a code editor providing answers.\n\n"
						.. "Use 4 SPACES FOR INDENTATION.\n"
						.. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
						.. "START AND END YOUR ANSWER WITH:\n\n```",
				},
			},

			hooks = {
				Explain = function(gp, params)
					local template = "I have the following code from {{filename}}:\n\n"
						.. "```{{filetype}}\n{{selection}}\n```\n\n"
						.. "Please respond by explaining the code above."
					local agent = gp.get_chat_agent()
					gp.Prompt(params, gp.Target.popup, agent, template)
				end,

				Root = function(gp, params)
					local fgr = gp._H.find_git_root()
					local gr = gp._H.get_git_root(fgr)
					print("git root: ", gr)
					print("git root: ", fgr)
				end,
				-- example of adding command which writes unit tests for the selected code
				Joke = function(gp, params)
					local template = "Tell me random joke using pseudo code."
					local agent = gp.get_command_agent()
					gp.Prompt(params, gp.Target.vnew, agent, template)
				end,

				-- example of adding command which writes unit tests for the selected code
				OldJoke = function(gp, params)
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

				-- example of adding command which opens new chat dedicated for translation
				Translator = function(gp, params)
					local chat_system_prompt = "You are a Translator, please translate between English and Chinese."
					gp.cmd.ChatNew(params, chat_system_prompt)

					-- -- you can also create a chat with a specific fixed agent like this:
					-- local agent = gp.get_chat_agent("ChatGPT4o")
					-- gp.cmd.ChatNew(params, chat_system_prompt, agent)
				end,
				-- example of adding command which opens new chat dedicated for translation
				OldTranslator = function(gp, params)
					local agent = gp.get_command_agent()
					local chat_system_prompt = "You are a Translator, please translate between English and Chinese."
					gp.cmd.ChatNew(params, agent.model, chat_system_prompt)
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
			require("which-key").add({
				-- VISUAL mode mappings
				-- s, x, v modes are handled the same way by which_key
				{
					mode = { "v" },
					nowait = true,
					remap = false,
					{ "<C-g><C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", desc = "ChatNew tabnew" },
					{ "<C-g><C-v>", ":<C-u>'<,'>GpChatNew vsplit<cr>", desc = "ChatNew vsplit" },
					{ "<C-g><C-x>", ":<C-u>'<,'>GpChatNew split<cr>", desc = "ChatNew split" },
					{ "<C-g>a", ":<C-u>'<,'>GpAppend<cr>", desc = "Visual Append (after)" },
					{ "<C-g>b", ":<C-u>'<,'>GpPrepend<cr>", desc = "Visual Prepend (before)" },
					{ "<C-g>c", ":<C-u>'<,'>GpChatNew<cr>", desc = "Visual Chat New" },
					{ "<C-g>g", group = "generate into new .." },
					{ "<C-g>ge", ":<C-u>'<,'>GpEnew<cr>", desc = "Visual GpEnew" },
					{ "<C-g>gn", ":<C-u>'<,'>GpNew<cr>", desc = "Visual GpNew" },
					{ "<C-g>gp", ":<C-u>'<,'>GpPopup<cr>", desc = "Visual Popup" },
					{ "<C-g>gt", ":<C-u>'<,'>GpTabnew<cr>", desc = "Visual GpTabnew" },
					{ "<C-g>gv", ":<C-u>'<,'>GpVnew<cr>", desc = "Visual GpVnew" },
					{ "<C-g>i", ":<C-u>'<,'>GpImplement<cr>", desc = "Implement selection" },
					{ "<C-g>n", "<cmd>GpNextAgent<cr>", desc = "Next Agent" },
					{ "<C-g>p", ":<C-u>'<,'>GpChatPaste<cr>", desc = "Visual Chat Paste" },
					{ "<C-g>r", ":<C-u>'<,'>GpRewrite<cr>", desc = "Visual Rewrite" },
					{ "<C-g>s", "<cmd>GpStop<cr>", desc = "GpStop" },
					{ "<C-g>t", ":<C-u>'<,'>GpChatToggle<cr>", desc = "Visual Toggle Chat" },
					{ "<C-g>w", group = "Whisper" },
					{ "<C-g>wa", ":<C-u>'<,'>GpWhisperAppend<cr>", desc = "Whisper Append" },
					{ "<C-g>wb", ":<C-u>'<,'>GpWhisperPrepend<cr>", desc = "Whisper Prepend" },
					{ "<C-g>we", ":<C-u>'<,'>GpWhisperEnew<cr>", desc = "Whisper Enew" },
					{ "<C-g>wn", ":<C-u>'<,'>GpWhisperNew<cr>", desc = "Whisper New" },
					{ "<C-g>wp", ":<C-u>'<,'>GpWhisperPopup<cr>", desc = "Whisper Popup" },
					{ "<C-g>wr", ":<C-u>'<,'>GpWhisperRewrite<cr>", desc = "Whisper Rewrite" },
					{ "<C-g>wt", ":<C-u>'<,'>GpWhisperTabnew<cr>", desc = "Whisper Tabnew" },
					{ "<C-g>wv", ":<C-u>'<,'>GpWhisperVnew<cr>", desc = "Whisper Vnew" },
					{ "<C-g>ww", ":<C-u>'<,'>GpWhisper<cr>", desc = "Whisper" },
					{ "<C-g>x", ":<C-u>'<,'>GpContext<cr>", desc = "Visual GpContext" },
					{ "<C-g>e", ":<C-u>'<,'>GpExplain<cr>", desc = "Explain Selection" },
				},

				-- NORMAL mode mappings
				{
					mode = { "n" },
					nowait = true,
					remap = false,
					{ "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", desc = "New Chat tabnew" },
					{ "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>", desc = "New Chat vsplit" },
					{ "<C-g><C-x>", "<cmd>GpChatNew split<cr>", desc = "New Chat split" },
					{ "<C-g>a", "<cmd>GpAppend<cr>", desc = "Append (after)" },
					{ "<C-g>b", "<cmd>GpPrepend<cr>", desc = "Prepend (before)" },
					{ "<C-g>c", "<cmd>GpChatNew<cr>", desc = "New Chat" },
					{ "<C-g>f", "<cmd>GpChatFinder<cr>", desc = "Chat Finder" },
					{ "<C-g>g", group = "generate into new .." },
					{ "<C-g>ge", "<cmd>GpEnew<cr>", desc = "GpEnew" },
					{ "<C-g>gn", "<cmd>GpNew<cr>", desc = "GpNew" },
					{ "<C-g>gp", "<cmd>GpPopup<cr>", desc = "Popup" },
					{ "<C-g>gt", "<cmd>GpTabnew<cr>", desc = "GpTabnew" },
					{ "<C-g>gv", "<cmd>GpVnew<cr>", desc = "GpVnew" },
					{ "<C-g>n", "<cmd>GpNextAgent<cr>", desc = "Next Agent" },
					{ "<C-g>r", "<cmd>GpRewrite<cr>", desc = "Inline Rewrite" },
					{ "<C-g>s", "<cmd>GpStop<cr>", desc = "GpStop" },
					{ "<C-g>t", "<cmd>GpChatToggle<cr>", desc = "Toggle Chat" },
					{ "<C-g>w", group = "Whisper" },
					{ "<C-g>wa", "<cmd>GpWhisperAppend<cr>", desc = "Whisper Append (after)" },
					{ "<C-g>wb", "<cmd>GpWhisperPrepend<cr>", desc = "Whisper Prepend (before)" },
					{ "<C-g>we", "<cmd>GpWhisperEnew<cr>", desc = "Whisper Enew" },
					{ "<C-g>wn", "<cmd>GpWhisperNew<cr>", desc = "Whisper New" },
					{ "<C-g>wp", "<cmd>GpWhisperPopup<cr>", desc = "Whisper Popup" },
					{ "<C-g>wr", "<cmd>GpWhisperRewrite<cr>", desc = "Whisper Inline Rewrite" },
					{ "<C-g>wt", "<cmd>GpWhisperTabnew<cr>", desc = "Whisper Tabnew" },
					{ "<C-g>wv", "<cmd>GpWhisperVnew<cr>", desc = "Whisper Vnew" },
					{ "<C-g>ww", "<cmd>GpWhisper<cr>", desc = "Whisper" },
					{ "<C-g>x", "<cmd>GpContext<cr>", desc = "Toggle GpContext" },
				},

				-- INSERT mode mappings
				{
					mode = { "i" },
					nowait = true,
					remap = false,
					{ "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", desc = "New Chat tabnew" },
					{ "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>", desc = "New Chat vsplit" },
					{ "<C-g><C-x>", "<cmd>GpChatNew split<cr>", desc = "New Chat split" },
					{ "<C-g>a", "<cmd>GpAppend<cr>", desc = "Append (after)" },
					{ "<C-g>b", "<cmd>GpPrepend<cr>", desc = "Prepend (before)" },
					{ "<C-g>c", "<cmd>GpChatNew<cr>", desc = "New Chat" },
					{ "<C-g>f", "<cmd>GpChatFinder<cr>", desc = "Chat Finder" },
					{ "<C-g>g", group = "generate into new .." },
					{ "<C-g>ge", "<cmd>GpEnew<cr>", desc = "GpEnew" },
					{ "<C-g>gn", "<cmd>GpNew<cr>", desc = "GpNew" },
					{ "<C-g>gp", "<cmd>GpPopup<cr>", desc = "Popup" },
					{ "<C-g>gt", "<cmd>GpTabnew<cr>", desc = "GpTabnew" },
					{ "<C-g>gv", "<cmd>GpVnew<cr>", desc = "GpVnew" },
					{ "<C-g>n", "<cmd>GpNextAgent<cr>", desc = "Next Agent" },
					{ "<C-g>r", "<cmd>GpRewrite<cr>", desc = "Inline Rewrite" },
					{ "<C-g>s", "<cmd>GpStop<cr>", desc = "GpStop" },
					{ "<C-g>t", "<cmd>GpChatToggle<cr>", desc = "Toggle Chat" },
					{ "<C-g>w", group = "Whisper" },
					{ "<C-g>wa", "<cmd>GpWhisperAppend<cr>", desc = "Whisper Append (after)" },
					{ "<C-g>wb", "<cmd>GpWhisperPrepend<cr>", desc = "Whisper Prepend (before)" },
					{ "<C-g>we", "<cmd>GpWhisperEnew<cr>", desc = "Whisper Enew" },
					{ "<C-g>wn", "<cmd>GpWhisperNew<cr>", desc = "Whisper New" },
					{ "<C-g>wp", "<cmd>GpWhisperPopup<cr>", desc = "Whisper Popup" },
					{ "<C-g>wr", "<cmd>GpWhisperRewrite<cr>", desc = "Whisper Inline Rewrite" },
					{ "<C-g>wt", "<cmd>GpWhisperTabnew<cr>", desc = "Whisper Tabnew" },
					{ "<C-g>wv", "<cmd>GpWhisperVnew<cr>", desc = "Whisper Vnew" },
					{ "<C-g>ww", "<cmd>GpWhisper<cr>", desc = "Whisper" },
					{ "<C-g>x", "<cmd>GpContext<cr>", desc = "Toggle GpContext" },
				},
			})
		end

		require("gp").setup(conf)
		register_shortcuts()
	end,
}
