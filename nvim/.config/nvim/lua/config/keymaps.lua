local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', '<Esc>', '<cmd>nohlsearch<CR>') -- clear highlights on search when pressing ESC key

-- add newline without entering into insert mode
map('n', '<CR>', 'm`o<Esc>``')
map('n', '<S-CR>', 'm`O<Esc>``')

map('i', "jj", '<Esc>', opts) -- remap jj jk and kj to esc while in esc mode
map('i', "jk", '<Esc>', opts) -- remap jj jk and kj to esc while in esc mode
map('i', "kj", '<Esc>', opts) -- remap jj jk and kj to esc while in esc mode

map('i', "WW", '<Esc>:w<CR>', opts) -- write in insert mode with WW
map('i', "ZZ", '<Esc>:wq<CR>', opts) -- write and quit in insert mode with WW
map('n', "WW", ':w<CR>', opts) -- write in normal mode with WW
map('n', "ZZ", ':wq<CR>', opts) -- write and quit in normal mode with WW

--  Use CTRL+<hjkl> to switch between window splits
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- move lines up or down in visyal mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

-- help add or remove indent repeatedly 
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Copies or Yank to system clipboard
map("n", "<leader>Y", [["+Y]], opts)

-- leader d delete wont remember as yanked/clipboard when delete pasting
map({ "n", "v" }, "<leader>d", [["_d]])

-- tab stuff
map("n", "<leader>to", "<cmd>tabnew<CR>")   --open new tab
map("n", "<leader>tx", "<cmd>tabclose<CR>") --close current tab
map("n", "<leader>tn", "<cmd>tabn<CR>")     --go to next
map("n", "<leader>tp", "<cmd>tabp<CR>")     --go to pre
map("n", "<leader>tf", "<cmd>tabnew %<CR>") --open current tab in new tab

--split management
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- Copy filepath to the clipboard
map("n", "<leader>fp", function()
  local filePath = vim.fn.expand("%:~") -- Gets the file path relative to the home directory
  vim.fn.setreg("+", filePath) -- Copy the file path to the clipboard register
  print("File path copied to clipboard: " .. filePath) -- Optional: print message to confirm
end, { desc = "Copy file path to clipboard" })

---- FZF LUA ----
map("n", "<leader>ff", require("fzf-lua").files, {desc = "Fzf files"})
map("n", "<leader>/", require("fzf-lua").buffers, {desc = "Fzf buffers"})
map("n", "<leader>rg", function()
    require("fzf-lua").grep({
        actions = {
            ["alt-q"] = { 
                fn = require("fzf-lua.actions").file_edit_or_qf,
                prefix = "select-all+accept",
            },
        },
    })
    end, {desc = "Fzf live grep with QF support"})
-- map("n", "<leader>lrg", require("fzf-lua").live_grep, {desc = "Fzf live grep"})
map("n", "<leader>lrg", function()
    require("fzf-lua").live_grep({
        actions = {
            ["alt-q"] = { 
                fn = require("fzf-lua.actions").file_edit_or_qf,
                prefix = "select-all+accept",
            },
        },
    })
    end, {desc = "Fzf live grep with QF support"})
-- map("n", "<leader>rg", require("fzf-lua").grep, {desc = "Fzf grep"})
-- map("n", "ctrl-q", require("fzf-lua").quickfix, {desc = "Send results to quickfix list"})
map("n", "<leader>k", require("fzf-lua").builtin, {desc = "Fzf builtin commands"})
map(
    {"n", "v"},
  "<leader>ca",
  ":lua require'fzf-lua'.lsp_code_actions({ winopts = {relative='cursor',row=1.01, height=0.6, width=0.6, preview={vertical = 'up:70%'},} })<cr>",
  { desc = "Code Actions" }
)

--- LSP KEYMAPS ---
map("n", "K", vim.lsp.buf.hover, {desc = "Shows information about text in code"})
map("n", "gd", vim.lsp.buf.definition, {desc = "Shows definition of a function"})
