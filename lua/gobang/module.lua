---@class CustomModule
local M = {}

---@return boolean
M.is_gobang_available = function()
  return vim.fn.executable("gobang") == 1
end

return M
