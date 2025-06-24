
-- BASIC NEOVIM CONFIGS --
--vim.cmd("set relativenumber")  > The vimsscript way [everything inside vim.cmd is a vimscript string]
--vim.opt.relativenumber = true  > The neovim lua way
require("config.options")

-- REMAPS --
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true, silent = true }) -- remap jj to esc in insert mode

-- SETTING LEADER KEY --
-- set to space inside config.lazy-
vim.g.mapleader = " "
vim.g.maplocalleader = "//"

-- LAZY PACKAGE MANAGER --
require("config.lazy")

-- KEYMAPS --
require("config.keymaps")

-- COLORSCHEME --
vim.cmd.colorscheme "tokyonight-storm"
