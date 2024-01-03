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
  {
    'tamago324/nlsp-settings.nvim',
    dependencies = {
      'rcarriga/nvim-notify',
    },
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require 'mason'.setup()
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require 'mason-lspconfig'.setup({ automatic_installation = true })
    end
  },
  { 'neovim/nvim-lspconfig',   dependencies = { 'williamboman/mason-lspconfig.nvim' } },
  --{
  --  "jose-elias-alvarez/null-ls.nvim",
  --  config = function()
  --    local null_ls = require("null-ls")
  --    null_ls.setup { sources = { null_ls.builtins.formatting.prettier, null_ls.builtins.formatting.black } }
  --  end,
  --  dependencies = { "nvim-lua/plenary.nvim" }
  --},
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
  'towolf/vim-helm',
  'creativenull/efmls-configs-nvim',
  -- git
  'tpope/vim-fugitive',
  'f-person/git-blame.nvim',
  'farmergreg/vim-lastplace',
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      local gitsigns = require 'gitsigns'
      gitsigns.setup()
    end
  },
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
  { "akinsho/toggleterm.nvim", version = "*",                                         config = true },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    "natecraddock/telescope-zf-native.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", },
    build = "make"
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
  -- theme
  'lifepillar/vim-solarized8',
  -- misc
  'mzlogin/vim-markdown-toc',
  'ekalinin/dockerfile.vim',
  'ojroques/nvim-osc52',
  {
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    -- Author's Note: If default keymappings fail to register (possible config issue in my local setup),
    -- verify lazy loading functionality. On failure, disable lazy load and report issue
    -- lazy = false,
    config = function()
      require("textcase").setup({})
      require("telescope").load_extension("textcase")
    end,
    keys = {
      { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "v" }, desc = "Telescope" },
    },
  },
  {
    "RutaTang/quicknote.nvim",
    config = function()
      -- you must call setup to let quicknote.nvim works correctly
      require("quicknote").setup({
        mode = "resident", -- "portable" | "resident", default to "portable"
        sign = "📝", -- This is used for the signs on the left side (refer to ShowNoteSigns() api).
        -- You can change it to whatever you want (eg. some nerd fonts icon), 'N' is default
        filetype = "md",
        git_branch_recognizable = true, -- If true, quicknote will separate notes by git branch
        -- But it should only be used with resident mode,  it has not effect used with portable mode
      })
      vim.cmd([[autocmd BufEnter * lua require('quicknote').ShowNoteSigns()]])
    end
    ,
    dependencies = { "nvim-lua/plenary.nvim" }
  },
})

-- Plugin configs
require('plugins/nvim-tree')
require('plugins/lsp')
require('plugins/toggle-term')
require('plugins/statusbar')
require('plugins/solarized8')
require('plugins/telescope')
require('plugins/quicknote')
require('plugins/clipboard')
require('plugins/git')
