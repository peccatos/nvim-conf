-- ~/.config/nvim/lua/peccato/plugins/conform.lua

local M = {}

function M.setup()
    local ok, conform = pcall(require, "conform")

    if not ok then
        return
    end

    conform.setup({
        formatters_by_ft = {
            lua = { "stylua" },

            sh = { "shfmt" },
            bash = { "shfmt" },
            zsh = { "shfmt" },

            javascript = { "prettier" },
            typescript = { "prettier" },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },

            json = { "prettier" },
            jsonc = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },

            rust = { "rustfmt" },
        },

        format_on_save = false,

        formatters = {
            rustfmt = {
                command = "rustfmt",
            },
        },
    })

    vim.keymap.set({ "n", "v" }, "<leader>lf", function()
        conform.format({
            async = true,
            lsp_fallback = true,
        })
    end, {
        noremap = true,
        silent = true,
        desc = "Format file",
    })
end

M.setup()

return M