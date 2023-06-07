local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	-- lsp
	'neovim/nvim-lspconfig',
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
	},
	"williamboman/mason-lspconfig.nvim",
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			require("null-ls").setup { sources = { null_ls.builtins.formatting.prettier } }
		end,
		dependencies = { "nvim-lua/plenary.nvim" }
	},
	'simrat39/rust-tools.nvim',
	'nvim-lua/lsp-status.nvim',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-vsnip',
	'hrsh7th/vim-vsnip',
	"rafamadriz/friendly-snippets",
	"b0o/schemastore.nvim",
	"nvim-treesitter/nvim-treesitter",
	"windwp/nvim-ts-autotag",
	"lbrayner/vim-rzip",
	"jparise/vim-graphql",
	-- git
	'f-person/git-blame.nvim',
	'farmergreg/vim-lastplace',
	'tpope/vim-fugitive',
	-- file explorer & toolbar
	'kevinhwang91/nvim-bqf',
	{
		'kyazdani42/nvim-tree.lua',
		dependencies = {
			'kyazdani42/nvim-web-devicons', -- optional, for file icon
		},
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true }
	},
	'arkav/lualine-lsp-progress',
	'windwp/nvim-autopairs',
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	-- theme
	'lifepillar/vim-solarized8',
	-- misc
	'mzlogin/vim-markdown-toc',
	'ekalinin/dockerfile.vim',
	'ojroques/nvim-osc52',
})

-- Plugin configs
require('plugins/nvim-tree')
require('plugins/lsp')
require('plugins/toggle-term')
require('plugins/statusbar')
require('plugins/solarized8')
require('plugins/git')
require('plugins/telescope')
require('plugins/clipboard')
