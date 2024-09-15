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

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<leader>ll", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })

vim.api.nvim_create_user_command('ClearHarpoon', function (opts)
    harpoon:list():clear()
end, { range = true })

