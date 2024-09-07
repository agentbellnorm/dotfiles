-- Load lsp-zero and required modules
local lsp_zero = require("lsp-zero")
local lspconfig = require("lspconfig")
local cmp = require("cmp")

-- Setup lsp_zero with new extend_lspconfig and on_attach function
local lsp_attach = function(client, bufnr)
	-- Apply default keymaps for LSP
	lsp_zero.default_keymaps({ buffer = bufnr })

	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		require("telescope.builtin").lsp_definitions()
	end, opts)
	vim.keymap.set("n", "gi", function()
		require("telescope.builtin").lsp_implementations()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	-- open error, full error message
	vim.keymap.set("n", "<leader>e", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	-- code action
	vim.keymap.set("n", "<leader>a", function()
		vim.lsp.buf.code_action()
	end, opts)
	-- show references
	vim.keymap.set("n", "F", function()
		require("telescope.builtin").lsp_references()
	end, { noremap = true, silent = true, buffer = bufnr })
	-- search in buffer
	vim.keymap.set("n", "<leader>/", function()
		require("telescope.builtin").current_buffer_fuzzy_find()
	end, { noremap = true, silent = true, buffer = bufnr })
	-- rename variable
	vim.keymap.set("n", "<leader>rn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("n", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)

	vim.keymap.set("n", "<leader>f", function()
		require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
	end, opts)

	vim.keymap.set("x", "<leader>f", function()
		require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
	end, opts)
end

-- Setup nvim-lspconfig
lsp_zero.extend_lspconfig({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	lsp_attach = lsp_attach,
	float_border = "rounded",
	sign_text = true,
})

-- Mason setup for automatic server install
require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"tsserver",
		"eslint",
		"rust_analyzer",
		"lua_ls",
		"bashls",
		"pyright",
		"biome",
		"jdtls",
		"html",
		"wgsl_analyzer",
	},
	handlers = {
		function(server_name)
			if server_name == "tsserver" then
				server_name = "ts_ls"
			end

			require("lspconfig")[server_name].setup({})
		end,
		-- Exclude jdtls auto configuration (example)
		-- jdtls = lsp_zero.noop,
	},
})

-- Setup nvim-cmp for autocompletion
local cmp_format = require("lsp-zero").cmp_format({ details = true })
cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
	},
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Scroll up docs
		["<C-d>"] = cmp.mapping.scroll_docs(4), -- Scroll down docs
		["<Tab>"] = cmp.mapping(function(fallback)
			fallback()
		end, { "i", "s" }),
	}),
	formatting = cmp_format,
})

-- Specific server configuration (e.g., tsserver autoformatting off)
lspconfig.ts_ls.setup({
	on_init = function(client)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentFormattingRangeProvider = false
	end,
})

-- Set filetype for wgsl
vim.cmd([[
  au BufNewFile,BufRead *.wgsl set filetype=wgsl
]])
