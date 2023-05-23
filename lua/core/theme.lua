vim.o.ic=true --- ignore case in search/command list
vim.o.number=true --- enable line number
vim.o.cursorline=true --- enable current line highlight
vim.o.cursorcolumn=true --- enable current column highlight
vim.o.termguicolors=true --- required by status line and feline
vim.o.hidden=true
if(vim.fn.exists('+shellslash')==1) then
	vim.o.shellslash=true
end
if(vim.fn.has('windows')==1)then
	vim.o.shell='powershell'
end
