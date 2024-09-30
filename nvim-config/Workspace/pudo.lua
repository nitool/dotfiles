vim.api.nvim_create_user_command('UnitTestCurrent', function (opts)
    local filename = vim.api.nvim_buf_get_name(0)
    vim.cmd('vsplit')
    local winid = vim.api.nvim_get_current_win()
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(winid, bufnr)
    vim.api.nvim_set_current_win(winid)
    vim.fn.jobstart('vendor/bin/phpunit --bootstrap=tests/Unit/Bootstrap.php ' .. filename, {
        stdout_buffered = true,
        on_stdout = function (j, d, e)
            if d then
                vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, d)
            end
        end,
        on_stderr = function (j, d, e)
            if d then
                vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, d)
            end
        end
    })
end, { range = true })

vim.api.nvim_create_user_command('UnitTestAll', function (opts)
    vim.cmd('vsplit')
    local winid = vim.api.nvim_get_current_win()
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(winid, bufnr)
    vim.api.nvim_set_current_win(winid)
    vim.fn.jobstart('vendor/bin/phpunit --bootstrap=tests/Unit/Bootstrap.php tests/Unit', {
        stdout_buffered = true,
        on_stdout = function (j, d, e)
            if d then
                vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, d)
            end 
        end,
        on_stderr = function (j, d, e)
            if d then
                vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, d)
            end
        end
    })
end, { range = true })

vim.api.nvim_create_user_command('StanTestCurrent', function (opts)
    local filename = vim.api.nvim_buf_get_name(0)
    vim.cmd('vsplit')
    local winid = vim.api.nvim_get_current_win()
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(winid, bufnr)
    vim.api.nvim_set_current_win(winid)
    vim.fn.jobstart('vendor/phpstan/phpstan/phpstan analyse --memory-limit=4G -c phpstan.neon ' .. filename, {
        stdout_buffered = true,
        on_stdout = function (j, d, e)
            if d then
                vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, d)
            end
        end,
        on_stderr = function (j, d, e)
            if d then
                vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, d)
            end
        end
    })
end, { range = true })

local function escape_for_regex(str)
    -- Ucieka specjalne znaki regexa
    local matches = { "(", ")", ".", "%", "+", "-", "*", "?", "[", "]", "^", "$", "{", "}", "|" }
    for _, match in ipairs(matches) do
        str = str:gsub("%" .. match, "%\\" .. match)
    end
    return str
end

vim.api.nvim_create_user_command('UnitTestCurrentByPattern', function (opts)
    local filename = vim.api.nvim_buf_get_name(0)
    vim.cmd('vsplit')
    local winid = vim.api.nvim_get_current_win()
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(winid, bufnr)
    vim.api.nvim_set_current_win(winid)
    vim.fn.jobstart('vendor/bin/phpunit --bootstrap=tests/Unit/Bootstrap.php ' .. filename .. ' --filter="/' .. escape_for_regex(opts.args) .. '/"', {
        stdout_buffered = true,
        on_stdout = function (j, d, e)
            if d then
                vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, d)
            end
        end,
        on_stderr = function (j, d, e)
            if d then
                vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, d)
            end
        end
    })
end, { range = true, nargs = '*' })

