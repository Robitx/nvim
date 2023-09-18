local config = function()
	local cmp_status_ok, cmp = pcall(require, "cmp")
	if not cmp_status_ok then
		return
	end

	local snip_status_ok, luasnip = pcall(require, "luasnip")
	if not snip_status_ok then
		return
	end

	luasnip.config.setup({})

	local check_backspace = function()
		local col = vim.fn.col(".") - 1
		return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
	end

	local kind_icons = {
		Text = "",
		Method = "",
		Function = "",
		Constructor = "",
		Field = "",
		Variable = "",
		Class = "",
		Interface = "",
		Module = "",
		Property = "",
		Unit = "",
		Value = "",
		Enum = "",
		Keyword = "",
		Snippet = "",
		Color = "",
		File = "",
		Reference = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "",
		Event = "",
		Operator = "",
		TypeParameter = "",
	}

	cmp.event:on("complete_done", function()
		vim.b.copilot_suggestion_hidden = false
	end)

	cmp.event:on("menu_opened", function()
		vim.b.copilot_suggestion_hidden = true
	end)

	cmp.event:on("menu_closed", function()
		vim.b.copilot_suggestion_hidden = false
	end)

	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		completion = {
			autocomplete = false,
		},

		mapping = cmp.mapping.preset.insert({
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
			["<M-Space>"] = cmp.mapping(function()
				require("copilot.suggestion").dismiss()
				cmp.complete()
			end, { "i", "c" }),
			["<C-e>"] = cmp.mapping({
				i = function()
					cmp.mapping.abort()
				end,
				c = function()
					cmp.mapping.close()
				end,
			}),
			-- Accept currently selected item. If none selected, `select` first item.
			-- Set `select` to `false` to only confirm explicitly selected items.
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif require("copilot.suggestion").is_visible() then
					require("copilot.suggestion").accept()
				elseif luasnip.expandable() then
					luasnip.expand()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif check_backspace() then
					fallback()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
		}),
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				local kind = vim_item.kind
				vim_item.kind = kind_icons[vim_item.kind]
				-- vim_item.kind = string.format("%s %s  ", kind_icons[vim_item.kind], vim_item.kind)
				vim_item.menu = ({
					nvim_lsp = "[LSP]",
					nvim_lua = "[Lua]",
					luasnip = "[Snip]",
					buffer = "[Buffer]",
					path = "[Path]",
					["vim-dadbod-completion"] = "[DB]",
					emoji = "[Emoji]",
				})[entry.source.name]
				-- prepend menu with whitespace
				vim_item.menu = string.format("%s %s", kind, vim_item.menu)
				return vim_item
			end,
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "luasnip" },
			{ name = "buffer" },
			{ name = "path" },
		},
		confirm_opts = {
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		},
		preselect = { cmp.PreselectMode.None },
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		experimental = {
			ghost_text = false,
		},
	})

	local autocomplete_group = vim.api.nvim_create_augroup("vimrc_autocompletion", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "sql", "mysql", "plsql" },
		callback = function()
			cmp.setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
		end,
		group = autocomplete_group,
	})

	-- cmp.setup({
	-- 	mapping = cmp.mapping.preset.insert({
	-- 		["<C-n>"] = cmp.mapping.select_next_item(),
	-- 		["<C-p>"] = cmp.mapping.select_prev_item(),
	-- 		["<C-d>"] = cmp.mapping.scroll_docs(-4),
	-- 		["<C-f>"] = cmp.mapping.scroll_docs(4),
	-- 		["<C-Space>"] = cmp.mapping.complete({}),
	-- 		["<CR>"] = cmp.mapping.confirm({
	-- 			behavior = cmp.ConfirmBehavior.Replace,
	-- 			select = true,
	-- 		}),
	-- 		["<Tab>"] = cmp.mapping(function(fallback)
	-- 			if cmp.visible() then
	-- 				cmp.select_next_item()
	-- 			elseif luasnip.expand_or_locally_jumpable() then
	-- 				luasnip.expand_or_jump()
	-- 			else
	-- 				fallback()
	-- 			end
	-- 		end, { "i", "s" }),
	-- 		["<S-Tab>"] = cmp.mapping(function(fallback)
	-- 			if cmp.visible() then
	-- 				cmp.select_prev_item()
	-- 			elseif luasnip.locally_jumpable(-1) then
	-- 				luasnip.jump(-1)
	-- 			else
	-- 				fallback()
	-- 			end
	-- 		end, { "i", "s" }),
	-- 	}),
	-- })
end

return {
	-- Autocompletion
	"hrsh7th/nvim-cmp",
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",

		"rafamadriz/friendly-snippets", -- a bunch of snippets to use

		-- Adds LSP completion capabilities
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-cmdline", -- command line Completion

		-- Adds a number of user-friendly snippets
		"rafamadriz/friendly-snippets",

		"neovim/nvim-lspconfig",

		"zbirenbaum/copilot.lua",

		"hrsh7th/cmp-buffer", -- buffer completions
		"hrsh7th/cmp-path", -- path completions
		"hrsh7th/cmp-nvim-lua",
	},
	config = config,
}
