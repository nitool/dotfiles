vim.opt.tabstop = 4
vim.opt.shiftwidth = 4 
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.nu = true
vim.opt.ruler = true
vim.opt.relativenumber = true
vim.opt.errorbells = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrapscan = true
vim.opt.clipboard:append('unnamedplus')
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0
vim.opt.wrap = false
vim.opt.laststatus = 2
vim.opt.redrawtime = 10000
vim.opt.scrolloff = 8
vim.opt.updatetime = 300
vim.opt.shortmess:append('c')
vim.opt.cursorline = true
vim.opt.completeopt = 'menu,menuone,noselect'

vim.g.mapleader = ' '

