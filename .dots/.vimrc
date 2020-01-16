" tabs config
:set tabstop=4
:set shiftwidth=4
:set expandtab
:set autoindent

" infos
:set number
:set ruler

" search options
:set hlsearch " highlight search result
:set incsearch " jump to search result while typing
:set ignorecase
:set smartcase " if search pattern contains uppercase letter then it's case sensitive
:set wrapscan " never ending story - jump to first search result after reaching last

" clipboard
:set clipboard=unnamed

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
:silent !ctags -R -f ./.git/tags .

call plug#begin('~/.vim/plugged')
    Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

colorscheme dracula

