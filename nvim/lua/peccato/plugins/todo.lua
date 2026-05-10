-- ~/.config/nvim/lua/peccato/plugins/todo.lua

local M = {}

function M.setup()
    local ok, todo = pcall(require, "todo-comments")

    if not ok then
        return
    end

    todo.setup({
        signs = true,
        sign_priority = 8,

        keywords = {
            FIX = {
                icon = " ",
                color = "error",
                alt = {
                    "FIXME",
                    "BUG",
                    "FIXIT",
                    "ISSUE",
                },
            },

            TODO = {
                icon = " ",
                color = "info",
            },

            HACK = {
                icon = " ",
                color = "warning",
            },

            WARN = {
                icon = " ",
                color = "warning",
                alt = {
                    "WARNING",
                    "XXX",
                },
            },

            PERF = {
                icon = " ",
                color = "default",
                alt = {
                    "OPTIM",
                    "PERFORMANCE",
                    "OPTIMIZE",
                },
            },

            NOTE = {
                icon = " ",
                color = "hint",
                alt = {
                    "INFO",
                },
            },

            TEST = {
                icon = "⏲ ",
                color = "test",
                alt = {
                    "TESTING",
                    "PASSED",
                    "FAILED",
                },
            },
        },

        highlight = {
            multiline = true,
            before = "",
            keyword = "wide",
            after = "fg",
            pattern = [[.*<(KEYWORDS)\s*:]],
            comments_only = true,
            max_line_len = 400,
        },

        search = {
            command = "rg",
            args = {
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
            },
            pattern = [[\b(KEYWORDS):]],
        },
    })

    vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", {
        noremap = true,
        silent = true,
        desc = "Find TODO comments",
    })

    vim.keymap.set("n", "<leader>xt", "<cmd>TodoTrouble<CR>", {
        noremap = true,
        silent = true,
        desc = "TODO diagnostics panel",
    })

    vim.keymap.set("n", "]t", function()
        require("todo-comments").jump_next()
    end, {
        noremap = true,
        silent = true,
        desc = "Next TODO comment",
    })

    vim.keymap.set("n", "[t", function()
        require("todo-comments").jump_prev()
    end, {
        noremap = true,
        silent = true,
        desc = "Previous TODO comment",
    })
end

M.setup()

return M