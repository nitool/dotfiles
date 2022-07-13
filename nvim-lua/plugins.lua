vim.cmd [[packadd packer.nvim]]

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require("packer").startup(function()
    use 'wbthomason/packer.nvim'
    use 'morhetz/gruvbox'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'

    -- sudo npm install intelephense -g
    -- sudo npm i -g bash-language-server
    -- sudo ln -s ~/.local/share/nvim/plugged/phpactor/bin/phpactor /usr/local/bin/phpactor
    -- sudo npm i -g typescript typescript-language-server
    use 'neovim/nvim-lspconfig'

    -- :TSInstall php
    -- :TSInstall rust
    -- :TSInstall javascript
    use { 'nvim-treesitter/nvim-treesitter', run = function() require('nvim-treesitter.install').update({ with_sync = true }) end}

    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    use { 'phpactor/phpactor', tag = '*', run = 'composer install --no-dev -o'}

    use 'nvim-lua/popup.nvim'
    use 'ThePrimeagen/harpoon'

    use 'tpope/vim-fugitive'

    if packer_bootstrap then
      require('packer').sync()
    end
end)

