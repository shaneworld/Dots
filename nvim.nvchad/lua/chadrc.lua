-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "rosepine",
  transparency = true,
}

M.ui = {
  statusline = {
    theme = "vscode_colored"
  }
}


return M
