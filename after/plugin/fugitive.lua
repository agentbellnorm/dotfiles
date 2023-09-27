vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
vim.keymap.set('n', '<leader>gb', ':Git blame<CR>')

-- git history in current file
vim.keymap.set('n', '<leader>gh', ':Gclog -- %<CR>')
