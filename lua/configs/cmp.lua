local cmp = require 'cmp'
local lspkind = require 'lspkind'

-- General setup
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({
      behaviour = cmp.ConfirmBehavior.Replace,
      select = true
    }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    -- { name = 'nvim_lua' },
    { name = 'async_path' },
    { name = 'buffer' },
    { name = 'spell' },
    { name = 'crates' },
  }),
  formatting = {
    fields = { cmp.ItemField.Kind, cmp.ItemField.Abbr, cmp.ItemField.Menu },
    format = lspkind.cmp_format({
      mode = 'symbol',
      menu = ({
        nvim_lsp = '[LSP]',
        luasnip = '[Snippet]',
        nvim_lua = '[Lua]',
        path = '[Path]',
        buffer = '',
        spell = '*spell*',
        crates = '(crates.io)',
      }),
    }),
  },
})

-- Git commit
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

require("cmp_git").setup()
