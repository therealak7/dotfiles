return {
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- or if using mini.icons/mini.nvim
        -- dependencies = { "echasnovski/mini.icons" },
        opts = {
            lsp = {
                code_actions = {
                    previewer = 'codeaction_native',
                    preview_pager = "delta --side-by-side --width=$FZF_PREVIEW_COLUMNS --hunk-header-style='omit' --file-style='omit'",
                },
            },
        },
        config = function()
            local fzf = require("fzf-lua")
            fzf.setup({
                "hide",
                vim.cmd("FzfLua register_ui_select")
                -- your other settings here 
            })
        end,
    },
}

