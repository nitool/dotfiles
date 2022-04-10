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

    " sudo npm install intelephense -g
    " sudo npm i -g bash-language-server
    " sudo ln -s ~/.local/share/nvim/plugged/phpactor/bin/phpactor /usr/local/bin/phpactor
    Plug 'neovim/nvim-lspconfig'

    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'

    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'

    Plug 'phpactor/phpactor', {'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o'}

    Plug 'nvim-lua/popup.nvim'
    Plug 'ThePrimeagen/harpoon'

    Plug 'mtth/scratch.vim'
call plug#end()

set background=dark
colorscheme gruvbox
let g:netrw_banner=0

augroup SNITOOL
    autocmd FileType php set colorcolumn=120
    autocmd FileType javascript set colorcolumn=80
    autocmd BufRead,BufNewFile *.tsx set filetype=javascript
    autocmd FileType scss setl iskeyword+=@-@
augroup END

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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

nmap <silent> <leader>ms :Scratch<CR>

set completeopt=menu,menuone,noselect

lua <<EOF
local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function (args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item()),
    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item()),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }
  }, {
    { name = 'buffer' },
  }),
  experimental = {
      ghost_text = true
  }
})

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

require("harpoon").setup({
    global_settings = {
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = false,
    }
})

require("telescope").setup({
    pickers = {
        git_files = {
            theme = "dropdown"
        },
        find_files = {
            theme = "dropdown"
        },
        live_grep = {
            theme = "dropdown"
        }
    },
    defaults = {
        file_ignore_patterns = {
            "node_modules",
            "vendor/.*",
            ".git/.*"
        }
    }
})

local opts = { noremap=true, silent=true }
-- vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
-- vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
-- See `:help vim.lsp.*` for documentation on any of the below functions
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
end

local servers = {
    'rust_analyzer',
    'intelephense',
    'cssls',
    'html',
    'bashls',
    'phpactor'
}

for _, lsp in pairs(servers) do
  require("lspconfig")[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF
