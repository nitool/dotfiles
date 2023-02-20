require('git-worktree').setup({
    -- change_directory_command = <str> -- default: "cd",
    -- update_on_change = <boolean> -- default: true,
    -- update_on_change_command = <str> -- default: "e .",
    -- clearjumps_on_change = <boolean> -- default: true,
    -- autopush = <boolean> -- default: false,
})

local telescope = require('telescope')
telescope.load_extension("git_worktree")
vim.keymap.set('n', '<leader>ws', function () telescope.extensions.git_worktree.git_worktrees() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>wc', function () telescope.extensions.git_worktree.create_git_worktree() end, { noremap = true, silent = true })

