-- ~/.config/nvim/lua/peccato/plugins/mason.lua

local M = {}

function M.setup()
    local ok_mason, mason = pcall(require, "mason")

    if not ok_mason then
        return
    end

    mason.setup({
        ui = {
            border = "rounded",

            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
    })

    local ok_tool_installer, tool_installer = pcall(require, "mason-tool-installer")

    if ok_tool_installer then
        tool_installer.setup({
            ensure_installed = {
                -- LSP
                "lua-language-server",

                -- Formatters
                "stylua",
                "shfmt",
                "prettier",

                -- Optional linters can be added later:
                -- "eslint_d",
                -- "shellcheck",
            },

            auto_update = false,
            run_on_start = true,
            start_delay = 3000,
            debounce_hours = 12,
        })
    end

    local ok_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")

    if ok_mason_lspconfig then
        mason_lspconfig.setup({
            ensure_installed = {
                "lua_ls",

                -- Rust Analyzer intentionally disabled here.
                -- We use system rust-analyzer from /usr/bin/rust-analyzer
                -- to avoid double Rust LSP attachment.
                -- "rust_analyzer",
            },

            automatic_enable = {
                exclude = {
                    "rust_analyzer",
                },
            },
        })
    end
end

M.setup()

return M