local M = {}

function M.setup()
  -- Getting the highlight group details
  local normal_hl = vim.api.nvim_get_hl(0, { name = 'Normal' })

  -- Extracting the foreground color
  local normal_fg = normal_hl.fg

  -- Assuming the value is in RGB, apply it to WinSeparator
  if normal_fg then
    vim.cmd(string.format('hi WinSeparator guifg=#%06x guibg=none', normal_fg))
  else
  end

  vim.cmd([[ colorscheme gotham ]])

  --vim.cmd(string.format('hi WinSeparator guifg=#%06x guibg=none', normal_fg))
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


  vim.cmd([[
    highlight BufferLineFill guifg=#052336 guibg=#052336
    highlight BufferLineSeparatorSelected guifg=#052336 guibg=#0c1014
    highlight BufferLineSeparatorVisible guifg=#052336 guibg=#0b0e12
    highlight BufferLineSeparator guifg=#052336 guibg=#090c0f
  ]])
  --vim.cmd([[
    --highlight BufferLineFill guifg=#195466 guibg=#195466
    --highlight BufferLineSeparatorSelected guifg=#195466 guibg=#0c1014
    --highlight BufferLineSeparatorVisible guifg=#195466 guibg=#0b0e12
    --highlight BufferLineSeparator guifg=#195466 guibg=#090c0f
  --]])
  --vim.cmd([[
    --highlight BufferLineFill guifg=#ff0055 guibg=#ff0055
    --highlight BufferLineSeparatorSelected guifg=#ff0055 guibg=#0c1014
    --highlight BufferLineSeparatorVisible guifg=#ff0055 guibg=#0b0e12
    --highlight BufferLineSeparator guifg=#ff0055 guibg=#090c0f
  --]])
end
M.setup()
return M
