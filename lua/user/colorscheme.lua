local colorscheme = "darkplus"


-- vim.g.rehash256 = 1
-- vim.g.molokai_original = 1
-- local colorscheme = "molokai"

local colorscheme = "monokai"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
