-- Setup lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, "lazy")

if not ok then
	local msg = "Failed to load lazy.nvim"
	print(msg)
	return
end

lazy.setup("plugins")

require("Comment").setup({
	toggler = {
		line = "<leader>c",
		-- block = '<leader>bc',
	},
	opleader = {
		line = "<leader>c",
		-- block = '<leader>bc', -- slows down <leader>b for backing
	},
})

require("gitsigns").setup()

-- close quickfix (show references) menu after selecting choice
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "qf" },
	command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]],
})

require("template-string").setup({ remove_template_string = true })

require("ibl").setup()
