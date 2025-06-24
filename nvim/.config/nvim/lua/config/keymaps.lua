local map = vim.keymap.set

---- FZF LUA ----
map("n", "<leader>ff", require("fzf-lua").files, {desc = "Fzf files"})
map("n", "<leader>/", require("fzf-lua").buffers, {desc = "Fzf buffers"})
map("n", "<leader>l", require("fzf-lua").live_grep, {desc = "Fzf live grep"})
map("n", "<leader>g", require("fzf-lua").grep, {desc = "Fzf grep"})
map("n", "<leader>k", require("fzf-lua").builtin, {desc = "Fzf builtin commands"})
map(
    {"n", "v"},
  "<leader>ca",
  ":lua require'fzf-lua'.lsp_code_actions({ winopts = {relative='cursor',row=1.01, height=0.6, width=0.6, preview={vertical = 'up:70%'},} })<cr>",
  { desc = "Code Actions" }
)

--- LSP KEYMAPS ---
vim.keymap.set("n", "K", vim.lsp.buf.hover, {desc = "Shows information about text in code"})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {desc = "Shows definition of a function"})
