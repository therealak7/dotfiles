return {
    {
        "neovim/nvim-lspconfig" ,
        init = function()
            local make_client_capabilities = vim.lsp.protocol.make_client_capabilities
            function vim.lsp.protocol.make_client_capabilities()
                local caps = make_client_capabilities()
                if caps.workspace then
                    caps.workspace.didChangeWatchedFiles = nil
                end
                return caps
            end
        end,
        -- config = function()
        --     local lspconfig = require("lspconfig")
        --     -- lspconfig.lua_ls.setup({})
        -- end
    },
    {
        "mason-org/mason.nvim",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        }
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "mason-org/mason.nvim"
        },
        opts = {
            ensure_installed = {
                "clangd",
                "lua_ls",
                "luacheck",
                "stylua",
                "prettierd",
                "prettier",
                "google-java-format",
                "ktlint",
                -- "standardrb",
                "vimls",
                "beautysh",
                "buf",
                "rustfmt",
                "yamlfix",
                "shellcheck",
                "gofmt",
                "xmllint",
                "taplo",
                "htmlbeautifier",
                "omnisharp",

            }
        }
    }
}
