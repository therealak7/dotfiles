vim.g.mapleader = " "
vim.g.maplocalleader = "/"
vim.g.have_nerd_font = true

local options = {
    termguicolors = true,                -- Enable 24 bits color in terminal
    guicursor = "a:block,i-ci-ve:ver25", -- Set the gui cursor to nothing for each mode
    showmode = false,                    -- Don't need to show mode
    mouse = "a",                         -- Enable mouse in all mode
    tabstop = 4,                         -- A tab is 4 spaces (display)
    shiftwidth = 4,                      -- Indent to 4 spaces
    softtabstop = 4,                     -- A tab is 4 spaces (insert mode)
    expandtab = true,                    -- Use spaces instead of tab character
    smartindent = true,                  -- Smart auto indent on new line
    breakindent = true,
    cursorline = true,                   -- Highlight the current line the cursor is on
    clipboard = "unnamedplus",           -- Use + register for yank, delete, change and put operation
    hidden = true,                       -- Make sure hidden buffer are not unloaded
    backup = false,                      -- Disable file backups
    undofile = true,
    writebackup = false,                 -- Disable file backup on save
    swapfile = false,                    -- Disable swap files
    laststatus = 3,                      -- Single status line for the whole frame
    signcolumn = "auto:4",               -- Show the sign colum (for gitsigns)
    number = true,                       -- Show line numbers
    relativenumber = true,               -- Use relative line numbers
    ignorecase = true,
    smartcase = true,
    scrolloff = 8,                       -- Keep at least 8 lines above the cursor.
    colorcolumn = "120",                 -- Color the 120 character as a limit for line length
    timeoutlen = 500,
    listchars = { tab = '» ', trail = '.', nbsp = '␣' },
}

for opt, val in pairs(options) do
    vim.opt[opt] = val
end

vim.o.inccommand = 'split'
