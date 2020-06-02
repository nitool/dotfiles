" tabs config
:set tabstop=4
:set shiftwidth=4
:set expandtab
:set autoindent

" infos
:set number
:set ruler
:set rnu
:set noerrorbells

" swapfiles
:set noswapfile
:set nobackup
:set undodir=~/.vim/undodir
:set undofile

" search options
:set hlsearch " highlight search result
:set incsearch " jump to search result while typing
:set ignorecase
:set smartcase " if search pattern contains uppercase letter then it's case sensitive
:set wrapscan " never ending story - jump to first search result after reaching last

" clipboard
:set clipboard=unnamedplus

" wrapping
:set textwidth=0
:set wrapmargin=0
:set wrap!

" status line
:set laststatus=2

" syntax
syntax on
filetype plugin on

" tags
" requires ctags
" requires running vim in root directory
" @todo: update so it always create 'tags' file in root directory
" :silent !ctags -R -f ./.git/tags 
:set tags^=.git/tags;~

call plug#begin('~/.vim/plugged')
    Plug 'morhetz/gruvbox'
call plug#end()

colorscheme gruvbox
:set bg=dark

