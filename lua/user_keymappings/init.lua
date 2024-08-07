local M = {}
function M.setup()
  -- Map leader
  vim.g.mapleader = ","

  -- Move to all directions from pane to pane or side bar without the extra hassle
  vim.api.nvim_set_keymap('n', '<C-j>', '<C-W>j', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<C-k>', '<C-W>k', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<C-h>', '<C-W>h', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<C-l>', '<C-W>l', { noremap = true, silent = true })

  -- Fast escape
  vim.api.nvim_set_keymap('i', 'jh', '<Esc>', { noremap = true, silent = true })

  -- Setting the <Leader>w keybinding in normal mode
  vim.api.nvim_set_keymap('n', '<Leader>w', ':update<CR>', { noremap = true, silent = true })

  -- Setting the <Leader>w keybinding in insert mode
  vim.api.nvim_set_keymap('i', '<Leader>w', '<Esc>:update<CR>', { noremap = true, silent = true })

  -- Setting the <Leader>q keybinding in normal mode
  vim.api.nvim_set_keymap('n', '<Leader>q', ':wq<CR>', { noremap = true, silent = true })


  vim.api.nvim_set_keymap('n', '<Space>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

  local function set_sh_keymap()
    vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>!bash %<CR>', { noremap = true, silent = true })
  end

  -- Create an autocmd group to avoid duplication
  vim.api.nvim_create_augroup('sh_keymap', { clear = true })

  -- Set the autocmd to call the Lua function
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = '*.sh',
    callback = set_sh_keymap
  })
end

return M
