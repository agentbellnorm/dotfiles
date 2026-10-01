local use_lsp = require('profile').use_lsp

return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    },
    { 'itchyny/vim-cursorword' },
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    { 'windwp/nvim-ts-autotag' },
    { 'mbbill/undotree' },
    { 'tpope/vim-fugitive' },
    { 'sindrets/diffview.nvim' },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
        enabled = use_lsp,
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    },
    { 'hrsh7th/cmp-nvim-lsp-signature-help', enabled = use_lsp },
    { 'WhoIsSethDaniel/mason-tool-installer.nvim', enabled = use_lsp },
    {
        "Pocco81/auto-save.nvim",
        config = function()
            require("auto-save").setup {
                -- your config goes here
                -- or just leave it empty :)
                debounce_delay = 2000
            }
        end
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^5', -- Recommended
        lazy = false, -- This plugin is already lazy
        ft = { 'rust' },
        enabled = use_lsp,
    },
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        lazy = false,
    },
    { 'lewis6991/gitsigns.nvim' },
    { 'mg979/vim-visual-multi' },
    { 'MunifTanjim/prettier.nvim' },
    { 'nvim-treesitter/nvim-treesitter-context' },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            { 'nvim-tree/nvim-web-devicons' }
        }
    },
    { 'axelvc/template-string.nvim' },
    { 'github/copilot.vim' },
    { 'nvim-lualine/lualine.nvim' },
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("refactoring").setup()
        end,
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    { 'HiPhish/rainbow-delimiters.nvim' },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    { 'stevearc/conform.nvim', opts = {} },
    { 'mfussenegger/nvim-lint' },
    { "j-hui/fidget.nvim", opts = {  }, enabled = use_lsp }
}
