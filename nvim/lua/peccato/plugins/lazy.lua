local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,
    },

    {
        "nvim-tree/nvim-web-devicons",
        lazy = false,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        priority = 900,
        build = ":TSUpdate",
        config = function()
            require("peccato.plugins.treesitter")
        end,
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            require("peccato.plugins.lsp")
            require("peccato.plugins.cmp")
        end,
    },

    {
    "mason-org/mason.nvim",
    dependencies = {
        "mason-org/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        require("peccato.plugins.mason")
    end,
    },

    {
    "stevearc/conform.nvim",
    config = function()
        require("peccato.plugins.conform")
    end,
    },

    {
    "folke/todo-comments.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "folke/trouble.nvim",
    },
    config = function()
        require("peccato.plugins.todo")
    end,
    },

    {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("peccato.plugins.toggleterm")
    end,
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("peccato.plugins.telescope")
        end,
    },

    {
        "stevearc/oil.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("peccato.plugins.oil")
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },

    {
        "lewis6991/gitsigns.nvim",
    },

    {
        "folke/which-key.nvim",
    },

    {
        "folke/trouble.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },

    {
        dir = vim.fn.stdpath("config"),
        name = "peccato-ui",
        lazy = false,
        priority = 800,
        config = function()
            require("peccato.plugins.ui").setup()
        end,
    },

    {
        dir = vim.fn.stdpath("config"),
        name = "peccato-codex",
        config = function()
            require("peccato.plugins.codex").setup()
        end,
    },
})

-- Hard fallback: apply UI after lazy setup.
-- This prevents "colors_name = nil" if local plugin ordering gets weird.
local ok_ui, ui = pcall(require, "peccato.plugins.ui")

if ok_ui then
    pcall(ui.setup)
end
