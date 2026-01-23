vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.NvimTreeToggle)

-- move blocks around in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- bring line below up to same line with space between
vim.keymap.set("n", "J", "mzJ`z")

-- half page up or down, cursor stays in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- search terms stay in the middle of the buffer
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste but do not yank the highligted, replaced value
vim.keymap.set("x", "<leader>p", [["_dP]])

-- yank to pbcopy
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- capital Q is not good aparently
vim.keymap.set("n", "Q", "<nop>")

-- switch project, not sure what's needed
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- not sure
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- replace current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
--
-- make current file exexutable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- source current file
vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end)

-- navigate back
vim.keymap.set("n", "<leader>b", "<C-o>")

-- vim.keymap.set("n", "<leader><TAB>", function()
--     require "stacked".switch_buffer()
-- end)

-- window movement
vim.keymap.set("n", "<leader>wk", "<C-w>k")
vim.keymap.set("n", "<leader>wl", "<C-w>l")
vim.keymap.set("n", "<leader>wj", "<C-w>j")
vim.keymap.set("n", "<leader>wh", "<C-w>h")

-- split window vertically
vim.keymap.set("n", "<leader>wv", "<C-w>v")

-- error movement
vim.keymap.set('n', '<leader>en', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', '<leader>ep', '<cmd>lua vim.diagnostic.goto_next()<CR>')

-- jq
vim.keymap.set("n", "<leader>jq", "<Cmd>%!jq<CR> | :set filetype=json<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>jq", ":'<,'>!jq<CR>", { noremap = true, silent = true })

-- gitsigns
vim.keymap.set("n", "<leader>gh", "<cmd>Gitsigns preview_hunk<CR>")

-- diffview
vim.keymap.set("n", "<leader>gf", "<cmd>DiffviewFileHistory %<CR>")
