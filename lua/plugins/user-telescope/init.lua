local M = {}

function M.setup()
  local session_lens = require('telescope').extensions['session-lens']
  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
  vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
  vim.keymap.set('n', '<leader>ft', builtin.marks, {})
  --vim.keymap.set('n', '<leader>ss', '<cmd>Telescope session-lens<CR>', { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>ss', session_lens.search_session, { noremap = true, silent = true })
end

return M
