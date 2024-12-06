local js_ts_formatters = { "eslint_d", "eslint", "prettierd", "prettier", stop_after_first = true }

require("conform").setup({
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
    },
    formatters = {
        eslint_d = {
            command = "eslint_d"
        }
    }
})
