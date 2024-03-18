if vim.g.neovide then
  -- COPY PASTE
  vim.keymap.set('n', '<D-s>', ':w<CR>')        -- Save
  vim.keymap.set('v', '<D-c>', '"+y')           -- Copy
  vim.keymap.set('n', '<D-v>', '"+P')           -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P')           -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+')        -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli')   -- Paste insert mode

  -- FONT
  vim.o.guifont = "Hack Nerd Font Mono:h16"   -- text below applies for VimScript

  -- TRANSPARENCY

  local alpha = function()
    return string.format("%x", math.floor((255 * vim.g.transparency) or 0.9))
  end
  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  vim.g.neovide_transparency = 0.9
  vim.g.transparency = 0.9
  vim.g.neovide_window_blurred = true
  -- vim.g.neovide_background_color = "#0f1117" .. alpha()

  -- -- BLUR
  -- vim.g.neovide_floating_blur_amount_x = 15.0
  -- vim.g.neovide_floating_blur_amount_y = 15.0

  -- ANIMATION LENGTH
  vim.g.neovide_scroll_animation_length = 0.02
  vim.g.neovide_cursor_animation_length = 0.02
  -- HIDE MOUSE
  vim.g.neovide_hide_mouse_when_typing = true

  -- aa
  vim.g.neovide_cursor_antialiasing = true
end

-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<D-v>', '<C-O>:set paste<CR><C-R>+<C-O>:set nopaste<CR>', { noremap = true, silent = true })
