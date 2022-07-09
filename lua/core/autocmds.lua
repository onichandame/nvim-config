vim.cmd([[
augroup qf
  autocmd!
	autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
augroup END
]])
vim.cmd([[
augroup indent
	autocmd Filetype typescript setlocal cindent
	autocmd Filetype javascript setlocal cindent
	autocmd Filetype typescriptreact setlocal cindent
	autocmd Filetype javascriptreact setlocal cindent
augroup END
]])
