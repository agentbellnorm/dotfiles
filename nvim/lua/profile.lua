-- Lovbox uses Tree-sitter for highlighting without starting language servers.
return {
  use_lsp = vim.env.NVIM_DISABLE_LSP ~= "1"
    and vim.fn.filereadable("/opt/lovbox/env/bash_env") == 0,
}
