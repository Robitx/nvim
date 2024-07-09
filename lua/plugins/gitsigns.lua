local config = function()
	local status_ok, gitsigns = pcall(require, "gitsigns")
	if not status_ok then
		return
	end

	gitsigns.setup({
		signs = {
			add = {
				text = "▎",
			},
			change = {
				text = "▎",
			},
			delete = {
				text = "契",
			},
			topdelete = {
				text = "契",
			},
			changedelete = {
				text = "▎",
			},
		},
	})
end

-- Git
return {
	"lewis6991/gitsigns.nvim",
	config = config,
}
