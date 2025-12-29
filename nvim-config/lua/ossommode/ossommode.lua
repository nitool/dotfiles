local M = {}

local active = {}

vim.api.nvim_set_hl(0, "OssomFloat", { bg = "NONE" })
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
  local text = "🔥"
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { text })

  local win = vim.api.nvim_open_win(buf, false, {
    relative = "cursor",
    row = 1,
    col = 1 + #active,
    width = 3,
    height = 1,
    style = "minimal",
    border = "",
  })

  vim.api.nvim_win_set_option(
    win,
    "winhl",
    "Normal:OssomFloat,FloatBorder:OssomBorder"
  )

  if #active > 0 then
    remove_old()
  end

  table.insert(active, win)
  vim.defer_fn(function()
    remove_old()
  end, 600)
end

return M
