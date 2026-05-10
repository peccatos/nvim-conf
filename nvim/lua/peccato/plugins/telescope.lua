local ok, telescope = pcall(require, "telescope")

if not ok then
    return
end

telescope.setup({
    defaults = {
        prompt_prefix = "  ",
        selection_caret = "➜ ",
        path_display = { "truncate" },

        mappings = {
            i = {
                ["<Esc>"] = require("telescope.actions").close,
            },
        },
    },

    pickers = {
        find_files = {
            hidden = true,
        },
    },
})