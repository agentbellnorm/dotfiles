-- Setup lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, "lazy")

if not ok then
	local msg = "You need to install the plugin manager lazy.nvim\n" .. "in this folder: " .. lazypath
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
