require('nvim-projectconfig').setup({
  project_dir = "~/.config/nvim/Workspace/",
})

local function load_worktree_config()
  local cwd = vim.fn.getcwd()
  local branches_dir, branch = cwd:match('.+/([^/]+%.branches)/([^/]+)$')
  if not (branches_dir and branch) then return end

  local project = branches_dir:gsub('%.branches$', '')
  local base_dir = vim.fn.expand('~/.config/nvim/Workspace/')

  local shared = base_dir .. project .. '.lua'
  if vim.fn.filereadable(shared) == 1 then
    dofile(shared)
  end

  local per_branch = base_dir .. branches_dir .. '/' .. branch .. '.lua'
  if vim.fn.filereadable(per_branch) == 1 then
    dofile(per_branch)
  end
end

load_worktree_config()

vim.api.nvim_create_autocmd('DirChanged', {
  callback = load_worktree_config,
})

