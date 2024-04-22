require('lualine').setup({
    options = {
        ignore_focus = { 'NvimTree', 'fugitive', 'undotree', 'TelescopePrompt' },
        globalstatus = true,
    },
    sections = {
        lualine_c = {
            {
                'filename',
                path = 1,
            }
        },
        lualine_x = { 'filetype' },
    }
})
