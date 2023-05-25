vim.g.mapleader=','
vim.api.nvim_set_keymap('n','<leader>w',':w<CR>',{})
vim.api.nvim_set_keymap('n','<leader>q',':q<CR>',{})
vim.api.nvim_set_keymap('n','<leader>wq',':wq<CR>',{})
vim.api.nvim_set_keymap('t','<Esc>','<C-\\><C-n>',{silent=true})
