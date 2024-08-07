local M = {}

function M.setup()
  -- Disable backup
  vim.opt.backup = false
  -- set termguicolors (term gui color meaning 24 bits colors RGB which has a wider spectrum of colors)
  -- to enable highlight groups
  vim.opt.termguicolors = true
  vim.opt.history = 1000      -- How many number of lines are kept in the command history
  vim.opt.number = true       -- Enable line numbers
  vim.opt.relativenumber = true -- Enable relative line numbers
  vim.opt.showtabline = 2
  --vim.opt.mousemoveevent = true
  -- Enable mouse move events
  vim.o.mousemoveevent = true


  vim.opt_local.tabstop = 1
  vim.opt_local.shiftwidth = 2
  vim.opt_local.expandtab = true
end

return M
