local M = {}

local function lsp_keymaps(event)
    local opts = { buffer = event.buf, silent = true }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, {
        desc = "LSP: go to definition",
    }))

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, {
        desc = "LSP: go to declaration",
    }))

    vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, {
        desc = "LSP: references",
    }))

    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, {
        desc = "LSP: implementation",
    }))

    vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, {
        desc = "LSP: hover",
    }))

    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, {
        desc = "LSP: rename",
    }))

    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, {
        desc = "LSP: code action",
    }))

    vim.keymap.set("n", "<leader>lf", function()
        vim.lsp.buf.format({ async = true })
    end, vim.tbl_extend("force", opts, {
        desc = "LSP: format buffer",
    }))
end

function M.setup()
    vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("peccato-lsp-attach", { clear = true }),
        callback = lsp_keymaps,
    })

    local rust_analyzer = "/usr/bin/rust-analyzer"

    if vim.fn.executable(rust_analyzer) ~= 1 then
        rust_analyzer = "rust-analyzer"
    end

    if vim.fn.executable(rust_analyzer) == 1 then
        vim.lsp.config("rust_analyzer", {
            cmd = { rust_analyzer },

            filetypes = { "rust" },

            root_markers = {
                "Cargo.toml",
                "rust-project.json",
                ".git",
            },

            settings = {
                ["rust-analyzer"] = {
                    cargo = {
                        allFeatures = true,
                    },
                    check = {
                        command = "clippy",
                    },
                    diagnostics = {
                        enable = true,
                    },
                },
            },
        })

        vim.lsp.enable("rust_analyzer")
    else
        vim.notify("rust-analyzer not found. Install it with: sudo dnf install rust-analyzer", vim.log.levels.WARN)
    end
end

M.setup()

return M