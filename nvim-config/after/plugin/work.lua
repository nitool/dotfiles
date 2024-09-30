local Work = require('work.work')

vim.api.nvim_create_autocmd("VimEnter", { callback = Work.start_work })
vim.api.nvim_create_autocmd("VimLeave", { callback = Work.stop_work })

