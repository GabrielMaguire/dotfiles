-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Disable LazyVim auto format on save
vim.g.autoformat = false

-- Enable code folding using treesitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- May need this. Prevents closing all folds when opening a file.
-- vim.opt.foldenable = false

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.conceallevel = 0
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
