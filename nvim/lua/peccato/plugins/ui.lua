local M = {}

function M.setup_theme()
    local ok_catppuccin, catppuccin = pcall(require, "catppuccin")

    if not ok_catppuccin then
        return
    end

    catppuccin.setup({
        flavour = "mocha",
        transparent_background = false,

        integrations = {
            treesitter = true,
            telescope = true,
            gitsigns = true,
            cmp = true,
            native_lsp = {
                enabled = true,
            },
        },
    })

    pcall(vim.cmd.colorscheme, "catppuccin-mocha")
end

function M.setup_devicons()
    local ok_devicons, devicons = pcall(require, "nvim-web-devicons")

    if ok_devicons then
        devicons.setup({
            default = true,
        })
    end
end

function M.setup_lualine()
    local ok_lualine, lualine = pcall(require, "lualine")

    if not ok_lualine then
        return
    end

    lualine.setup({
        options = {
            theme = "auto",
            icons_enabled = true,
            globalstatus = true,
            component_separators = "",
            section_separators = "",
            disabled_filetypes = {
                statusline = {
                    "lazy",
                    "oil",
                    "TelescopePrompt",
                },
            },
        },

        sections = {
            lualine_a = {
                "mode",
            },

            lualine_b = {
                "branch",
            },

            lualine_c = {
                {
                    "filename",
                    path = 1,
                },
            },

            lualine_x = {
                "diagnostics",
                "filetype",
            },

            lualine_y = {
                "progress",
            },

            lualine_z = {
                "location",
            },
        },

        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {
                {
                    "filename",
                    path = 1,
                },
            },
            lualine_x = {
                "location",
            },
            lualine_y = {},
            lualine_z = {},
        },

        extensions = {
            "lazy",
            "quickfix",
        },
    })
end

function M.setup_gitsigns()
    local ok_gitsigns, gitsigns = pcall(require, "gitsigns")

    if not ok_gitsigns then
        return
    end

    gitsigns.setup({
        signs = {
            add = { text = "│" },
            change = { text = "│" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
        },

        current_line_blame = false,
    })
end

function M.setup_which_key()
    local ok_which_key, which_key = pcall(require, "which-key")

    if ok_which_key then
        which_key.setup({
            delay = 300,
        })
    end
end

function M.setup_trouble()
    local ok_trouble, trouble = pcall(require, "trouble")

    if ok_trouble then
        trouble.setup({})
    end
end

function M.setup()
    M.setup_theme()
    M.setup_devicons()
    M.setup_lualine()
    M.setup_gitsigns()
    M.setup_which_key()
    M.setup_trouble()
end

return M