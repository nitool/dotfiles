local function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

local function nmap(shortcut, command)
  map('n', shortcut, command)
end

local function imap(shortcut, command)
  map('i', shortcut, command)
end

local function vmap(shortcut, command)
  map('v', shortcut, command)
end


nmap('<leader>lg', ':lua require("telescope.builtin").live_grep()<CR>')
nmap('<leader>ff', ':lua require("telescope.builtin").git_files()<CR>')
nmap('<leader>sf', ':lua require("telescope.builtin").find_files()<CR>')

nmap('<leader>ll', ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
nmap('<leader>mf', ':lua require("harpoon.mark").add_file()<CR>')

nmap('Y', 'yg$')
nmap('n', 'nzzzv')
nmap('N', 'Nzzzv')
nmap('J', 'mzJ`z')

imap(',', ',<c-g>u')
imap('.', '.<c-g>u')
imap('!', '!<c-g>u')
imap('?', '?<c-g>u')

vmap('J', ':m \'>+1<CR>gv=gv')
vmap('K', ':m \'<-2<CR>gv=gv')

