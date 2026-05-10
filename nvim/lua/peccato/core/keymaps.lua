vim.g.mapleader = " "

local keymap = vim.keymap

local opts = {
    noremap = true,
    silent = true,
}

-- Core
keymap.set("n", "<leader>w", "<cmd>w<CR>", opts)
keymap.set("n", "<leader>q", "<cmd>q<CR>", opts)
keymap.set("n", "<leader>Q", "<cmd>qa!<CR>", opts)

keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Better movement
keymap.set("n", "J", "mzJ`z", opts)
keymap.set("n", "<C-d>", "<C-d>zz", opts)
keymap.set("n", "<C-u>", "<C-u>zz", opts)
keymap.set("n", "n", "nzzzv", opts)
keymap.set("n", "N", "Nzzzv", opts)

-- Splits
keymap.set("n", "<leader>sv", "<cmd>vsplit<CR>", opts)
keymap.set("n", "<leader>sh", "<cmd>split<CR>", opts)
keymap.set("n", "<leader>sx", "<cmd>close<CR>", opts)

keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)

-- Resize windows
keymap.set("n", "<A-h>", "<cmd>vertical resize -5<CR>", opts)
keymap.set("n", "<A-l>", "<cmd>vertical resize +5<CR>", opts)
keymap.set("n", "<A-j>", "<cmd>resize -3<CR>", opts)
keymap.set("n", "<A-k>", "<cmd>resize +3<CR>", opts)

-- Buffers
keymap.set("n", "<S-l>", "<cmd>bnext<CR>", opts)
keymap.set("n", "<S-h>", "<cmd>bprevious<CR>", opts)
keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", opts)
keymap.set("n", "<leader>ba", "<cmd>%bd|e#|bd#<CR>", opts)

-- Explorer
keymap.set("n", "<leader>e", function()
    local ok, oil = pcall(require, "oil")

    if ok then
        oil.open()
    else
        vim.cmd("Ex")
    end
end, opts)

-- Telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", opts)

-- Diagnostics
keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", opts)
keymap.set("n", "<leader>xw", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", opts)
keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
keymap.set("n", "<leader>dd", vim.diagnostic.open_float, opts)

-- Git
keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", opts)
keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", opts)
keymap.set("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", opts)

-- Terminal mode escape
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", opts)

-- Codex
keymap.set("n", "<leader>cc", "<cmd>CodexToggle<CR>", { desc = "Toggle Codex" })
keymap.set("n", "<leader>cf", "<cmd>CodexFile<CR>", { desc = "Send current file reference to Codex" })
keymap.set("n", "<leader>cr", "<cmd>CodexReviewFile<CR>", { desc = "Ask Codex to review current file" })
keymap.set("v", "<leader>cs", ":CodexSelection<CR>", { desc = "Send selection to Codex" })