require("toggleterm").setup({
	start_in_insert=false,
})
vim.api.nvim_set_keymap('n','<leader>t',':ToggleTerm<CR>',{silent=false})
