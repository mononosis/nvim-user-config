local M = {}
function M.setup()
  local caps = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities(),
    -- File watching is disabled by default for neovim.
    -- See: https://github.com/neovim/neovim/pull/22405
    { workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } }
  );

  --Enable (broadcasting) snippet capability for completion
  local snippet_caps = vim.lsp.protocol.make_client_capabilities()
  snippet_caps.textDocument.completion.completionItem.snippetSupport = true

  vim.lsp.config('jsonls', {
    capabilities = snippet_caps,
  })

  vim.lsp.config('nil_ls', {
    autostart = true,
    on_attach = function(_, bufnr)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>fl', '<cmd>lua vim.lsp.buf.format()<CR>',
        { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>t', '<cmd>!nix eval -f  %<CR>', { noremap = true, silent = true })
    end,
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
  })

  vim.lsp.enable({ 'jsonls', 'nil_ls' })
end

return M
