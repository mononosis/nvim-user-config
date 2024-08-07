local M                = {}

local user_noice       = require('user-noice')
local user_notify      = require('user-notify')
local user_options     = require('user-options')
local user_theme       = require('user-theme')

local user_keymappings = require('user_keymappings')
local user_dressing    = require('user-dressing')

local user_cmp         = require('user-cmp')
-- Comment fidget until we find a resolution
--local user_fidget              = require('user-fidget')
local user_lspconfig   = require('user-lspconfig')
local user_lualine     = require('user-lualine')
local user_telescope   = require('user-telescope')
local user_treesitter  = require('user-treesitter')
local user_luasnip     = require('user-luasnip')
local user_nvim_tree   = require('user-nvim-tree')
local user_bufferline  = require('user-bufferline')

function M.setup()
  -- nice plugin to show the actual color when a hex color value is found
  require('nvim-highlight-colors').setup {}
  -- noice provide nice interfaces for prompts, notifications, completion windows etc
  user_noice.setup()
  -- nice ui for displaying notifications using noice
  user_notify.setup()
  -- a set of vim.opts 
  user_options.setup()
  -- had to do some tweaks for the theme probably will customise the bufferline
  user_theme.setup()
  -- Very common keymaps this won't conflict with Lab environments
  user_keymappings.setup()
  -- This is kind of the same as user_noice
  user_dressing.setup()
  -- here is the status line that is displayed at the bottom
  user_lualine.setup()
  -- telescope nice for searching files or text within the workspace 
  user_telescope.setup()
  -- this will provide more visual hints or cues of the syntax from a particular language
  user_treesitter.setup()
  -- in here we can create snippets of code and then type the word a cmp will complete it for you
  user_luasnip.setup()
  -- settings for the language server protocol in user-config only  server config for nil is used as the system will be compose of mostly nix files
  user_lspconfig.setup()
  -- configuration for the sidebar menu
  user_nvim_tree.setup()
  -- the tab line of buffer line all buffers are shown at the top
  user_bufferline.setup()
  -- complete text as you type the lspconfig integrated with cmp will provide more completions
  user_cmp.setup()
end

function M.info(message)
  user_notify.send(message, vim.log.levels.INFO)
end

return M
