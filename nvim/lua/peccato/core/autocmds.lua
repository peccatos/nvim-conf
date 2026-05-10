local group = vim.api.nvim_create_augroup("peccato-core", { clear = true })

-- Text-like files
vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = { "text", "markdown", "gitcommit" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = false
    end,
})

-- Open Oil automatically when starting nvim with a directory: nvim .
vim.api.nvim_create_autocmd("VimEnter", {
    group = group,
    callback = function()
        local arg = vim.fn.argv(0)

        if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
            vim.schedule(function()
                local ok, oil = pcall(require, "oil")

                if ok then
                    oil.open(arg)
                end
            end)
        end
    end,
})