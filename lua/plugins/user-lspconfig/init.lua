
local lspconfig = require('lspconfig')

local function on_attach(client, bufnr)
  -- Custom on_attach logic
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>fl', '<cmd>lua vim.lsp.buf.format()<CR>',
    { noremap = true, silent = true })
end

lspconfig.rnix.setup {
  on_attach = on_attach,
}
