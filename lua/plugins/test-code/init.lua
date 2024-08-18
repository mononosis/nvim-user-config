local M = {}
local function create_floating_window()
  local width = vim.api.nvim_get_option_value("columns", {})
  local height = vim.api.nvim_get_option_value("lines", {})

  local win_width = math.ceil(width * 0.5)
  local win_height = math.ceil(height * 0.5)

  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)

  local opts = {
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    zindex = 1 -- Set z-index to ensure this window floats above others

  }

  local buf = vim.api.nvim_create_buf(false, true)   -- create a new empty buffer
  local win = vim.api.nvim_open_win(buf, true, opts) -- open the window with the buffer

  return buf, win
end

local function create_temp_file_with_extension()
  local prev_bufnr = vim.fn.bufnr('#')
  local prev_filename = vim.fn.bufname(prev_bufnr)
  local file_extension = vim.fn.fnamemodify(prev_filename, ':e')
  local temp_file_path = vim.fn.tempname() .. '.' .. file_extension
  vim.api.nvim_command('edit ' .. temp_file_path)
  return temp_file_path
end

local function close_window_and_cleanup(temp_file, win)
  if vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_close(win, true)
  end
  vim.fn.delete(temp_file)

  local buf = vim.fn.bufnr(temp_file)
  if vim.api.nvim_buf_is_valid(buf) then
    vim.api.nvim_buf_delete(buf, { force = true })
  end
end

local function open_temp_file_in_floating_window()
  local buf, win = create_floating_window()
  local temp_file = create_temp_file_with_extension()

  -- Even though the buffer is already set in
  -- create_temp_file_with_extension allocate the buffer
  -- anyway to the new window
  vim.api.nvim_win_set_buf(win, vim.fn.bufnr(temp_file))

  vim.api.nvim_create_autocmd({ "WinLeave", "BufWipeout" }, {
    callback = function()
      close_window_and_cleanup(temp_file, win)
    end,
    buffer = buf
  })
end

function M.setup()
  vim.keymap.set('n', '<leader>ee', open_temp_file_in_floating_window, { noremap = true, silent = true })
end

return M
