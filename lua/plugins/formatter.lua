vim.g.neoformat_try_node_exe =1
vim.api.nvim_set_keymap('n','<leader>f',[[
augroup fmt
  autocmd!
  autocmd BufWritePre * | Neoformat
augroup END
]],{})
