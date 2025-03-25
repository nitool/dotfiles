vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function (use)
    use 'wbthomason/packer.nvim'
    use 'Mofiqul/vscode.nvim'

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
    use 'numToStr/Comment.nvim'

    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/playground'

    use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v1.x',
      requires = {
          -- LSP Support
          {'neovim/nvim-lspconfig'},
          {'williamboman/mason.nvim'},
          {'williamboman/mason-lspconfig.nvim'},

          -- Autocompletion
          {'hrsh7th/nvim-cmp'},
          {'hrsh7th/cmp-buffer'},
          {'hrsh7th/cmp-path'},
          {'saadparwaiz1/cmp_luasnip'},
          {'hrsh7th/cmp-nvim-lsp'},
          {'hrsh7th/cmp-nvim-lua'},

          -- Snippets
          {'L3MON4D3/LuaSnip'},
          {'rafamadriz/friendly-snippets'},
      }
    }

    use { 'phpactor/phpactor', tag = '*', run = 'composer install --no-dev -o'}

    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    use 'windwp/nvim-projectconfig'

    use { 'airblade/vim-gitgutter' }

    use {
        'akinsho/flutter-tools.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
        },
    }

    use 'github/copilot.vim'

    use {
      "kndndrj/nvim-dbee",
      requires = {
        "MunifTanjim/nui.nvim",
      },
      run = function()
        require("dbee").install()
      end,
      config = function()
        require("dbee").setup()
      end
    }
end)

