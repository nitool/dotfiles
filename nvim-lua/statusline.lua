local ts_utils = require 'nvim-treesitter.ts_utils'

local function get_node_name(node, field)
    local node_name = node:type();
    for child in node:iter_children() do
        if child:type() == field then
            local row1, col1, row2, col2 = child:range();
            local lines = vim.api.nvim_buf_get_lines(0, row1, row1 + 1, true);
            local line = lines[0] or lines[1];
            node_name = line:sub(col1, col2):gsub('%s+', '');

            break;
        end
    end

    return node_name;
end

local function get_reference(node)
    local parent = node:parent();
    if parent == nil then
        local node_name = node:type();
        for child in node:iter_children() do
            if child:type() == 'namespace_definition' then
                node_name = get_node_name(child, 'namespace_name');

                break;
            end
        end

        return node_name;
    end

    if vim.tbl_contains({'method_declaration', 'class_declaration'}, node:type()) == false then
        return get_reference(parent);
    end

    return get_reference(parent) .. '->' .. get_node_name(node, 'name');
end

local function lsp_status()
    local node = ts_utils.get_node_at_cursor();
    if node == nil then
        return '';
    end

    return get_reference(node);
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

