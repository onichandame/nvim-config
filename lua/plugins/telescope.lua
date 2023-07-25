local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fe', ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { noremap = true })
require('telescope').setup {
  pickers = {
    buffers = {
      mappings = {
        n = {
          d = actions.delete_buffer
        }
      }
    }
  },
  extensions = {
    file_browser = {
      hidden = { file_browser = true, folder_browser = true },
      auto_depth = true,
      hide_parent_dir = true,
      grouped = true,
    }
  }
}
require 'telescope'.load_extension 'zf-native'
require 'telescope'.load_extension 'file_browser'
