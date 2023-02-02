vim.api.nvim_create_user_command('UnitTestCurrent', function (opts)
    vim.cmd('vsplit')
    local filename = vim.api.nvim_buf_get_name(0)
    local winid = vim.api.nvim_get_current_win()
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(winid, bufnr)
    vim.fn.jobstart('vendor/bin/phpunit ' .. filename, {
        stdout_buffered = true,
        on_stdout = function (j, d, e)
            vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, d)
        end
    })
end, { range = true })

vim.api.nvim_create_user_command('UnitTestAll', function (opts)
    vim.cmd('vsplit')
    local winid = vim.api.nvim_get_current_win()
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(winid, bufnr)
    vim.fn.jobstart('vendor/bin/phpunit', {
        stdout_buffered = true,
        on_stdout = function (j, d, e)
            vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, d)
        end
    })
end, { range = true })
