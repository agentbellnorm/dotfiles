local js_ts_formatters = { "prettierd", "eslint_d", "eslint", "prettier", stop_after_first = true }

require("conform").setup({
	async = true,
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- You can customize some of the format options for the filetype (:help conform.format)
		rust = { "rustfmt", lsp_format = "fallback" },
		-- Conform will run the first available formatter
		javascript = js_ts_formatters,
		typescript = js_ts_formatters,
		javascriptreact = js_ts_formatters,
		typescriptreact = js_ts_formatters,
		json = { "prettierd", "prettier", stop_after_first = true },
		graphql = { "prettierd", "prettier", stop_after_first = true },
		java = { "google-java-format" },
		go = { "gofmt", "goimports" },
	},
	formatters = {
		eslint_d = {
			command = "eslint_d",
		},
	},
})
