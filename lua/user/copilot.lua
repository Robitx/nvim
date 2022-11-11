local status_ok, copilot = pcall(require, "copilot")
if not status_ok then
	return
end

copilot.setup({
	panel = {
		enabled = true,
		auto_refresh = true,
		keymap = {
			jump_prev = "[[",
			jump_next = "]]",
			accept = "<M-a>",
			refresh = "gr",
			open = "<M-o>",
		},
	},
	suggestion = {
		enabled = true,
		auto_trigger = true,
		debounce = 75,
		keymap = {
			accept = "<M-a>",
			next = "<M-]>",
			prev = "<M-[>",
			dismiss = "<M-d>",
		},
	},
	filetypes = {
		yaml = false,
		markdown = false,
		help = false,
		gitcommit = false,
		gitrebase = false,
		hgcommit = false,
		svn = false,
		cvs = false,
		["."] = false,
	},
	-- Node version must be < 18
	copilot_node_command = vim.fn.expand("$HOME") .. "/.nvm/versions/node/v16.18.1/bin/node",
	plugin_manager_path = vim.fn.stdpath("data") .. "/site/pack/packer",
	server_opts_overrides = {
		trace = "verbose",
		settings = {
			advanced = {
				listCount = 10, -- #completions for panel
				inlineSuggestCount = 5, -- #completions for getCompletions
			},
		},
	},
})
