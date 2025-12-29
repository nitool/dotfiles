local M = {}
local active = {}

vim.api.nvim_set_hl(0, "OssomFloatDeep",   { fg = "#ff0000", bg = "NONE" })
vim.api.nvim_set_hl(0, "OssomFloatOrange", { fg = "#ff8800", bg = "NONE" })
vim.api.nvim_set_hl(0, "OssomFloatYellow", { fg = "#ffd000", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "OssomFloatSmoke",  { fg = "#808080", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "OssomBorder", { bg = "NONE" })

local function remove_old()
    if #active < 1 then
        return
    end

    local old = table.remove(active, 1)
    if vim.api.nvim_win_is_valid(old) then
        vim.api.nvim_win_close(old, true)
    end
end

M.ossom_draw = function()
    local text = ">"
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { text })

    local winid = vim.api.nvim_get_current_win()
    local row = vim.fn.winline() - 1
    local col = vim.fn.wincol() - 1

    local win = vim.api.nvim_open_win(buf, false, {
        relative = "win",
        win = winid,
        row = row + 1,
        col = col + 2,
        width = 1,
        height = 1,
        style = "minimal",
        border = "",
    })

    local winhl = "Normal:OssomFloatDeep,FloatBorder:OssomBorder"
    if #active > 6 then
        winhl = "Normal:OssomFloatSmoke,FloatBorder:OssomBorder"
    elseif #active > 4 then
        winhl = "Normal:OssomFloatYellow,FloatBorder:OssomBorder"
    elseif #active > 3 then
        winhl = "Normal:OssomFloatOrange,FloatBorder:OssomBorder"
    end

    vim.api.nvim_win_set_option(win, "winhl", winhl)

    table.insert(active, win)
    vim.defer_fn(function()
        remove_old()
    end, 300)
end

return M
