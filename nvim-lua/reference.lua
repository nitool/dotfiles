local ts_utils = require 'nvim-treesitter.ts_utils'

local references_processors = {
    php = require('references/php')
}

local M = {}

M.get_reference = function ()
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

M.get_file_reference = function ()
    return vim.fn.expand('%') .. ':' .. vim.fn.getcurpos()[2];
end

return M
