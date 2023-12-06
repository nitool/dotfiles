vim.keymap.set('n', 'Y', 'yg$', { noremap = true, silent = true })
vim.keymap.set('n', 'n', 'nzzzv', { noremap = true, silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true, silent = true })
vim.keymap.set('n', 'J', 'mzJ`z', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>tn', ':tabnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tp', ':tabprev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tt', ':tabnew<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<F1>', ':Telescope help_tags<CR>', { noremap = true, silent = true })

vim.keymap.set('i', ',', ',<c-g>u', { noremap = true, silent = true })
vim.keymap.set('i', '.', '.<c-g>u', { noremap = true, silent = true })
vim.keymap.set('i', '!', '!<c-g>u', { noremap = true, silent = true })
vim.keymap.set('i', '?', '?<c-g>u', { noremap = true, silent = true })

vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv', { noremap = true, silent = true })
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv', { noremap = true, silent = true })


