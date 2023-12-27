local lsp = require("lsp-zero")

lsp.preset('recommended')

-- available servers: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
lsp.ensure_installed({
    'tsserver',
    -- 'eslint',
    'rust_analyzer',
    'lua_ls',
    'bashls',
    'pyright',
    'biome',
    'jdtls',
    'html',
    'wgsl_analyzer',
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp.mapping(function(fallback)
        fallback()
    end, { 'i', 's' }),
})
lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
    -- open error, full error message
    vim.keymap.set('n', '<leader>e', function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
    -- code action
    vim.keymap.set('n', '<leader>a', function() vim.lsp.buf.code_action() end, opts)
    -- show references
    vim.keymap.set('n', 'F', function() require('telescope.builtin').lsp_references() end,
        { noremap = true, silent = true, buffer = bufnr })
    -- search in buffer
    vim.keymap.set('n', '<leader>/', function() require('telescope.builtin').current_buffer_fuzzy_find() end,
        { noremap = true, silent = true, buffer = bufnr })
    -- rename variable
    vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set('n', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()


--


-- disable autoformatting with tsserver, (using prettier instead)
require('lspconfig').tsserver.setup({
    on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentFormattingRangeProvider = false
    end
})

vim.cmd([[
    au BufNewFile,BufRead *.wgsl set filetype=wgsl
]])
