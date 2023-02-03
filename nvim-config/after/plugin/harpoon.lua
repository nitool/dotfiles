require("harpoon").setup({
    global_settings = {
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = false,
    }
})

vim.keymap.set('n', '<leader>ll', function () require("harpoon.ui").toggle_quick_menu() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>mf', function () require("harpoon.mark").add_file() end, { noremap = true, silent = true })

