return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    -- {
    --     'nvim-java/nvim-java',
    --     dependencies = {
    --         'nvim-java/lua-async-await',
    --         'nvim-java/nvim-java-core',
    --         'nvim-java/nvim-java-test',
    --         'nvim-java/nvim-java-dap',
    --         'MunifTanjim/nui.nvim',
    --         'neovim/nvim-lspconfig',
    --         'mfussenegger/nvim-dap',
    --         {
    --             'williamboman/mason.nvim',
    --             opts = {
    --                 registries = {
    --                     'github:nvim-java/mason-registry',
    --                     'github:mason-org/mason-registry',
    --                 },
    --             },
    --         }
    --     },
    -- },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    },
    { 'nvim-treesitter/nvim-treesitter',        build = ':TSUpdate' },
    { 'mbbill/undotree' },
    { 'tpope/vim-fugitive' },
    { 'sindrets/diffview.nvim' },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },       -- Required
            { 'williamboman/mason.nvim' },     -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' }, -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' }, -- Required
        }
    },
    { 'hrsh7th/cmp-nvim-lsp-signature-help' },
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
    { "neovim/nvim-lspconfig" },
    { 'simrat39/rust-tools.nvim' },
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        lazy = false,
    },
    { 'lewis6991/gitsigns.nvim' },
    { 'mg979/vim-visual-multi' },
    { 'jose-elias-alvarez/null-ls.nvim' },
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
    { 'LunarWatcher/auto-pairs' },
    { 'HiPhish/rainbow-delimiters.nvim' },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
}
