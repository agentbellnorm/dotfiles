local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
vim.keymap.set('n', '<leader><TAB>', builtin.buffers, {})


-- For telescope-ui-select: https://github.com/nvim-telescope/telescope-ui-select.nvim

require("telescope").setup {
  pickers = {
    buffers = {
      sort_mru = true,
      ignore_current_buffer = true,
      layout_strategy = "vertical",
      layout_config = {
        mirror = true
      }
    },
    lsp_references = {
      layout_strategy = "vertical",
      layout_config = {
        mirror = true
      }
    },
    lsp_definitions = {
      layout_strategy = "vertical",
      layout_config = {
        mirror = true
      }
    },
    lsp_implementations = {
      layout_strategy = "vertical",
      layout_config = {
        mirror = true
      }
    }
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {}
    }
  }
}
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")
