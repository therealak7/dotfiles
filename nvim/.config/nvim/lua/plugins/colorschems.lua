return {
    -- NOTE: Rose pine
    {
        "rose-pine/neovim",
        name = "rose-pine",
        -- priority = 1000,
        config = function()
            require("rose-pine").setup({
                variant = "main",      -- auto, main, moon, or dawn
                dark_variant = "main", -- main, moon, or dawn
                dim_inactive_windows = false,
                -- disable_background = true,
                -- 	disable_nc_background = false,
                -- 	disable_float_background = false,
                -- extend_background_behind_borders = false,
                styles = {
                    bold = true,
                    italic = false,
                    transparency = true,
                },
                highlight_groups = {
                    ColorColumn = { bg = "#1C1C21" },
                    Normal = { bg = "none" },                      -- Main background remains transparent
                    Pmenu = { bg = "", fg = "#e0def4" },           -- Completion menu background
                    PmenuSel = { bg = "#4a465d", fg = "#f8f5f2" }, -- Highlighted completion item
                    PmenuSbar = { bg = "#191724" },                -- Scrollbar background
                    PmenuThumb = { bg = "#9ccfd8" },               -- Scrollbar thumb
                },
                enable = {
                    terminal = false,
                    migrations = true,         -- Handle deprecated options automatically
                },

            })

            -- HACK: set this on the color you want to be persistent
            -- when quit and reopening nvim
            -- vim.cmd("colorscheme rose-pine")
        end,
    },
    -- NOTE: gruvbox
    {
        "ellisonleao/gruvbox.nvim",
        -- priority = 1000 ,
        config = function()
            require("gruvbox").setup({
                terminal_colors = true, -- add neovim terminal colors
                undercurl = true,
                underline = true,
                bold = true,
                italic = {
                    strings = false,
                    emphasis = false,
                    comments = false,
                    folds = false,
                    operators = false,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true, -- invert background for search, diffs, statuslines and errors
                contrast = "",  -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {
                    Pmenu = { bg = "" }, -- Completion menu background
                },
                dim_inactive = false,
                transparent_mode = true,
            })
        end,
    },
    -- NOTE: Kanagwa
    {
        "rebelot/kanagawa.nvim",
        config = function()
            require('kanagawa').setup({
                compile = false,  -- enable compiling the colorscheme
                undercurl = true, -- enable undercurls
                commentStyle = { italic = true },
                functionStyle = {},
                keywordStyle = { italic = false },
                statementStyle = { bold = true },
                typeStyle = {},
                transparent = true,    -- do not set background color
                dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
                terminalColors = true, -- define vim.g.terminal_color_{0,17}
                colors = {             -- add/modify theme and palette colors
                    palette = {},
                    theme = {
                        wave = {},
                        dragon = {},
                        all = {
                            ui = {
                                bg_gutter = "none",
                                border = "rounded"
                            }
                        }
                    },
                },
                theme = "wave",    -- Load "wave" theme when 'background' option is not set
                background = {     -- map the value of 'background' option to a theme
                    dark = "wave", -- try "dragon" !
                },
            })
        end
    },
    -- NOTE : tokyonight
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        lazy = false,
        opts = {},
    },
    -- catppuccin
    { 
        "catppuccin/nvim", 
        name = "catppuccin", 
        priority = 1000,
        lazy = false,
    },
    {
        "cpplain/flexoki.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    }
}
