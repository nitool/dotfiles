local OssomMode = require('ossommode.ossommode')

vim.api.nvim_create_autocmd("InsertCharPre", {
  callback = function()
      if vim.bo.filetype == "TelescopePrompt" then
          return
      end

      vim.schedule(function()
          OssomMode.ossom_draw()
      end, 5)
  end,
})
