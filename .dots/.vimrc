set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set number
set ruler
set rnu
set noerrorbells
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan
set clipboard=unnamedplus
set textwidth=0
set wrapmargin=0
set nowrap
set laststatus=2
set redrawtime=10000
set scrolloff=8

syntax on
filetype plugin on

call plug#begin()
    Plug 'morhetz/gruvbox'

    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
call plug#end()

colorscheme gruvbox
let g:netrw_banner=0

augroup SNITOOL
    autocmd FileType php set colorcolumn=120
    autocmd FileType javascript set colorcolumn=80
    autocmd BufRead,BufNewFile *.tsx set filetype=javascript
augroup END

let mapleader = " "
nnoremap <leader>lg :lua require("telescope.builtin").grep_string()<CR>
nnoremap <leader>ff :lua require("telescope.builtin").git_files()<CR>

