local plugin_paths = os.getenv('NVIM_PLUGIN_PATHS')

local nvim_project_config_path = os.getenv("PROJECT_NVIM_CONFIG")
local utils = require("nvim-utils-config")
local current_dir = utils.this_file_path()
utils.set_packages_paths(current_dir)
require('keymappings')
require('user-cmp')
require('user-notify')
require('user-bufferline')
require('user-lualine')
require('user-telescope')
require('user-nvim-tree')
require('user-lspconfig')
require('user-noice')
require('user-options')
require('user-theme')
if plugin_paths then
  local paths = utils.split(plugin_paths, ':')
  utils.add_paths_to_rtp(paths)
end
if nvim_project_config_path then
  utils.set_packages_paths(nvim_project_config_path)
  require(utils.GetLastSubpath(nvim_project_config_path))
end
