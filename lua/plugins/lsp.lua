require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'bash',
    'tsx',
    'yaml',
    'rust',
    'lua',
    'typescript',
    'javascript',
    'python',
    'vim',
    'json5',
    'html',
    'prisma',
    'graphql',
    'go',
    'dockerfile',
    'css',
    'markdown'
  },
  sync_install = true,
  highlight = { enable = true },
  indent = { enable = true },
  autotag = { enable = true }
}
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')
npairs.setup({
  check_ts = true,
  ts_config = {
    lua = { 'string', 'comment' }, -- it will not add a pair on that treesitter node
    javascript = { 'template_string' },
    typescript = { 'string', 'template_string', 'source' },
    java = false, -- don't check treesitter on java
  }
})

local ts_conds = require('nvim-autopairs.ts-conds')

-- press % => %% only while inside a comment or string
npairs.add_rules({
  Rule("%", "%", "lua")
      :with_pair(ts_conds.is_ts_node({ 'string', 'comment' })),
  Rule("$", "$", "lua")
      :with_pair(ts_conds.is_not_ts_node({ 'function' })),
  Rule("/**", "*/", { "javascript", "typescript", "typescriptreact", "javascriptreact" })
      :with_pair(ts_conds.is_not_ts_node({ 'comment' })),
})

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require 'cmp'
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<A-i>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#jumpable"](1) == 1 then
        vim.fn.feedkey("<Plug>(vsnip-jump-next)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup nlsp-settings
require('nlspsettings').setup({
  nvim_notify = { enable = true },
  append_default_schemas = true,
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>w',
  '<cmd>lua vim.lsp.buf.format{timeout_ms=10000, filter = function(client) return client.name ~= "tsserver" and client.name ~= "jsonls" end }<CR><cmd>:w<CR>',
  opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>k', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl',
    '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>Telescope lsp_type_definitions<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
end

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
}

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'lua_ls', 'tsserver', 'tailwindcss', 'marksman', 'helm_ls', 'taplo', 'dockerls', 'prismals', 'bashls',
  'html',
  'pyright',
}
for _, server in pairs(servers) do
  require('lspconfig')[server].setup {
    on_attach = on_attach,
    handlers = handlers,
    capabilities = capabilities,
  }
end
require 'lspconfig'.graphql.setup {
  filetypes = { 'graphql', 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
  on_attach = on_attach,
  handlers = handlers,
  capabilities = capabilities,
}

require('lspconfig').jsonls.setup {
  on_attach = on_attach,
  handlers = handlers,
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}

local yaml_schema = require('schemastore').yaml.schemas()
yaml_schema['kubernetes'] = {
  "/*secret.yaml",
  "/*secret.yml",
  "/*sts.yaml",
  "/*sts.yml",
  "/*svc.yaml",
  "/*svc.yml",
  "/*deploy.yaml",
  "/*deploy.yml",
  "/*cm.yaml",
  "/*cm.yml",
  "/*ns.yaml",
  "/*ns.yml",
  "/*role.yaml",
  "/*role.yml",
  "/*sa.yaml",
  "/*sa.yml",
  "/*sc.yaml",
  "/*sc.yml",
  "/*pv.yaml",
  "/*pv.yml",
  "/*pvc.yaml",
  "/*pvc.yml",
}

require('lspconfig').yamlls.setup {
  on_attach = on_attach,
  handlers = handlers,
  capabilities = capabilities,
  settings = {
    yaml = {
      schemas = yaml_schema
    },
    validate = { enable = true }
  }
}

local efmls_config_prettier = require 'efmls-configs.formatters.prettier'
local efmls_config_black = require 'efmls-configs.formatters.black'
local languages = {
  typescript = { efmls_config_prettier },
  javascript = { efmls_config_prettier },
  jsonc = { efmls_config_prettier },
  json = { efmls_config_prettier },
  typescriptreact = { efmls_config_prettier },
  javascriptreact = { efmls_config_prettier },
  python = { efmls_config_black },
}
require 'lspconfig'.efm.setup {
  filetypes = vim.tbl_keys(languages),
  settings = {
    rootMarkers = { '.git/' },
    languages = languages,
  },
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
  on_attach = on_attach,
  handlers = handlers,
  capabilities = capabilities,
}

require 'rust-tools'.setup({
  server = {
    on_attach = on_attach,
    handlers = handlers,
    capabilities = capabilities,
  }
})
