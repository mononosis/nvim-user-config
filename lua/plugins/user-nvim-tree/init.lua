local M = {}
function M.setup()
  -- disable netrw at the very start of your init.lua
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  -- OR setup with some options
  local HEIGHT_RATIO = 0.8
  local WIDTH_RATIO = 0.8
  require("nvim-tree").setup({
    select_prompts = false, -- Disable advanced vim.ui.select integration

    sort_by = "case_sensitive",
    view = {
      width = 35,
      centralize_selection = true,
      float = {
        enable = false,
        open_win_config = function()
          local screen_w = vim.opt.columns:get()
          local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
          local window_w = screen_w * WIDTH_RATIO
          local window_h = screen_h * HEIGHT_RATIO
          local window_w_int = math.floor(window_w)
          local window_h_int = math.floor(window_h)
          local center_x = (screen_w - window_w) / 2
          local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
          return {
            border = "rounded",
            relative = "editor",
            row = center_y,
            col = center_x,
            width = window_w_int,
            height = window_h_int,
          }
        end,
      },
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
    },
    git = {
      enable = true, -- Adjust or disable Git integration
      ignore = false -- Set to false to stop ignoring Git ignored files
    },

    renderer = {
      --root_folder_modifier = ':t',
      group_empty = true,
      root_folder_label = ":t",
      add_trailing = true,
      full_name = true,
      indent_width = 1,
      highlight_git = false,
      highlight_diagnostics = true,
      highlight_opened_files = "none",
      highlight_modified = "none",
      highlight_bookmarks = "all",
      highlight_clipboard = "name",
      icons = {
        glyphs = {
          default = '', -- Default icon for files
          symlink = '', -- Icon for symbolic links
          folder = {
            arrow_open = "",
            arrow_closed = "",
            default = "",  -- Default folder icon
            open = "",     -- Icon for open folder
            empty = "",    -- Icon for empty folder
            empty_open = "", -- Icon for empty open folder
            symlink = "",
            symlink_open = "",
            --root = "", -- Custom icon for the root folder
          },
        }
      }
    },
    filters = {
      dotfiles = false,
    },
    hijack_cursor = true,
    prefer_startup_root = true,
  })
end

return M
