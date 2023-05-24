vim.o.ic=true --- ignore case in search/command list
vim.o.number=true --- enable line number
vim.o.cursorline=true --- enable current line highlight
vim.o.cursorcolumn=true --- enable current column highlight
vim.o.termguicolors=true --- required by status line and feline
vim.o.hidden=true
if(vim.fn.exists('+shellslash')==1) then
	vim.o.shellslash=true
end
-- set shell for different OS
if(vim.loop.os_uname().sysname=='Windows_NT')then
	vim.o.shell='powershell'
elseif (vim.fn.executable('ash')==1) then
	vim.o.shell='ash'
end
