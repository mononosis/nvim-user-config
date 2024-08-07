local M = {}
function M.setup()
  require 'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true, -- false will disable the whole extension
      --disable = { "lua" },  -- list of language that will be disabled
    },
    -- Add additional configuration for Treesitter features if needed
  }
end

return M

