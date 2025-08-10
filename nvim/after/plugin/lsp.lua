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
		"jdtls",
		"html",
		"wgsl_analyzer",
        "tailwindcss",
	},
	handlers = {
		function(server_name)
			if server_name == "tsserver" then
				server_name = "ts_ls"
			end

			lspconfig[server_name].setup({})
		end,
		-- Exclude jdtls auto configuration (example)
		-- jdtls = lspconfig.noop,
		tsserver = function()
			lspconfig.ts_ls.setup({
				on_init = function(client)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentFormattingRangeProvider = false
				end,
			})
		end,
	},
})

require("mason-tool-installer").setup({

	-- a list of all tools you want to ensure are installed upon
	-- start
	ensure_installed = {

		"lua-language-server",
		"google-java-format",
		"stylua",
		"shellcheck",
	},

	-- if set to true this will check each tool for updates. If updates
	-- are available the tool will be updated. This setting does not
	-- affect :MasonToolsUpdate or :MasonToolsInstall.
	-- Default: false
	auto_update = true,

	-- automatically install / update on startup. If set to false nothing
	-- will happen on startup. You can use :MasonToolsInstall or
	-- :MasonToolsUpdate to install tools and check for updates.
	-- Default: true
	run_on_start = true,

	-- set a delay (in ms) before the installation starts. This is only
	-- effective if run_on_start is set to true.
	-- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
	-- Default: 0
	start_delay = 3000, -- 3 second delay

	-- Only attempt to install if 'debounce_hours' number of hours has
	-- elapsed since the last time Neovim was started. This stores a
	-- timestamp in a file named stdpath('data')/mason-tool-installer-debounce.
	-- This is only relevant when you are using 'run_on_start'. It has no
	-- effect when running manually via ':MasonToolsInstall' etc....
	-- Default: nil
	debounce_hours = 5, -- at least 5 hours between attempts to install/update

	-- By default all integrations are enabled. If you turn on an integration
	-- and you have the required module(s) installed this means you can use
	-- alternative names, supplied by the modules, for the thing that you want
	-- to install. If you turn off the integration (by setting it to false) you
	-- cannot use these alternative names. It also suppresses loading of those
	-- module(s) (assuming any are installed) which is sometimes wanted when
	-- doing lazy loading.
	integrations = {
		["mason-lspconfig"] = true,
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

-- Set filetype for wgsl
vim.cmd([[
  au BufNewFile,BufRead *.wgsl set filetype=wgsl
]])
