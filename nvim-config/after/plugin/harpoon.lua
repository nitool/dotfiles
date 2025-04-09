local harpoon = require('harpoon')
harpoon:setup({
    settings = {
        sync_on_ui_close = true
    }
})

vim.keymap.set("n", "<leader>mf", function() harpoon:list():add() end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>h]", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>h[", function() harpoon:list():next() end)

vim.keymap.set("n", "<leader>ll", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Open harpoon window" })


