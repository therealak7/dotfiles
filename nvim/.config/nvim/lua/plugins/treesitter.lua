return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        branch = 'main',
        build = ':TSUpdate',
        opts = {
            autotag = {
                enable = true,
                filetypes = {
                    "html",
                    "javascript",
                    "typescript",
                    "markdown",
                },
            },
            ensure_installed = {
                "c",
                "css",
                "cpp",
                "c_sharp",
                "scss",
                "typescript",
                "lua",
                "html",
                "javascript",
                "json",
                "lua",
                "php",
                "rust",
                "yaml",
                "vim",
                "toml",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                },
            },
            additional_vim_regex_highlighting = false,
            highlight = { enable = true },
            indent = { enable = true },
            },
        },

}
