---@class CustomModule
local M = {}

M.open_or_create_config = function(path)
  if vim.fn.empty(vim.fn.glob(path)) == 1 then
    vim.cmd("silent! !mkdir -p " .. vim.fn.fnamemodify(path, ":h"))
    vim.cmd("silent! !touch " .. path)
  end
  vim.cmd("edit " .. path)
end

return M
