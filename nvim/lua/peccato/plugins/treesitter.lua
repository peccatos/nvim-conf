local ok, treesitter = pcall(require, "nvim-treesitter.configs")

if not ok then
    return
end

treesitter.setup({
    ensure_installed = {
        "lua",
        "rust",
        "toml",
        "json",
        "bash",
        "markdown",
        "markdown_inline",
    },

    highlight = {
        enable = true,
    },

    indent = {
        enable = true,
    },
})