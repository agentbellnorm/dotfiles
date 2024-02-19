-- Helpers from https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/utils/init.lua
local path_exists = function(filename)
  local stat = vim.loop.fs_stat(filename)
  return stat ~= nil
end

local path_join = function(...)
  return table.concat(vim.tbl_flatten({ ... }), '/'):gsub('/' .. "+", '/')
end


-- This uses null ls just to get the root path
local get_root = function()
  local root

  -- prefer getting from client
  local client = require("null-ls.client").get_client()
  if client then
    root = client.config.root_dir
  end

  -- if in named buffer, resolve directly from root_dir
  if not root then
    local fname = vim.api.nvim_buf_get_name(0)
    if fname ~= "" then
      root = require("null-ls.config").get().root_dir(fname)
    end
  end

  -- fall back to cwd
  root = root or vim.loop.cwd()

  return root
end

local root_has_file = function(...)
  local patterns = vim.tbl_flatten({ ... })
  for _, name in ipairs(patterns) do
    if path_exists(path_join(get_root(), name)) then
      return true
    end
  end
  return false
end

local eslint_root_files = { 
  ".eslintrc",
  ".eslintrc.js",
  ".eslintrc.json"
}

local prettier_root_files = {
  ".prettierrc",
  ".prettierrc.js",
  ".prettierrc.json",
  "prettier.config.js"
}

local M = {}

M.is_eslint = function()
  return root_has_file(eslint_root_files)
end

M.is_prettier = function()
  return root_has_file(prettier_root_files) and not M.is_eslint()
end

M.is_eslint_or_prettier = function()
  return M.is_prettier() or M.is_eslint()
end

return M
