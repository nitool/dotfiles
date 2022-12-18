require('sets')
require('plugins')
require('maps')

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
    colorscheme dracula
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
            theme = "ivy",
            no_ignore = true,
            no_ignore_parent = true
        },
        live_grep = {
            theme = "ivy"
        },
        lsp_references = {
            theme = "ivy",
            show_line = false
        },
        lsp_definitions = {
            theme = "ivy",
            show_line = false
        }
    }
})

require('nvim-projectconfig').setup({
  project_dir = "~/.config/nvim/Workspace/",
})

require('lsp')
local References = require('reference')

vim.api.nvim_create_user_command('GetCurrentReference', function (opts)
    local reference = References.get_reference()
    vim.fn.jobstart('echo "' .. reference .. '" | xclip -sel clip')
    print(reference)
end, { range = true })

vim.api.nvim_create_user_command('GetFileReference', function (opts)
    local reference = References.get_file_reference()
    vim.fn.jobstart('echo "' .. reference .. '" | xclip -sel clip')
    print(reference)
end, {})

require('statusline')

