local map = vim.keymap.set

---- FZF LUA ----
map("n", "<leader>p", require("fzf-lua").files, {desc = "Fzf files"})
map("n", "<leader>/", require("fzf-lua").buffers, {desc = "Fzf buffers"})
map("n", "<leader>l", require("fzf-lua").live_grep, {desc = "Fzf live grep"})
map("n", "<leader>g", require("fzf-lua").grep, {desc = "Fzf grep"})
map("n", "<leader>k", require("fzf-lua").builtin, {desc = "Fzf builtin commands"})
map(
  "n",
  "<leader>ca",
  ":lua require'fzf-lua'.lsp_code_actions({ winopts = {relative='cursor',row=1.01, col=0, height=0.2, width=0.4} })<cr>",
  { desc = "Code Actions" }
)
