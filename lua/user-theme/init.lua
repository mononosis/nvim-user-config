local M = {}

function M.setup()
  -- Getting the highlight group details
  local normal_hl = vim.api.nvim_get_hl(0, { name = 'Normal' })

  -- Extracting the foreground color
  local normal_fg = normal_hl.fg

  -- Assuming the value is in RGB, apply it to WinSeparator
  if normal_fg then
    vim.cmd(string.format('hi WinSeparator guifg=#%06x guibg=none', normal_fg))
    print("Failed to get 'Normal' highlight foreground color")
  else
  end

  vim.cmd(string.format('hi WinSeparator guifg=#%06x guibg=none', normal_fg))
  -- Get this ascii chars from Box-drawing characters
  vim.opt.fillchars = {
    eob       = ' ',
    horiz     = '━',
    horizup   = '┻',
    horizdown = '┳',
    vert      = '║',
    vertleft  = '║',
    vertright = '║',
    verthoriz = '╋',
  }
  -- For dark themes use a bright color to distinguish the root folder from the others
  vim.cmd [[highlight NvimTreeRootFolder guifg=#FFFFFF]]

  vim.cmd([[colorscheme gotham]])
end

return M
