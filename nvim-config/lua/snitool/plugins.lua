vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function (use)
    use 'wbthomason/packer.nvim'

    use 'morhetz/gruvbox'

    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.5',
      requires = { {'nvim-lua/plenary.nvim'} }
    }

    use 'mbbill/undotree'

    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = {
            {"nvim-lua/plenary.nvim"}
        }
    }

    use 'tpope/vim-fugitive'
    use { 'airblade/vim-gitgutter' }

    use 'numToStr/Comment.nvim'

    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/playground'

    use 'neovim/nvim-lspconfig'

    use {
        'williamboman/mason.nvim',
        run = function()
            pcall(vim.cmd, 'MasonUpdate')
        end,
    }

    use 'williamboman/mason-lspconfig.nvim'

    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'

    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'rafamadriz/friendly-snippets'

    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    use 'windwp/nvim-projectconfig'

    use {
        'akinsho/flutter-tools.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'neovim/nvim-lspconfig',
        },
    }

    use 'github/copilot.vim'
end)
