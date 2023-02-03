local References = require('references.reference')

vim.api.nvim_create_user_command('GetCurrentReference', function (opts)
    local reference = References.get_reference()
    vim.fn.jobstart('echo "' .. reference .. '" | xclip -sel clip')
    print(reference)
end, { range = true })

vim.api.nvim_create_user_command('GetFileReference', function (opts)
    local reference = References.get_file_reference()
    vim.fn.jobstart('echo "' .. reference .. '" | xclip -sel clip')
    print(reference)
end, {})

