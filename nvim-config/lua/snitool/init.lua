require('snitool.sets');
require('snitool.maps');
require('snitool.plugins');

vim.cmd([[
    augroup SNITOOL
        autocmd FileType php set colorcolumn=120
        autocmd FileType javascript set colorcolumn=80
        autocmd BufRead,BufNewFile *.tsx set filetype=javascript
        autocmd FileType scss setl iskeyword+=@-@
    augroup END
]])

vim.cmd [[
    syntax on
    filetype plugin on
    set background=light
    let g:netrw_banner=0
]]

-- NOTE: don't use `:colorscheme achroma` — colors/achroma.lua in the plugin
-- hardcodes `set background=dark` before calling setup(), which would
-- override this. Calling setup() directly does everything colorscheme would.
require('achroma').setup({ mode = 'light' })

