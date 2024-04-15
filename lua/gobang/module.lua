---@class CustomModule
local M = {}

---@return boolean
M.is_gobang_available = function()
  return vim.fn.executable("gobang") == 1
end

---@return string
M.gobang_default_config_path = function()
  return vim.fn.substitute(vim.fn.system("echo $HOME/.config/gobang"), "\n", "", "") .. "/config.toml"
end

---@return string
M.gobang_get_config_path = function()
  local gobang_default_config_path = M.gobang_default_config_path()

  if vim.g.gobang_config_file_path == nil or vim.g.gobang_config_file_path == "" then
    print("gobang.nvim: gobang_config_file_path is not set or not a table. Using default config path")
    return gobang_default_config_path
  end

  if vim.fn.empty(vim.fn.glob(vim.g.gobang_config_file_path)) == 0 then
    return vim.g.gobang_config_file_path
  end

  print(
    "gobang.nvim: gobang_config_file_path "
      .. vim.g.gobang_config_file_path
      .. " could not be found. Using default config path"
  )

  return gobang_default_config_path
end

return M
