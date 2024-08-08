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
	-- operators = { gc = "Comments" },
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	keys = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	-- window = {
	-- 	border = "rounded", -- none, single, double, shadow
	-- 	position = "bottom", -- bottom, top
	-- 	margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
	-- 	padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
	-- 	winblend = 0,
	-- },
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	-- ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	-- hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	desc = {
		{ "<Plug>%(?(.*)%)?", "%1" },
		{ "^%+", "" },
		{ "<[cC]md>", "" },
		{ "<[cC][rR]>", "" },
		{ "<[sS]ilent>", "" },
		{ "^lua%s+", "" },
		{ "^call%s+", "" },
		{ "^:%s*", "" },
	},
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	-- triggers_blacklist = {
	-- 	-- list of mode / prefixes that should never be hooked by WhichKey
	-- 	-- this is mostly relevant for key maps that start with a native binding
	-- 	-- most people should not need to change this
	-- 	i = { "j", "k" },
	-- 	v = { "j", "k" },
	-- },
}

-- NORMAL mode mappings
local normal_mappings = {
	{
		mode = { "n" },
		nowait = true,
		remap = false,
		{ "<C-h>", ":TmuxNavigateLeft<CR>", desc = "Move to left window" },
		{ "<C-j>", ":TmuxNavigateDown<CR>", desc = "Move to bottom window" },
		{ "<C-k>", ":TmuxNavigateUp<CR>", desc = "Move to top window" },
		{ "<C-l>", ":TmuxNavigateRight<CR>", desc = "Move to right window" },
		{ "<C-w><Down>", "<cmd>resize +2<cr>", desc = "Increase window height" },
		{ "<C-w><Left>", "<cmd>vertical resize -2<cr>", desc = "Decrease window width" },
		{ "<C-w><Right>", "<cmd>vertical resize +2<cr>", desc = "Increase window width" },
		{ "<C-w><Up>", "<cmd>resize -2<cr>", desc = "Decrease window height" },
		{ "<C-w>e", "<cmd>enew<cr>", desc = "New File in current window" },
		{ "<M-h>", ":TmuxResizeLeft<CR>", desc = "Resize left" },
		{ "<M-j>", ":TmuxResizeDown<CR>", desc = "Resize down" },
		{ "<M-k>", ":TmuxResizeUp<CR>", desc = "Resize up" },
		{ "<M-l>", ":TmuxResizeRight<CR>", desc = "Resize right" },
		{ "<M-q>", ":bdelete<CR>", desc = "Close buffer" },
		{ "<S-TAB>", ":bprevious<CR>", desc = "Previous buffer" },
		{ "<TAB>", ":bnext<CR>", desc = "Next buffer" },
		{
			"<leader>/",
			"<cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
			desc = "Toggle comment",
		},
		{ "<leader>A", "<cmd>Alpha<cr>", desc = "Alpha welcome screen" },
		{ "<leader>Q", "<cmd>q!<CR>", desc = "Quit" },
		{ "<leader>W", "<cmd>w !sudo tee %<CR>", desc = "Sudo Save" },
		{
			"<leader>b",
			"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
			desc = "Buffers",
		},
		{ "<leader>c", group = "Copilot" },
		{
			"<leader>ct",
			"<cmd>lua require('copilot.suggestion').toggle_auto_trigger()<cr>",
			desc = "Toggle",
		},
		{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
		{ "<leader>f", group = "Telescope" },
		{
			"<leader>fF",
			"<cmd>Telescope find_files<cr>",
			desc = "Find files with preview",
		},
		{ "<leader>fM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
		{ "<leader>fR", "<cmd>Telescope registers<cr>", desc = "Registers" },
		{
			"<leader>fb",
			"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
			desc = "Buffers",
		},
		{ "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
		{
			"<leader>ff",
			"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
			desc = "Find files",
		},
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File" },
		{ "<leader>fs", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
		{ "<leader>ft", "<cmd>Telescope live_grep theme=ivy<cr>", desc = "Find Text" },
		{ "<leader>g", group = "Git" },
		{
			"<leader>gR",
			"<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
			desc = "Reset Buffer",
		},
		{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
		{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit" },
		{ "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff" },
		{
			"<leader>gj",
			"<cmd>lua require 'gitsigns'.next_hunk()<cr>",
			desc = "Next Hunk",
		},
		{
			"<leader>gk",
			"<cmd>lua require 'gitsigns'.prev_hunk()<cr>",
			desc = "Prev Hunk",
		},
		{ "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame" },
		{ "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file" },
		{
			"<leader>gp",
			"<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
			desc = "Preview Hunk",
		},
		{
			"<leader>gr",
			"<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
			desc = "Reset Hunk",
		},
		{
			"<leader>gs",
			"<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
			desc = "Stage Hunk",
		},
		{
			"<leader>gu",
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			desc = "Undo Stage Hunk",
		},
		{ "<leader>h", "<cmd>nohlsearch<CR>", desc = "No Highlight" },
		{ "<leader>l", group = "LSP" },
		{ "<leader>lI", "<cmd>LspInstallInfo<cr>", desc = "Installer Info" },
		{
			"<leader>lS",
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			desc = "Workspace Symbols",
		},
		{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
		{
			"<leader>ld",
			"<cmd>Telescope lsp_document_diagnostics<cr>",
			desc = "Document Diagnostics",
		},
		{
			"<leader>lf",
			"<cmd>lua require('conform').format({async = true})<cr>",
			desc = "Format",
		},
		{
			"<leader>lh",
			"<cmd>lua vim.lsp.buf.signature_help()<CR>",
			desc = "Signature help",
		},
		{ "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
		{
			"<leader>lj",
			"<cmd>lua vim.diagnostic.goto_next()<CR>",
			desc = "Next Diagnostic",
		},
		{
			"<leader>lk",
			"<cmd>lua vim.diagnostic.goto_prev()<cr>",
			desc = "Prev Diagnostic",
		},
		{ "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
		{
			"<leader>lq",
			"<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>",
			desc = "Quickfix",
		},
		{ "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
		{
			"<leader>ls",
			"<cmd>Telescope lsp_document_symbols<cr>",
			desc = "Document Symbols",
		},
		{
			"<leader>lw",
			"<cmd>Telescope lsp_workspace_diagnostics<cr>",
			desc = "Workspace Diagnostics",
		},
		{ "<leader>s", "<cmd>w! | source %<cr>", desc = "Save and source" },
		{ "<leader>t", group = "Terminal" },
		{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float" },
		{
			"<leader>th",
			"<cmd>ToggleTerm size=10 direction=horizontal<cr>",
			desc = "Horizontal",
		},
		{
			"<leader>tv",
			"<cmd>ToggleTerm size=80 direction=vertical<cr>",
			desc = "Vertical",
		},
		{ "<leader>w", "<cmd>w!<CR>", desc = "Save" },
		{ "<leader>x", "<cmd>Bdelete!<CR>", desc = "Close Buffer" },
	},
}

-- VISUAL mode mappings
-- s, x, v modes are handled the same way by which_key
local visual_mappings = {
	{
		mode = { "v" },
		nowait = true,
		remap = false,
		{ "<", "<gv", desc = "Shift Left" },
		{
			"<leader>/",
			'<esc><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<cr>',
			desc = "Toggle Comment",
		},
		{ ">", ">gv", desc = "Shift Right" },
		{ "p", '"_dP', desc = "Paste" },
	},
}

-- INSERT mode mappings
local insert_mappings = {}

return {
	"folke/which-key.nvim",
    version = "3.4.0",
	config = function()
		local status_ok, which_key = pcall(require, "which-key")
		if not status_ok then
			return
		end

		which_key.setup(setup)

		which_key.add(normal_mappings)
		which_key.add(visual_mappings)
		which_key.add(insert_mappings)
	end,
}
