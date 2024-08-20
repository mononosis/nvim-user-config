local M = {}
function M.setup()
  local lspconfig = require('lspconfig')


  local caps = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities(),
    -- File watching is disabled by default for neovim.
    -- See: https://github.com/neovim/neovim/pull/22405
    { workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } }
  );

  --Enable (broadcasting) snippet capability for completion
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  require 'lspconfig'.jsonls.setup {
    capabilities = capabilities,
  }

  lspconfig.nil_ls.setup {
    autostart = true,
    on_attach = function(_, bufnr)
      -- Custom on_attach logic
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>fl', '<cmd>lua vim.lsp.buf.format()<CR>',
        { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>t', '<cmd>!nix eval -f  %<CR>', { noremap = true, silent = true })
    end
    ,
    capabilities = caps,
    cmd = { 'nil' },
    settings = {
      ['nil'] = {
        testSetting = 42,
        formatting = {
          command = { "nixpkgs-fmt" },
        },
      },
    },
  }
end

return M
