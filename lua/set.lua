vim.opt.nu = true
vim.opt.relativenumber = true

local spaces = 4

vim.opt.tabstop = spaces
vim.opt.softtabstop = spaces
vim.opt.shiftwidth = spaces
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true
vim.opt.wrapmargin = 2

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "100"

vim.g.mapleader = " "
vim.g.copilot_assume_mapped = true

vim.opt.clipboard = "unnamedplus"
vim.diagnostic.config({
	virtual_text = true,
	virtual_lines = {
		 -- Only show virtual line diagnostics for the current cursor line
		current_line = true,
	},
})
