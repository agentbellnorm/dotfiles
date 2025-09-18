-- rustaceanvim is configured automatically and doesn't need explicit setup
-- The plugin will automatically configure rust-analyzer and provide enhanced features

vim.g.rustaceanvim = {
	server = {
		cmd = function()
			local mason_registry = require("mason-registry")
			if mason_registry.is_installed("rust-analyzer") then
				-- This may need to be tweaked depending on the operating system.
				local ra = mason_registry.get_package("rust-analyzer")
				local ra_filename = ra:get_receipt():get().links.bin["rust-analyzer"]
				return { ("%s/%s"):format(ra:get_install_path(), ra_filename or "rust-analyzer") }
			else
				-- global installation
				return { "rust-analyzer" }
			end
		end,
	},
}

-- Custom keymaps for rustaceanvim (optional)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()

		-- Hover actions (replaces the old rt.hover_actions.hover_actions)
		vim.keymap.set("n", "<C-space>", function()
			vim.cmd.RustLsp("hover", "actions")
		end, { buffer = bufnr, desc = "Rust hover actions" })

		-- Code action groups (replaces the old rt.code_action_group.code_action_group)
		vim.keymap.set("n", "<Leader>a", function()
			vim.cmd.RustLsp("codeAction")
		end, { buffer = bufnr, desc = "Rust code actions" })
	end,
})
