return {
	"christoomey/vim-tmux-navigator",
	config = function()
		vim.g.tmux_navigator_no_mappings = 1
        vim.g.tmux_navigator_disable_when_zoomed = 1
	end,
}

