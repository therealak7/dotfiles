
-- BASIC NEOVIM CONFIGS --
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
--vim.cmd("set relativenumber")
vim.opt.number = true --dont know what this do
vim.opt.relativenumber = true
vim.opt.signcolumn = "number" --dont know what this do

-- REMAPS --
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true, silent = true }) -- remap jj to esc in insert mode


-- LAZY PACKAGE MANAGER --
require("config.lazy")
