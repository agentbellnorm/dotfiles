return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'rose-pine/neovim', name = 'rose-pine', config = function()
		vim.cmd('colorscheme rose-pine')
	end
    },
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    { 'mbbill/undotree' },
    { 'tpope/vim-fugitive' },
    {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required
    }
  }
}
