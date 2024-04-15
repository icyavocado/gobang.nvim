-- main module file
local module = require("gobang.module")
local open_floating_window = require("gobang.window").open_floating_window
local open_or_create_config = require("gobang.utils").open_or_create_config

GOBANG_BUFFER = nil
GOBANG_LOADED = false
vim.g.gobang_opened = 0
local prev_win = -1
local win = -1
local buffer = -1

---@class Config
---@field opt string Your config option
local config = {
  opt = "Hello!",
}

---@class MyModule
local M = {}

---@type Config
M.config = config

---@param args Config?
-- you can define your setup function here. Usually configurations can be merged, accepting outside params and
-- you can also put some validation here for those.
M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
end

local function on_exit(job_id, code, event)
  if code == 0 then
    return
  end

  GOBANG_BUFFER = nil
  GOBANG_LOADED = false
  vim.g.gobang_opened = 0
  vim.cmd("silent! :checktime")

  if vim.api.nvim_win_is_valid(prev_win) then
    vim.api.nvim_win_close(win, true)
    vim.api.nvim_set_current_win(prev_win)
    prev_win = -1
    if vim.api.nvim_buf_is_valid(buffer) and vim.api.nvim_buf_is_loaded(buffer) then
      vim.api.nvim_buf_delete(buffer, { force = true })
    end
    buffer = -1
    win = -1
  end
end

local function exec_gobang_command(cmd)
  if GOBANG_LOADED == false then
    vim.g.gobang_opened = 1
    vim.fn.termopen(cmd, { on_exit = on_exit })
  end
  vim.cmd("startinsert")
end

M.gobang = function()
  if module.is_gobang_available() ~= true then
    print("Please install gobang. Check the documentation for more information")
    return
  end

  prev_win = vim.api.nvim_get_current_win()
  win, buffer = open_floating_window()

  local cmd = "gobang"

  if vim.g.gobang_use_custom_config_file_path == 1 then
    local config_path = module.gobang_get_config_path()
    if type(config_path) == "table" then
      config_path = table.concat(config_path, ",")
      return
    end
    cmd = cmd .. " --config-file '" .. config_path .. "'"
  end

  exec_gobang_command(cmd)
end

M.gobang_config = function()
  local config_path = module.gobang_get_config_path()
  open_or_create_config(config_path)
end

return M
