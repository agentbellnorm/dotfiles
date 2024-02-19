local js_utils = require("js-helpers")

-- https://github.com/MunifTanjim/prettier.nvim#setting-up-prettiernvim
local null_ls = require("null-ls")

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

local prettier = require("prettier")

if js_utils.is_prettier() then
  print("Using prettier!")

  null_ls.setup({
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
        end, { buffer = bufnr, desc = "[lsp] format" })
      end

      if client.supports_method("textDocument/rangeFormatting") then
        vim.keymap.set("x", "<leader>f", function()
          vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
        end, { buffer = bufnr, desc = "[lsp] format" })
      end
    end,
  })

  prettier.setup({
    bin = 'prettierd',
    filetypes = {
      "css",
      "graphql",
      "html",
      "javascript",
      "javascriptreact",
      "json",
      "less",
      "markdown",
      "scss",
      "typescript",
      "typescriptreact",
      "yaml",
    },
  })
end
