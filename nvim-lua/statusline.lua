local ts_utils = require 'nvim-treesitter.ts_utils'

local references_processors = {
    php = require('references/php')
}

local function lsp_status()
    local filetype = vim.api.nvim_buf_get_option(0, 'filetype');
    if references_processors[filetype] == nil then
        return nil
    end

    local node = ts_utils.get_node_at_cursor();
    if node == nil then
        return '';
    end

    return references_processors[filetype].get_reference(node);
end

require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false,
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics', lsp_status},
        lualine_c = {function ()
            return vim.api.nvim_buf_get_name(0);
        end},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
})

