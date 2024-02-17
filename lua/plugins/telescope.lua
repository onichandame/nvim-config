local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local telescope = require('telescope')
local lga_actions = require("telescope-live-grep-args.actions")

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope.extensions.live_grep_args.live_grep_args, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fe', ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { noremap = true })
vim.keymap.set('n', '<leader>fn', ":Telescope quicknote scope=CurrentBuffer<CR>", { noremap = true })
require('telescope').setup {
  defaults = vim.tbl_extend('force',
    require 'telescope.themes'.get_dropdown(),
    {}
  ),
  pickers = {
    buffers = {
      mappings = {
        n = {
          d = actions.delete_buffer
        },
        i = {
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        }
      }
    },
  },
  extensions = {
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      -- define mappings, e.g.
      mappings = {         -- extend mappings
        i = {
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        },
      },
      -- ... also accepts theme settings, for example:
      -- theme = "dropdown", -- use dropdown theme
      -- theme = { }, -- use own theme spec
      -- layout_config = { mirror=true }, -- mirror preview pane
    },
    file_browser = {
      hidden = { file_browser = true, folder_browser = true },
      auto_depth = true,
      hide_parent_dir = true,
      grouped = true,
    },
    quicknote = {
      defaultScope = "CWD",
    }
  }
}
vim.cmd([[
autocmd User TelescopePreviewerLoaded setlocal wrap
autocmd User TelescopePreviewerLoaded setlocal number
]])
require 'telescope'.load_extension 'zf-native'
require 'telescope'.load_extension 'file_browser'
require 'telescope'.load_extension 'quicknote'
require 'telescope'.load_extension 'live_grep_args'
