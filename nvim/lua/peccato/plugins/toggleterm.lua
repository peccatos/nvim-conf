local M = {}

function M.setup()
    local ok, toggleterm = pcall(require, "toggleterm")

    if not ok then
        return
    end

    toggleterm.setup({
        size = 15,
        open_mapping = [[<C-\>]],
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        direction = "horizontal",
        close_on_exit = true,

        float_opts = {
            border = "rounded",
        },
    })

    local Terminal = require("toggleterm.terminal").Terminal

    local lazygit = Terminal:new({
        cmd = "lazygit",
        hidden = true,
        direction = "float",
        float_opts = {
            border = "rounded",
        },
    })

    local cargo_test = Terminal:new({
        cmd = "cargo test",
        hidden = true,
        direction = "horizontal",
    })

    local cargo_check = Terminal:new({
        cmd = "cargo check",
        hidden = true,
        direction = "horizontal",
    })

    vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", {
        noremap = true,
        silent = true,
        desc = "Toggle terminal",
    })

    vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", {
        noremap = true,
        silent = true,
        desc = "Toggle floating terminal",
    })

    vim.keymap.set("n", "<leader>tg", function()
        lazygit:toggle()
    end, {
        noremap = true,
        silent = true,
        desc = "Toggle lazygit",
    })

    vim.keymap.set("n", "<leader>tc", function()
        cargo_check:toggle()
    end, {
        noremap = true,
        silent = true,
        desc = "Run cargo check",
    })

    vim.keymap.set("n", "<leader>tr", function()
        cargo_test:toggle()
    end, {
        noremap = true,
        silent = true,
        desc = "Run cargo test",
    })

    vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], {
        noremap = true,
        silent = true,
        desc = "Exit terminal mode",
    })
end

M.setup()

return M
