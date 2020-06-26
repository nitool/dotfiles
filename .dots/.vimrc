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
set nofoldenable

" status line
set laststatus=2

" syntax
syntax on
filetype plugin on

" tags
set tags^=.git/tags;~
autocmd BufWritePost *.php,*.js,*.ts,*.json,*.css,*.scss,*.py :silent !test -d .git && ctags -a -R --tag-relative -f .git/tags . 2>&1 /dev/null &

call plug#begin('~/.config/nvim/plugged')
    Plug 'morhetz/gruvbox'
    Plug 'StanAngeloff/php.vim'
    Plug 'phpactor/phpactor', {'for': 'php'}
    Plug 'ncm2/ncm2', {'for': 'php'}
    Plug 'roxma/nvim-yarp', {'for': 'php'}
    Plug 'phpactor/ncm2-phpactor', {'for': 'php'}
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'tpope/vim-fugitive'
    Plug 'nelsyeung/twig.vim'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'ncm2/ncm2-ultisnips'
call plug#end()

colorscheme gruvbox
set bg=dark

autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

" mappings
let mapleader=" "

"" php
autocmd FileType php nnoremap <buffer> <leader>im :PhpactorImportMissingClass<CR>
autocmd FileType php nnoremap <buffer> <F4> :PhpactorGotoDefinition<CR>
autocmd FileType php nnoremap <buffer> <M-7> :PhpactorFindReferences<CR>
autocmd FileType php nnoremap <buffer> <leader><F12> :PhpactorTransform<CR>
autocmd FileType php inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
autocmd FileType php inoremap <expr> <Tab> (pumvisible() ? "\<C-n>" : "\<Tab>")
autocmd FileType php inoremap <expr> <S-Tab> (pumvisible() ? "\<C-p>" : "\<S-Tab>")

"" global
nnoremap <M-1> :Lexplore<CR>:vertical resize 50<CR>
nnoremap <leader><C-f> :Ag<CR>
nnoremap <leader><C-e> :History<CR>
nnoremap <C-n> :CtrlP<CR>

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"
let g:UltiSnipsEditSplit="vertical"

