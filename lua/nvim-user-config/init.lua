-- This nvim-highlight-colors shows the actual color wherever it is declared
-- #fff
-- #ff2
require('nvim-highlight-colors').setup {}
-- Here lets use quiet color theme for the editor
vim.cmd('color quiet')



-- Execute project-specific Lua configuration if the environment variable is set
--local project_nvim_config = os.getenv("PROJECT_NVIM_CONFIG")
--if project_nvim_config then
--    dofile(project_nvim_config)
--end



-- Map leader
vim.g.mapleader = ","

-- Move to all directions from pane to pane or side bar without the extra hassle
vim.api.nvim_set_keymap('n', '<C-j>', '<C-W>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-W>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-W>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-W>l', { noremap = true, silent = true })

-- Fast escape
vim.api.nvim_set_keymap('i', 'jh', '<Esc>', { noremap = true, silent = true })

-- Setting the <Leader>w keybinding in normal mode
vim.api.nvim_set_keymap('n', '<Leader>w', ':update<CR>', { noremap = true, silent = true })

-- Setting the <Leader>w keybinding in insert mode
vim.api.nvim_set_keymap('i', '<Leader>w', '<Esc>:update<CR>', { noremap = true, silent = true })

-- Setting the <Leader>q keybinding in normal mode
vim.api.nvim_set_keymap('n', '<Leader>q', ':wq<CR>', { noremap = true, silent = true })


vim.api.nvim_set_keymap('n', '<Space>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})

-- Function to split a string by a delimiter
local function split(str, delimiter)
  local result = {}
  for match in (str .. delimiter):gmatch("(.-)" .. delimiter) do
    table.insert(result, match)
  end
  return result
end

-- Function to add directories to the runtimepath
local function add_paths_to_rtp(paths)
  for _, path in ipairs(paths) do
    vim.o.runtimepath = vim.o.runtimepath .. ',' .. path
  end
end

-- Use environment variable to get the concatenated paths
local plugin_paths = os.getenv('NVIM_PLUGIN_PATHS')
if plugin_paths then
  local paths = split(plugin_paths, ':')
  add_paths_to_rtp(paths)
end
local lspconfig = require('lspconfig')

local function on_attach(client, bufnr)
  -- Custom on_attach logic
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>fl', '<cmd>lua vim.lsp.buf.format()<CR>',
    { noremap = true, silent = true })
end

lspconfig.rnix.setup {
  on_attach = on_attach,
}
require("bufferline").setup {}
require("notify").setup({
  background_colour = "#fff",
})
require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    --bottom_search = true, -- use a classic bottom cmdline for search
    --command_palette = true, -- position the cmdline and popupmenu together
    --long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = true,     -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = true, -- add a border to hover docs and signature help
  },
})

-- Set up nvim-cmp.
local cmp = require 'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'path' },
    -- { name = 'vsnip' }, -- For vsnip users.
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set up lspconfig.
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
--require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--	capabilities = capabilities
--}
require('lualine').setup()



--vim.api.nvim_create_autocmd("FileType", {
--pattern = "lua",
--callback = function()
--vim.opt_local.tabstop = 2
--vim.opt_local.shiftwidth = 2
--vim.opt_local.expandtab = true
--end,
--})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


require 'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true, -- false will disable the whole extension
    --disable = { "lua" },  -- list of language that will be disabled
  },
  -- Add additional configuration for Treesitter features if needed
}

local function GetPathWithoutLastSubpath(path)
  -- Remove any trailing slashes
  path = path:gsub("/+$", "")

  -- Find the last occurrence of "/"
  local endIdx = path:match(".*/()")

  -- If a slash is found, return the substring up to (but not including) the last slash.
  -- Otherwise, return nil or an empty string to indicate that there's no preceding path.
  if endIdx then
    return path:sub(1, endIdx - 1)
  else
    return nil -- or return "" if you prefer to return an empty string
  end
end
local function GetLastSubpath(path)
  -- Remove any trailing slashes
  path = path:gsub("/+$", "")
  -- Find the last occurrence of "/"
  local startIdx = path:match("^.*/()")

  -- If a slash is found, return the substring after it. Otherwise, return the whole path.
  if startIdx then
    return path:sub(startIdx)
  else
    return path
  end
end
local nvim_project_config_path = os.getenv("PROJECT_NVIM_CONFIG")
function set_packages_paths(dir)
  if dir then
    package.path = package.path .. ';' .. dir .. '/?/init.lua' .. ';' .. dir .. '/?.lua' .. ';'
  end
end
if nvim_project_config_path then
  set_packages_paths(GetPathWithoutLastSubpath(nvim_project_config_path))
  require(GetLastSubpath(nvim_project_config_path))
end

require('options')