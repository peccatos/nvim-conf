local M = {}

local state = {
    buf = nil,
    win = nil,
    job = nil,
}

local function project_root()
    local cwd = vim.fn.getcwd()

    local git_root = vim.fn.systemlist("git -C " .. vim.fn.shellescape(cwd) .. " rev-parse --show-toplevel")[1]

    if vim.v.shell_error == 0 and git_root and git_root ~= "" then
        return git_root
    end

    return cwd
end

local function is_valid_window(win)
    return win and vim.api.nvim_win_is_valid(win)
end

local function is_valid_buffer(buf)
    return buf and vim.api.nvim_buf_is_valid(buf)
end

local function open_codex_terminal()
    local root = project_root()

    if is_valid_window(state.win) then
        vim.api.nvim_set_current_win(state.win)
        return
    end

    if not is_valid_buffer(state.buf) then
        state.buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_name(state.buf, "Codex")
    end

    vim.cmd("botright vertical 90split")
    state.win = vim.api.nvim_get_current_win()

    vim.api.nvim_win_set_buf(state.win, state.buf)

    vim.bo[state.buf].bufhidden = "hide"
    vim.bo[state.buf].filetype = "codex-terminal"

    if not state.job then
        vim.fn.termopen("codex", {
            cwd = root,
            on_exit = function()
                state.job = nil
            end,
        })

        state.job = vim.b.terminal_job_id
    end

    vim.cmd("startinsert")
end

function M.toggle()
    if is_valid_window(state.win) then
        vim.api.nvim_win_close(state.win, true)
        state.win = nil
        return
    end

    open_codex_terminal()
end

function M.open()
    open_codex_terminal()
end

function M.send_text(text)
    open_codex_terminal()

    if not state.job then
        vim.notify("Codex terminal job is not running", vim.log.levels.ERROR)
        return
    end

    vim.fn.chansend(state.job, text)
end

function M.send_current_file_reference()
    local file = vim.fn.expand("%:.")

    if file == "" then
        vim.notify("No current file", vim.log.levels.WARN)
        return
    end

    M.send_text("@" .. file .. "\n")
end

function M.send_current_file_with_prompt()
    local file = vim.fn.expand("%:.")

    if file == "" then
        vim.notify("No current file", vim.log.levels.WARN)
        return
    end

    local prompt = table.concat({
        "Analyze this file:",
        "@" .. file,
        "",
        "Return:",
        "1. bugs",
        "2. risky assumptions",
        "3. minimal patch plan",
        "4. tests to run",
        "",
    }, "\n")

    M.send_text(prompt)
end

function M.send_visual_selection()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")

    local start_line = start_pos[2]
    local end_line = end_pos[2]

    if start_line <= 0 or end_line <= 0 then
        vim.notify("No visual selection", vim.log.levels.WARN)
        return
    end

    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    local file = vim.fn.expand("%:.")
    local text = table.concat(lines, "\n")

    local prompt = table.concat({
        "Analyze selected code from file: " .. file,
        "",
        "```",
        text,
        "```",
        "",
        "Return concise engineering feedback and a minimal safe patch plan.",
        "",
    }, "\n")

    M.send_text(prompt)
end

function M.setup()
    vim.api.nvim_create_user_command("Codex", function()
        M.open()
    end, {})

    vim.api.nvim_create_user_command("CodexToggle", function()
        M.toggle()
    end, {})

    vim.api.nvim_create_user_command("CodexFile", function()
        M.send_current_file_reference()
    end, {})

    vim.api.nvim_create_user_command("CodexReviewFile", function()
        M.send_current_file_with_prompt()
    end, {})

    vim.api.nvim_create_user_command("CodexSelection", function()
        M.send_visual_selection()
    end, { range = true })
end

return M