local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', '<CR>', '<cmd>nohlsearch<CR><CR>') -- clear highlights on search when pressing ESC key
map('i', "jj", '<Esc>', opts) -- remap jj jk and kj to esc while in esc mode
map('i', "jk", '<Esc>', opts) -- remap jj jk and kj to esc while in esc mode
map('i', "kj", '<Esc>', opts) -- remap jj jk and kj to esc while in esc mode

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
-- map("n", "<leader>l", require("fzf-lua").live_grep, {desc = "Fzf live grep"})
-- map("n", "<leader>g", require("fzf-lua").grep, {desc = "Fzf grep"})
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
