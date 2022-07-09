vim.g.mapleader=','
vim.api.nvim_set_keymap('n','<leader>w',':w<CR>',{})
vim.api.nvim_set_keymap('n','<leader>q',':q<CR>',{})
vim.api.nvim_set_keymap('n','<leader>wq',':wq<CR>',{})
vim.api.nvim_set_keymap('n','<F2>',':NvimTreeFindFileToggle<CR>',{silent=true})
vim.api.nvim_set_keymap('t','<Esc>','<C-\\><C-n>',{silent=true})
vim.api.nvim_set_keymap('n','<C-t>',':ToggleTerm<CR>',{silent=false})
