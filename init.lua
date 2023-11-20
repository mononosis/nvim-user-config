      -- Disable backup
      vim.opt.backup = false

      -- Execute project-specific Lua configuration if the environment variable is set
      --local project_nvim_config = os.getenv("PROJECT_NVIM_CONFIG")
      --if project_nvim_config then
      --    dofile(project_nvim_config)
      --end
      local current_dir = os.getenv("PROJECT_NVIM_CONFIG")
      if current_dir then
          package.path = package.path .. ';' .. current_dir .. '/?.lua'
      end

      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      
      -- set termguicolors to enable highlight groups
      vim.opt.termguicolors = true

      vim.opt.history = 1000        -- Enable line numbers
      vim.opt.number = true        -- Enable line numbers
      vim.opt.relativenumber = true -- Enable relative line numbers


      -- Map leader 
      vim.g.mapleader = ","
      
      -- Move to all directions from pane to pane or side bar without the extra hassle
      vim.api.nvim_set_keymap('n', '<C-j>', '<C-W>j', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<C-k>', '<C-W>k', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<C-h>', '<C-W>h', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<C-l>', '<C-W>l', { noremap = true, silent = true })

      -- Fast escape
      vim.api.nvim_set_keymap('i', 'jh', '<Esc>', {noremap = true, silent = true})

      -- Setting the <Leader>w keybinding in normal mode
      vim.api.nvim_set_keymap('n', '<Leader>w', ':update<CR>', { noremap = true, silent = true })
      
      -- Setting the <Leader>w keybinding in insert mode
      vim.api.nvim_set_keymap('i', '<Leader>w', '<Esc>:update<CR>', { noremap = true, silent = true })
      
      -- Setting the <Leader>q keybinding in normal mode
      vim.api.nvim_set_keymap('n', '<Leader>q', ':wq<CR>', { noremap = true, silent = true })


      -- empty setup using defaults
      require("nvim-tree").setup()
      
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
          dotfiles = true,
        },
      })

      -- Function to split a string by a delimiter
      local function split(str, delimiter)
          local result = {}
          for match in (str..delimiter):gmatch("(.-)"..delimiter) do
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
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>fl', '<cmd>lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })
      end

      lspconfig.rnix.setup{
         on_attach = on_attach,
      }
      require("bufferline").setup{}
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
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
