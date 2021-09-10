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
set clipboard+=unnamedplus
set textwidth=0
set wrapmargin=0
set nowrap
set laststatus=2
set redrawtime=10000
set scrolloff=8
set updatetime=300
set shortmess+=c

syntax on
filetype plugin on

call plug#begin()
    Plug 'morhetz/gruvbox'

    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " CocInstall coc-json coc-tsserver coc-sh @yaegassy/coc-intelephense
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

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gr <Plug>(coc-references)

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

