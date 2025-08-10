local M = {}
local buffer_list = {}

-- BEGIN UTIL --
local function map(tbl, func)
    local newTbl = {}
    for i, v in ipairs(tbl) do
        newTbl[i] = func(v, i)
    end
    return newTbl
end

-- Find the longest common prefix of a list of strings
local function findCommonPrefix(paths)
    if #paths == 0 then return "" end

    local prefix = paths[1]

    for i = 2, #paths do
        while not paths[i]:find("^" .. prefix) do
            prefix = prefix:sub(1, -2) -- remove last character
            if prefix == "" then return "" end
        end
    end

    local lastSlashPos = prefix:reverse():find("/")
    if lastSlashPos then
        prefix = prefix:sub(1, -lastSlashPos)
    end

    print('prefix was', prefix)

    return prefix
end

local function removeCommonPrefix(paths)
    local prefix = findCommonPrefix(paths)

    if prefix == "" then return paths end

    for i = 1, #paths do
        paths[i] = paths[i]:sub(#prefix + 1)
    end

    return paths
end

-- END UTIL --


vim.api.nvim_exec([[
    augroup Stacked
        autocmd!
        autocmd BufEnter * lua require'stacked'.track_buffer()
        autocmd BufDelete * lua require'stacked'.untrack_buffer()
    augroup END

]], false)

M.untrack_buffer = function()
    local cur_buf = vim.api.nvim_get_current_buf()
    -- print("deleting buffer", cur_buf)

    for i, buf in ipairs(buffer_list) do
        if buf == cur_buf then
            table.remove(buffer_list, i)
            break
        end
    end
end

M.track_buffer = function()
    local cur_buf = vim.api.nvim_get_current_buf()

    local bufname = vim.api.nvim_buf_get_name(cur_buf)
    if bufname == "" then
        -- print("not adding because bufname was ", bufname)
        return
    end

    local buftype = vim.api.nvim_buf_get_option(cur_buf, 'buftype')
    if buftype ~= "" then
        -- print("has a buftype so skipping", buftype, cur_buf)
        return
    end

    -- print("no buftype, add to list", buftype, cur_buf)

    for i, buf in ipairs(buffer_list) do
        if buf == cur_buf then
            table.remove(buffer_list, i)
            break
        end
    end

    table.insert(buffer_list, 1, cur_buf)
end

M.close_popup = function()
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_close(win, true)
end

M.select_buffer = function()
    local line = vim.api.nvim_win_get_cursor(0)[1]
    local buf_id = buffer_list[line]
    M.close_popup()
    vim.api.nvim_set_current_buf(buf_id)
end

M.switch_buffer = function()
    if #buffer_list == 0 then
        print("No buffers to switch between")
        return
    end

    local buf = vim.api.nvim_create_buf(false, true)

    local buffer_paths = map(buffer_list, function(buffer)
        return vim.api.nvim_buf_get_name(buffer)
    end)

    buffer_paths = removeCommonPrefix(buffer_paths)

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, buffer_paths)

    local width = 80 -- todo length of longest path, or window width
    local height = #buffer_list

    local win_opts = {
        relative = "editor",
        width = width,
        height = height,
        col = (vim.o.columns - width) / 2,
        row = (vim.o.lines - height) / 2,
        style = "minimal",
        border = "rounded"
    }

    local win = vim.api.nvim_open_win(buf, true, win_opts)
    if #buffer_list > 1 then
        vim.api.nvim_win_set_cursor(win, { 2, 0 })
    end

    vim.api.nvim_buf_set_keymap(buf, 'n', '<Enter>',
        ':lua require"stacked".select_buffer()<CR>',
        { noremap = true, silent = true })

    vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>',
        ':lua require"stacked".close_popup()<CR>',
        { noremap = true, silent = true })

    vim.api.nvim_buf_set_keymap(buf, 'n', '<TAB>', 'j', { noremap = true, silent = true })
end

return M
