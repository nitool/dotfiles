local ts_utils = require 'nvim-treesitter.ts_utils'

local M = {}

M.get_node_name = function (node, field)
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

M.get_reference = function (node)
    local parent = node:parent();
    if parent == nil then
        local node_name = node:type();
        for child in node:iter_children() do
            if child:type() == 'namespace_definition' then
                node_name = M.get_node_name(child, 'namespace_name');

                break;
            end
        end

        return node_name;
    end

    if vim.tbl_contains({'method_declaration', 'class_declaration'}, node:type()) == false then
        return M.get_reference(parent);
    end

    local separator = ''
    if vim.tbl_contains({'method_declaration'}, node:type()) == true then
        separator = '::'
    else
        separator = '\\'
    end

    return M.get_reference(parent) .. separator .. M.get_node_name(node, 'name');
end

return M

