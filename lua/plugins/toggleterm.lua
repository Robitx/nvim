local config = function()
	local status_ok, toggleterm = pcall(require, "toggleterm")
	if not status_ok then
		return
	end

	toggleterm.setup({
		size = 20,
		open_mapping = [[<M-\>]],
		hide_numbers = true,
		shade_terminals = true,
		shading_factor = 2,
		start_in_insert = true,
		insert_mappings = true,
		persist_size = true,
		direction = "float",
		close_on_exit = true,
		shell = "zsh",
		float_opts = {
			border = "curved",
		},
	})
end

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = config,
}
