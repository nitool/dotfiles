require("telescope").setup({
    pickers = {
        git_files = {
            theme = "ivy"
        },
        find_files = {
            theme = "ivy",
            no_ignore = true,
            no_ignore_parent = true
        },
        live_grep = {
            theme = "ivy"
        },
        lsp_references = {
            theme = "ivy",
            show_line = false
        },
        lsp_definitions = {
            theme = "ivy",
            show_line = false
        }
    }
})

local telescope_builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>lg', function () telescope_builtin.live_grep() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ff', function () telescope_builtin.git_files() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>sf', function () telescope_builtin.find_files() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gs', function () telescope_builtin.grep_string() end, { noremap = true, silent = true })

