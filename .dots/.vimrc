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
set redrawtime=10000

" netrw
let g:netrw_banner=0

" syntax
syntax on
filetype plugin on

" configs
autocmd FileType php set colorcolumn=120
autocmd FileType javascript set colorcolumn=80

" maps
nnoremap <C-l> :Lexplore<CR>:vertical resize 50<CR>

