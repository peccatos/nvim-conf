local ok, oil = pcall(require, "oil")

if not ok then
    return
end

oil.setup({
    default_file_explorer = true,

    columns = {
        "icon",
    },

    keymaps = {
        ["<CR>"] = "actions.select",

        -- Back / parent directory
        ["-"] = "actions.parent",
        ["<Home>"] = "actions.parent",

        -- Help
        ["g?"] = "actions.show_help",

        -- Refresh
        ["<C-r>"] = "actions.refresh",

        -- Close
        ["q"] = "actions.close",

        -- Splits
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-x>"] = "actions.select_split",
    },

    view_options = {
        show_hidden = true,
    },

    skip_confirm_for_simple_edits = false,
    prompt_save_on_select_new_entry = true,
})