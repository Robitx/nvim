local config = function()
	require("Comment").setup({
		pre_hook = function(ctx)
			local U = require("Comment.utils")

			local location = nil
			if ctx.ctype == U.ctype.blockwise then
				location = require("ts_context_commentstring.utils").get_cursor_location()
			elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
				location = require("ts_context_commentstring.utils").get_visual_start_location()
			end

			return require("ts_context_commentstring.internal").calculate_commentstring({
				key = ctx.ctype == U.ctype.linewise and "__default" or "__multiline",
				location = location,
			})
		end,
		mappings = false,
	})
end

return {
	{
		"numToStr/Comment.nvim",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		config = config,
	},
}
