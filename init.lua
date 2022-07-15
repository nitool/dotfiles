require('sets')
require('plugins')
require('maps')

local statusline = require('statusline')

vim.cmd([[
    augroup SNITOOL
        autocmd FileType php set colorcolumn=120
        autocmd FileType javascript set colorcolumn=80
        autocmd BufRead,BufNewFile *.tsx set filetype=javascript
        autocmd FileType scss setl iskeyword+=@-@
    augroup END
]])

vim.cmd [[
    syntax on
    filetype plugin on
    set background=dark
    colorscheme gruvbox
    let g:netrw_banner=0
]]

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
local on_attach = function(client, bufnr)
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

