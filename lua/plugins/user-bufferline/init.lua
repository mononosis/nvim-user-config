local M = {}

function M.setup()

  local bufferline = require('bufferline')

  bufferline.setup({
    options = {
      mode = "buffer",
      numbers = "ordinal",
      style_preset = bufferline.style_preset.default,
      themable = true,
      truncate_names = false,
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(_, level, _, context)
        if context.buffer:current() then
          return ''
        end
        if level == "error" then
          return '😱'
        end
        if level == "hint" then
          return '🤔'
        end
        if level == "warning" then
          return '😨'
        end
        return ''
      end,
      color_icons = true,
      separator_style = "slope",
      show_buffer_close_icons = true,
      show_tab_indicators = true,
      enforce_regular_tabs = false,
      always_show_bufferline = true,
      auto_toggle_bufferline = true,
      sort_by = "relative_directory",
      show_buffer_icons = true,
      move_wraps_at_ends = true,
      indicator = {
        icon = '|',
        style = 'icon'
      },
      hover = {
        enabled = true,
        delay = 100,
        reveal = { 'close' }
      },
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "center",
          separator = "║",
          highlight = "Normal"
        }
      },
      custom_areas = {
        right = function()
          local result = {}
          local seve = vim.diagnostic.severity
          local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
          local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
          local info = #vim.diagnostic.get(0, { severity = seve.INFO })
          local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

          if error ~= 0 then
            table.insert(result, { text = "  " .. error, link = "DiagnosticError" })
          end

          if warning ~= 0 then
            table.insert(result, { text = "  " .. warning, link = "DiagnosticWarn" })
          end

          if hint ~= 0 then
            table.insert(result, { text = "  " .. hint, link = "DiagnosticHint" })
          end

          if info ~= 0 then
            table.insert(result, { text = "  " .. info, link = "DiagnosticInfo" })
          end
          return result
        end,
      },
    }
  })
end
return M
