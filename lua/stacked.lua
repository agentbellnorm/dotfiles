local M = {}
local buffer_list = {}

vim.api.nvim_exec([[
    augroup Stacked
        autocmd!
        autocmd BufEnter * lua require'stacked'.track_buffer()
    augroup END

]], false)

M.track_buffer = function()
    local cur_buf = vim.api.nvim_get_current_buf()

    local buftype = vim.api.nvim_buf_get_option(cur_buf, 'buftype')

    if buftype ~= "" then
        print("buftype is empty, not adding it to the stack")
    end

    for i, buf in ipairs(buffer_list) do
        if buf == cur_buf then
            table.remove(buffer_list, i)
            break
        end
    end

    table.insert(buffer_list, 1, cur_buf)
end

local function map(tbl, func)
    local newTbl = {}
    for i, v in ipairs(tbl) do
        newTbl[i] = func(v, i)
    end
    return newTbl
end


M.switch_buffer = function()
    local buf = vim.api.nvim_create_buf(false, true)



    vim.api.nvim_buf_set_lines(buf, 0, -1, false,
        map(buffer_list, function(buffer)
            return vim.api.nvim_buf_get_name(buffer)
        end)
    )

    local width = 30
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

    -- if #buffer_list > 1 then
    --     vim.api.nvim_set_current_buf(buffer_list[2])
    -- end
end

return M
