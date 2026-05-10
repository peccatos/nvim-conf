-- Familiar terminal-notepad controls for Neovim.

local opts = {
    noremap = true,
    silent = true,
}

-- Save
vim.keymap.set({ "n", "i", "v" }, "<C-s>", function()
    vim.cmd("write")
end, vim.tbl_extend("force", opts, {
    desc = "Save file",
}))

-- Quit
vim.keymap.set("n", "<C-q>", "<cmd>q<CR>", vim.tbl_extend("force", opts, {
    desc = "Quit",
}))

vim.keymap.set("i", "<C-q>", "<Esc><cmd>q<CR>", vim.tbl_extend("force", opts, {
    desc = "Quit",
}))

-- Save and quit
vim.keymap.set("n", "<C-x>", "<cmd>wq<CR>", vim.tbl_extend("force", opts, {
    desc = "Save and quit",
}))

vim.keymap.set("i", "<C-x>", "<Esc><cmd>wq<CR>", vim.tbl_extend("force", opts, {
    desc = "Save and quit",
}))

-- Home behavior:
-- If Oil is available, open current file directory.
-- If already in Oil, go to parent directory.
-- If Oil is unavailable, fallback to :Ex.
local function open_file_explorer()
    local ok, oil = pcall(require, "oil")

    if ok then
        if vim.bo.filetype == "oil" then
            oil.open("..")
            return
        end

        local file_dir = vim.fn.expand("%:p:h")

        if file_dir == "" or file_dir == nil then
            oil.open(vim.fn.getcwd())
        else
            oil.open(file_dir)
        end

        return
    end

    vim.cmd("Ex")
end

vim.keymap.set("n", "<Home>", open_file_explorer, vim.tbl_extend("force", opts, {
    desc = "Open current file directory",
}))

-- Enter in normal mode -> insert mode
vim.keymap.set("n", "<CR>", "i", vim.tbl_extend("force", opts, {
    desc = "Start insert mode",
}))

-- Select all
vim.keymap.set("n", "<C-a>", "ggVG", vim.tbl_extend("force", opts, {
    desc = "Select all",
}))

-- Clipboard copy/paste
vim.keymap.set({ "n", "v" }, "<C-c>", '"+y', vim.tbl_extend("force", opts, {
    desc = "Copy to system clipboard",
}))

vim.keymap.set("n", "<C-v>", '"+p', vim.tbl_extend("force", opts, {
    desc = "Paste from system clipboard",
}))

vim.keymap.set("i", "<C-v>", '<C-r>+', vim.tbl_extend("force", opts, {
    desc = "Paste from system clipboard",
}))

-- Clear search
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", vim.tbl_extend("force", opts, {
    desc = "Clear search highlight",
}))

-- Friendly uppercase commands
vim.api.nvim_create_user_command("W", "write", {})
vim.api.nvim_create_user_command("Q", "quit", {})
vim.api.nvim_create_user_command("WQ", "wq", {})