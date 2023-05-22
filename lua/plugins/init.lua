local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	print('installing packer')
	packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
	vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
	print('installed packer')
end

require('packer').startup(function()
	-- Packer itself
	use 'wbthomason/packer.nvim'

	-- lsp
	use 'neovim/nvim-lspconfig'
	use {
    "williamboman/mason.nvim",
    run = ":MasonUpdate" -- :MasonUpdate updates registry contents
	}
	use "williamboman/mason-lspconfig.nvim"
	use 'simrat39/rust-tools.nvim'
	use 'nvim-lua/lsp-status.nvim'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/vim-vsnip'
	use "b0o/schemastore.nvim"
	use "nvim-treesitter/nvim-treesitter"
	use "windwp/nvim-ts-autotag"
	use "lbrayner/vim-rzip"
	use "jparise/vim-graphql"
	-- git
	use 'f-person/git-blame.nvim'
	use 'farmergreg/vim-lastplace'
	use { 'tpope/vim-fugitive' }
	-- formatter
	use 'sbdchd/neoformat'
	-- file explorer & toolbar
	use {'kevinhwang91/nvim-bqf'}
	use {
		'kyazdani42/nvim-tree.lua',
		requires = {
			'kyazdani42/nvim-web-devicons', -- optional, for file icon
		},
	}
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	use 'arkav/lualine-lsp-progress'
	use 'windwp/nvim-autopairs'
	use { "akinsho/toggleterm.nvim", tag = 'v2.*' }
	use {
  'nvim-telescope/telescope.nvim', branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
	}
	-- theme
	use { 'lifepillar/vim-solarized8' }
	-- misc
	use { 'mzlogin/vim-markdown-toc' }
	use { 'ekalinin/dockerfile.vim' }

	if packer_bootstrap then
		print('syncing')
		require('packer').sync()
		print('synced')
	end
end)

-- Plugin configs
require('plugins/nvim-tree')
require('plugins/lsp')
require('plugins/toggle-term')
require('plugins/statusbar')
require('plugins/solarized8')
require('plugins/formatter')
require('plugins/git')
require('plugins/telescope')
