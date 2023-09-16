return {
	{
		"christoomey/vim-tmux-navigator",
		config = function()
			vim.g.tmux_navigator_no_mappings = 1
			vim.g.tmux_navigator_disable_when_zoomed = 1
		end,
	},
    {
        "RyanMillerC/better-vim-tmux-resizer",
        config = function()
            vim.g.tmux_resizer_no_mappings = 1
            vim.g.tmux_resizer_resize_count = 5
            vim.g.tmux_resizer_vertical_resize_count = 10
        end,
    }
}
