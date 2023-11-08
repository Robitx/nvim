vim.cmd([[
  "easy access to yank register
  vmap <C-p> "0p
  nmap <C-p> "0p

  " turn off search highlight <backspace><backspace>
  nnoremap <backspace><backspace> :nohlsearch<CR>
]])

-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Plugins --

-- DAP

-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
vim.keymap.set("n", "<F7>", "<cmd>lua require'dapui'.toggle()<cr>", { desc = "Debug: See last session result." })

-- keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
-- keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
-- keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
-- keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
-- keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
-- keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
-- keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
-- keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
-- keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- -- Basic debugging keymaps, feel free to change to your liking!
-- vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
-- vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
-- vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
-- vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
-- vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
-- vim.keymap.set("n", "<leader>B", function()
-- 	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
-- end, { desc = "Debug: Set Breakpoint" })

-- HOP
vim.api.nvim_set_keymap(
	"",
	"f",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
	{}
)
vim.api.nvim_set_keymap(
	"",
	"F",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
	{}
)
vim.api.nvim_set_keymap(
	"",
	"t",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>",
	{}
)
vim.api.nvim_set_keymap(
	"",
	"T",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>",
	{}
)
vim.api.nvim_set_keymap("", "s", "<cmd>lua require'hop'.hint_words({ })<cr>", {})

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

-- NORMAL mode mappings
local normal_mappings = {
	["<TAB>"] = { ":bnext<CR>", "Next buffer" },
	["<S-TAB>"] = { ":bprevious<CR>", "Previous buffer" },
	["<M-q>"] = { ":bdelete<CR>", "Close buffer" },
	["<M-h>"] = { ":TmuxResizeLeft<CR>", "Resize left" },
	["<M-j>"] = { ":TmuxResizeDown<CR>", "Resize down" },
	["<M-k>"] = { ":TmuxResizeUp<CR>", "Resize up" },
	["<M-l>"] = { ":TmuxResizeRight<CR>", "Resize right" },
	["<C-h>"] = { ":TmuxNavigateLeft<CR>", "Move to left window" },
	["<C-j>"] = { ":TmuxNavigateDown<CR>", "Move to bottom window" },
	["<C-k>"] = { ":TmuxNavigateUp<CR>", "Move to top window" },
	["<C-l>"] = { ":TmuxNavigateRight<CR>", "Move to right window" },
	["<C-w>"] = {
		["e"] = { "<cmd>enew<cr>", "New File in current window" },
		["<Up>"] = { "<cmd>resize -2<cr>", "Decrease window height" },
		["<Down>"] = { "<cmd>resize +2<cr>", "Increase window height" },
		["<Left>"] = { "<cmd>vertical resize -2<cr>", "Decrease window width" },
		["<Right>"] = { "<cmd>vertical resize +2<cr>", "Increase window width" },
	},
	["<leader>"] = {
		b = {
			"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
			"Buffers",
		},
		s = { "<cmd>w! | source %<cr>", "Save and source" },
		x = { "<cmd>Bdelete!<CR>", "Close Buffer" },
		w = { "<cmd>w!<CR>", "Save" },
		W = { "<cmd>w !sudo tee %<CR>", "Sudo Save" },
		e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
		h = { "<cmd>nohlsearch<CR>", "No Highlight" },
		Q = { "<cmd>q!<CR>", "Quit" },
		["/"] = { "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", "Toggle comment" },

		["A"] = { "<cmd>Alpha<cr>", "Alpha welcome screen" },
		f = {
			name = "Telescope",
			F = {
				"<cmd>Telescope find_files<cr>",
				"Find files with preview",
			},
			f = {
				"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
				"Find files",
			},
			b = {
				"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
				"Buffers",
			},
			t = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
			s = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
			h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
			M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
			r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
			R = { "<cmd>Telescope registers<cr>", "Registers" },
			k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
			c = { "<cmd>Telescope commands<cr>", "Commands" },
		},

		g = {
			name = "Git",
			-- g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
			j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
			k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
			l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
			p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
			r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
			R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
			s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
			u = {
				"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
				"Undo Stage Hunk",
			},
			o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
			b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
			c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
			d = {
				"<cmd>Gitsigns diffthis HEAD<cr>",
				"Diff",
			},
		},

		l = {
			name = "LSP",
			a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
			d = {
				"<cmd>Telescope lsp_document_diagnostics<cr>",
				"Document Diagnostics",
			},
			w = {
				"<cmd>Telescope lsp_workspace_diagnostics<cr>",
				"Workspace Diagnostics",
			},
			f = { "<cmd>lua require('conform').format({async = true})<cr>", "Format" },
			h = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help" },
			i = { "<cmd>LspInfo<cr>", "Info" },
			I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
			j = {
				"<cmd>lua vim.diagnostic.goto_next()<CR>",
				"Next Diagnostic",
			},
			k = {
				"<cmd>lua vim.diagnostic.goto_prev()<cr>",
				"Prev Diagnostic",
			},
			l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
			q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
			r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
			s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
			S = {
				"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
				"Workspace Symbols",
			},
		},

		c = {
			name = "Copilot",
			t = { "<cmd>lua require('copilot.suggestion').toggle_auto_trigger()<cr>", "Toggle" },
		},

		t = {
			name = "Terminal",
			f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
			h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
			v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
		},
	},
}

local normal_opts = {
	mode = "n", -- NORMAL mode
	prefix = "",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

-- VISUAL mode mappings
-- s, x, v modes are handled the same way by which_key
local visual_mappings = {
	["<leader>"] = {
		["/"] = {
			'<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>',
			"Toggle Comment",
		},
	},
	["p"] = { '"_dP', "Paste" },
	["<"] = { "<gv", "Shift Left" },
	[">"] = { ">gv", "Shift Right" },
}

local visual_opts = {
	mode = "v", -- VISUAL mode
	prefix = "",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

-- INSERT mode mappings
local insert_mappings = {
}

local insert_opts = {
	mode = "i", -- INSERT mode
	prefix = "",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

return {
	"folke/which-key.nvim",
	config = function()
		local status_ok, which_key = pcall(require, "which-key")
		if not status_ok then
			return
		end

		which_key.setup(setup)

		which_key.register(normal_mappings, normal_opts)
		which_key.register(visual_mappings, visual_opts)
		which_key.register(insert_mappings, insert_opts)
	end,
}
