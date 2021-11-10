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
    " CocInstall coc-json coc-tsserver coc-sh @yaegassy/coc-intelephense coc-css

    Plug 'nvim-lua/popup.nvim'
    Plug 'ThePrimeagen/harpoon'
call plug#end()

colorscheme gruvbox
let g:netrw_banner=0

augroup SNITOOL
    autocmd FileType php set colorcolumn=120
    autocmd FileType javascript set colorcolumn=80
    autocmd BufRead,BufNewFile *.tsx set filetype=javascript
    autocmd FileType scss setl iskeyword+=@-@
    autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

let mapleader = " "
nnoremap <leader>lg :lua require("telescope.builtin").live_grep()<CR>
nnoremap <leader>ff :lua require("telescope.builtin").git_files()<CR>

nnoremap <leader>ll :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <leader>g1 :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <leader>g2 :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <leader>g3 :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <leader>g4 :lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <leader>g5 :lua require("harpoon.ui").nav_file(5)<CR>
nnoremap <leader>g6 :lua require("harpoon.ui").nav_file(6)<CR>
nnoremap <leader>g7 :lua require("harpoon.ui").nav_file(7)<CR>
nnoremap <leader>g8 :lua require("harpoon.ui").nav_file(8)<CR>
nnoremap <leader>g9 :lua require("harpoon.ui").nav_file(9)<CR>
nnoremap <leader>mf :lua require("harpoon.mark").add_file()<CR>

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gr <Plug>(coc-references)

nnoremap Y yg$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

lua <<EOF
require("harpoon").setup({
    global_settings = {
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = false,
    }
})
EOF
