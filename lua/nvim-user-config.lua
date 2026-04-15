-- here we source this file by adding the path of this project such as the nix store path
-- or the user lab path for development
my_init.source_me()
-- import all modules from this project
-- in here we extend the editor with more plugins based on the lab path such lualab or javalab.

require("misc").setup()

local wk = require("which-key")
wk.add({
  { "<leader>f", group = "file" }, -- group
  --{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
  --{ "<leader>fb", function() print("hello") end, desc = "Foobar" },
  { "<leader>fn", desc = "New File" },
  { "<leader>f1", hidden = true }, -- hide this keymap
  { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
  { "<leader>b", group = "buffers", expand = function()
      return require("which-key.extras").expand.buf()
    end
  },
  {
    -- Nested mappings are allowed and can be added in any order
    -- Most attributes can be inherited or overridden on any level
    -- There's no limit to the depth of nesting
    mode = { "n", "v" }, -- NORMAL and VISUAL mode
    { "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
    { "<leader>w", "<cmd>w<cr>", desc = "Write" },
  }
})

require('avante_lib').load()
package.cpath = package.cpath ..
    ";" .. "/nix/store/hlj3abrm42mnsiy1ipk9qrn7c57shix0-vimplugin-avante.nvim-0.0.23-unstable-2025-05-12/build/?.so"

local ok, tokenizers = pcall(require, "avante_tokenizers")
if not ok then
  print("Error loading avante_tokenizers:", tokenizers)
else
  print("avante_tokenizers loaded successfully!", tokenizers)
end

local ok_2, templates = pcall(require, "avante_templates")
if not ok_2 then
  print("Error loading templates:", templates)
else
  print("templates loaded successfully!", templates)
end

local ok_3, avante_repo_map = pcall(require, "avante_repo_map")
if not ok_3 then
  print("Error loading avante_repo_map:", avante_repo_map)
else
  print("avante_repo_map loaded successfully!", avante_repo_map)
end

require('avante').setup({
  provider = "claude",
  providers = {
    claude = {
      endpoint = "https://api.anthropic.com",
      model = "claude-3-7-sonnet-20250219",
      extra_request_body = {
        temperature = 0,
        max_tokens = 4096,
      },
    },
  },
})

require("CopilotChat").setup()
require("claude-code").setup()


require("dbee").setup({
  --sources = {
  --{
  --name = "local_postgres",
  --type = "postgres",
  --url = "postgres://postgres:postgres@localhost:54322/your_database",
  --}
  --},
  window = {
    layout = "horizontal", -- or "vertical"
  }
})
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})
vim.o.updatetime = 250 -- Default is 4000ms; lower = faster diagnostics

require("zen-mode").setup({
  window = {
    backdrop = 0.95,
    width = 0.75,
    height = 0.5,
    options = {
      signcolumn = "no",
      number = false,
      relativenumber = false,
    },
  },
})

--require('hologram').setup {
--auto_display = true -- WIP automatic markdown image display, may be prone to breaking
--}

--require("image").setup({
--backend = "kitty",     -- or "ueberzug"
--max_height_window_percentage = 50,
--hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.svg" },
--})

--require("codecompanion").setup()

my_init.extend_environment_from_lab()

--require("blink-cmp-avante").opts({})
--require('blink.cmp').setup {
--sources = {
--default = { 'avante', 'lsp', 'path', 'buffer', 'snippets' },
--providers = {
--snippets = {
--preset = 'luasnip',
--},
--avante = {
--module = 'blink-cmp-avante',
--name = 'Avante',
--},
--}
--},

--fuzzy = {
--implementation = "lua", -- if not building Rust
--}
--}



-- When changing to directories within the lab folder the editor will load the plugins lazyly
