-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local function grep_at_current_tree_node()
    local core = require('nvim-tree.core')
    local explorer = core.get_explorer()
    local node = explorer:get_node_at_cursor()
    if not node then return end
    require('telescope.builtin').live_grep({ search_dirs = { node.absolute_path } })
end

-- empty setup using defaults
local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set('n', '<leader>pg', grep_at_current_tree_node, opts('grep'))
end

-- pass to setup along with your other options
require("nvim-tree").setup {
    on_attach = my_on_attach,
    git = {
        ignore = false,
    },
    update_focused_file = {
        enable = true
    },
    view = {
        width = 40,
    }
}
