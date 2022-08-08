vim.api.nvim_create_user_command('HttpRequestTest', function (opts)
    local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, true)
    local text = table.concat(lines, '\n')
    text = './http-requests-tester --verbose --selected-client test -- <<-EOF\n' .. text
    local bufnr = vim.api.nvim_create_buf(false, true)
    local winid = vim.api.nvim_open_win(bufnr, false, {relative='cursor', row=3, col=3, width=120, height=40})
    vim.api.nvim_set_current_win(winid)
    vim.fn.jobstart(text, {
        stdout_buffered = true,
        on_stdout = function (j, d, e)
            vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, d)
        end
    })
end, { range = true })
