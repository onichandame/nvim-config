require('lualine').setup({
	options = { theme = require('lualine.themes.solarized_dark') },
	sections = {
		lualine_c = { 'lsp_progress' },
		lualine_x = { 'filename', 'encoding','filetype' },
	}
}) --- status line
