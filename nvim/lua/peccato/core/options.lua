local opt = vim.opt

vim.g.mapleader = " "

-- Base UI
opt.number = true
opt.relativenumber = false
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.termguicolors = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.wrap = true
opt.linebreak = true
opt.showmode = false
opt.laststatus = 3
opt.cmdheight = 1
opt.updatetime = 300

-- Indent
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Split behavior
opt.splitright = true
opt.splitbelow = true

-- Better backspace in insert mode
opt.backspace = { "indent", "eol", "start" }

-- Minimal message noise
opt.shortmess:append("c")

-- Completion
opt.completeopt = {
    "menu",
    "menuone",
    "noselect",
}

opt.pumheight = 10

-- Scroll
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Files
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = true

local undodir = vim.fn.stdpath("state") .. "/undo"
vim.fn.mkdir(undodir, "p")
opt.undodir = undodir

-- Visual chars
opt.list = true
opt.listchars = {
    tab = "→ ",
    trail = "·",
    nbsp = "␣",
}

opt.fillchars = {
    eob = " ",
    fold = " ",
    foldopen = "",
    foldsep = " ",
    foldclose = "",
}

-- Safe folds for now.
-- Do not use vim.treesitter.foldexpr() until Treesitter is fully stable.
opt.foldmethod = "manual"
opt.foldlevel = 99