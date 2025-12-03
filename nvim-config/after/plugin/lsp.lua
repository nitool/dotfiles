local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

mason.setup()

local servers = {
    "rust_analyzer",
    "intelephense",
    "cssls",
    "html",
    "bashls",
    "phpactor",
    "lua_ls",
    "ts_ls",
}

mason_lspconfig.setup({
    ensure_installed = servers,
    automatic_enable = false,
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    mapping = {
        ['<S-Tab>']   = cmp.mapping.select_prev_item(cmp_select),
        ['<Tab>']     = cmp.mapping.select_next_item(cmp_select),
        ['<CR>']      = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    },
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'buffer',   keyword_length = 3 },
        -- { name = 'luasnip', keyword_length = 2 },
    },
    snippet = {
        expand = function(_)
        end,
    },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
    virtual_text = true,
})

local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set('n', '<leader>gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', '<leader>rn', function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set('n', '<leader>gr', function() vim.lsp.buf.references() end, opts)
    vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', '<leader>cf', function() vim.lsp.buf.format() end, opts)
    vim.keymap.set('n', '<leader>ch', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', '<leader>sd', vim.diagnostic.open_float, opts)

    if vim.lsp.inlay_hint and vim.lsp.inlay_hint.enable then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
end

for _, server_name in ipairs(servers) do
    local opts = {
        on_attach = on_attach,
        capabilities = capabilities,
    }

    if server_name == "lua_ls" then
        opts.settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
            },
        }
    elseif server_name == "ts_ls" then
        opts.filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
        }
    end

    vim.lsp.config(server_name, opts)
end

vim.lsp.enable(servers)

require("flutter-tools").setup {}

vim.keymap.set('i', '<C-O>', '<Plug>(copilot-suggest)')
vim.keymap.set('i', '<C-\\>', 'copilot#Accept("<CR>")', {
    expr = true,
    replace_keycodes = false,
})

vim.g.copilot_no_tab_map = true
vim.g.copilot_filetypes = {
    ['*'] = false
}
