function test_http(env, opts)
    local filename = vim.api.nvim_buf_get_name(0)
    local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, true)
    local text = table.concat(lines, '\n')
    local client_file
    local selected_client

    if env == 'dev' then
        client_file = './tests/API-Requests/rest-client.private.env.json'
        selected_client = 'rest_api_dev'
    elseif env == 'dev_old' then
        client_file = './tests/API-Requests/rest-client.private.env.json'
        selected_client = 'devel'
    else
        client_file = './tests/API-Requests/rest-client.env.json'
        selected_client = 'rest_api_sandbox'
    end

    local bufnr = vim.api.nvim_create_buf(false, true)
    local winid

    if opts.line1 ~= opts.line2 then
        text = './tests/API-Requests/node_modules/.bin/http-requests-tester --verbose --autolog-response --client-file ' .. client_file .. ' --selected-client ' .. selected_client .. ' -- <<-EOF\n' .. text
        winid = vim.api.nvim_open_win(bufnr, false, {relative='cursor', row=3, col=3, width=120, height=40})
    else
        vim.cmd('vsplit')
        text = './tests/API-Requests/node_modules/.bin/http-requests-tester --verbose --autolog-response --client-file ' .. client_file .. ' --selected-client ' .. selected_client .. ' ' .. filename
        print(text)
        winid = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(winid, bufnr)
    end

    vim.api.nvim_set_current_win(winid)
    vim.fn.jobstart(text, {
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
end

vim.api.nvim_create_user_command('RestTestDev', function (opts)
    test_http('dev', opts)
end, { range = true })

vim.api.nvim_create_user_command('RestTestDevOld', function (opts)
    test_http('dev_old', opts)
end, { range = true })

vim.api.nvim_create_user_command('RestTestTest', function (opts)
    test_http('test', opts)
end, { range = true })

vim.api.nvim_create_user_command('UnitTestCurrent', function (opts)
    local filename = vim.api.nvim_buf_get_name(0)
    vim.cmd('vsplit')
    local winid = vim.api.nvim_get_current_win()
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(winid, bufnr)
    vim.api.nvim_set_current_win(winid)
    vim.fn.jobstart('vendor/bin/phpunit --bootstrap=tests/Bootstrap.php ' .. filename, {
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
    vim.fn.jobstart('vendor/bin/phpunit --bootstrap=tests/Bootstrap.php tests', {
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

local Worktree = require("git-worktree")

Worktree.on_tree_change(function(op, metadata)
  if op == Worktree.Operations.Switch then
    print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
    vim.fn.jobstart('ln -fs ' .. metadata.path .. ' /home/$USER/Workspace/grupa.furgonetka.pl')
  end
end)

