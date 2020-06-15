" tabs config
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

" infos
set number
set ruler
set rnu
set noerrorbells

" swapfiles
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" search options
set hlsearch " highlight search result
set incsearch " jump to search result while typing
set ignorecase
set smartcase " if search pattern contains uppercase letter then it's case sensitive
set wrapscan " never ending story - jump to first search result after reaching last

" clipboard
set clipboard=unnamedplus

" wrapping
set textwidth=0
set wrapmargin=0
set wrap!

" status line
set laststatus=2

" syntax
syntax on
filetype plugin on

" tags
set tags^=.git/tags;~

call plug#begin('~/.config/nvim/plugged')
    Plug 'morhetz/gruvbox'
    Plug 'StanAngeloff/php.vim'
    Plug 'phpactor/phpactor', {'for': 'php'}
    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'
    Plug 'phpactor/ncm2-phpactor'
    Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

colorscheme gruvbox
set bg=dark

autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

" mappings
let mapleader=" "

"" phps
autocmd FileType php nnoremap <buffer> <leader>im :PhpactorImportMissingClass<CR>

"" global
nnoremap <M-1> :Lexplore<CR>:vertical resize 50<CR>
nnoremap <C-n> :CtrlP<CR>

