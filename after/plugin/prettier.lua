local js_utils = require("js-helpers")

-- https://github.com/MunifTanjim/prettier.nvim#setting-up-prettiernvim
local prettier = require("prettier")

if js_utils.is_prettier() then
  print("Using prettier!")
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
