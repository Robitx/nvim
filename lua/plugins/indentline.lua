local config = function()
	require("ibl").setup({
		indent = {
			char = "▏",
		},
        scope = {
            enabled = true,
        },
		exclude = {
			filetypes = {
				"help",
				"packer",
				"NvimTree",
			},

			buftypes = {
				"terminal",
				"nofile",
			},
		},
	})

	local hooks = require("ibl.hooks")
	hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
end

return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = config,
}
