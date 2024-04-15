if vim.fn.exists("g:loaded_gobang_nvim") ~= 0 then
  return
end

if vim.fn.exists("g:gobang_floating_window_scaling_factor") == 0 then
  vim.g.gobang_floating_window_scaling_factor = 0.9
end

if vim.fn.exists("g:gobang_floating_window_winblend") == 0 then
  vim.g.gobang_floating_window_winblend = 0
end

if vim.fn.exists("g:gobang_use_neovim_remote") == 0 then
  vim.g.gobang_use_neovim_remote = vim.fn.executable("nvr") and 1 or 0
end

if vim.fn.exists("g:gobang_floating_window_border_chars") == 0 then
  vim.g.gobang_floating_window_border_chars = {
    { "╭", "─", "╮" },
    { "│", " ", "│" },
    { "╰", "─", "╯" },
  }
end

if vim.fn.exists("g:gobang_use_custom_config_file_path") == 0 then
  vim.g.gobang_use_custom_config_file_path = 0
end

if vim.fn.exists("g:gobang_config_file_path") == 0 then
  vim.g.gobang_config_file_path = ""
end

vim.cmd("command! Gobang lua require('gobang').gobang()")

vim.g.loaded_gobang_nvim = 1
