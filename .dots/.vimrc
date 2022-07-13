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

let g:currentmode={
       \ 'n'  : 'NORMAL ',
       \ 'v'  : 'VISUAL ',
       \ 'V'  : 'V·Line ',
       \ "\<C-V>" : 'V·Block ',
       \ 'i'  : 'INSERT ',
       \ 'R'  : 'R ',
       \ 'Rv' : 'V·Replace ',
       \ 'c'  : 'Command ',
       \}

set completeopt=menu,menuone,noselect

lua <<EOF
require('sets')
require('plugins')
vim.cmd [[
    syntax on
    filetype plugin on
    set background=dark
    colorscheme gruvbox
    let g:netrw_banner=0
]]

function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function vmap(shortcut, command)
  map('v', shortcut, command)
end


nmap('<leader>lg', ':lua require("telescope.builtin").live_grep()<CR>')
nmap('<leader>ff', ':lua require("telescope.builtin").git_files()<CR>')

nmap('<leader>ll', ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
nmap('<leader>g1', ':lua require("harpoon.ui").nav_file(1)<CR>')
nmap('<leader>g2', ':lua require("harpoon.ui").nav_file(2)<CR>')
nmap('<leader>g3', ':lua require("harpoon.ui").nav_file(3)<CR>')
nmap('<leader>g4', ':lua require("harpoon.ui").nav_file(4)<CR>')
nmap('<leader>g5', ':lua require("harpoon.ui").nav_file(5)<CR>')
nmap('<leader>g6', ':lua require("harpoon.ui").nav_file(6)<CR>')
nmap('<leader>g7', ':lua require("harpoon.ui").nav_file(7)<CR>')
nmap('<leader>g8', ':lua require("harpoon.ui").nav_file(8)<CR>')
nmap('<leader>g9', ':lua require("harpoon.ui").nav_file(9)<CR>')
nmap('<leader>mf', ':lua require("harpoon.mark").add_file()<CR>')

nmap('Y', 'yg$')
nmap('n', 'nzzzv')
nmap('N', 'Nzzzv')
nmap('J', 'mzJ`z')

imap(',', ',<c-g>u')
imap('.', '.<c-g>u')
imap('!', '!<c-g>u')
imap('?', '?<c-g>u')

vmap('J', ':m \'>+1<CR>gv=gv')
vmap('K', ':m \'<-2<CR>gv=gv')


local treesitter_statusline = require'nvim-treesitter'.statusline {
    indicator_size = 100
}

print(treesitter_statusline)

vim.o.statusline = ""
vim.o.statusline = vim.o.statusline .. " %{toupper(g:currentmode[mode()])}"
vim.o.statusline = vim.o.statusline .. " %F"
vim.o.statusline = vim.o.statusline .. " %{FugitiveStatusline()}"
if treesitter_statusline ~= nil then
    vim.o.statusline = vim.o.statusline .. " sadasd " .. treesitter_statusline
end

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "rust", "javascript", "php" },
  sync_install = false,
  highlight = {
    enable = false,
    additional_vim_regex_highlighting = false,
  },
}

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
            theme = "ivy"
        },
        find_files = {
            theme = "dropdown"
        },
        live_grep = {
            theme = "ivy"
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
    'phpactor',
    'tsserver'
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

