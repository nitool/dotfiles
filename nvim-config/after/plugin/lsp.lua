local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'rust_analyzer',
    'intelephense',
    'cssls',
    'html',
    'bashls',
    'phpactor',
    'tsserver',
    'sumneko_lua'
})

-- Fix Undefined global 'vim'
lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
  ['<Enter>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp', keyword_length = 3},
    {name = 'cmp_tabnine'},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  }
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set('n', '<leader>gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', '<leader>rn', function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set('n', '<leader>gr', function() vim.lsp.buf.references() end, opts)
    vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', '<leader>ch', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', '<leader>sd', vim.diagnostic.open_float, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

