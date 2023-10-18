-- LSP configuration, mostly copied from the github repo readmes
local wk = require("which-key")
local lspconfig = require('lspconfig')

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
local km = function(...) vim.api.nvim_set_keymap('n', ...) end
km('<C-k>', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)
km('<C-h>', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
km('<C-l>', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
-- Which key global mappings
wk.register({
  l = {
    name = 'LSP',
    i = { '<cmd>LspInfo<CR>', 'Infos', noremap = true, silent = true },
    I = { '<cmd>LspInstallInfo<CR>', 'Installed Servers Infos', noremap = true, silent = true },
    R = { '<cmd>LspRestart<CR>', 'Restart LSP', noremap = true, silent = true },
    d = {
      name = "Diagnostics",
      d = {
        '<cmd>TroubleToggle document_diagnostics<CR>',
        'Open diagnostics window for current document',
        noremap = true,
        silent = true
      },
      w = {
        '<cmd>TroubleToggle workspace_diagnostics<CR>',
        'Open diagnostics window for current workspace',
        noremap = true,
        silent = true
      },
    }
  }
}, {
  prefix = "<leader>",
  noremap = true,
  silent = true,
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  if client.server_capabilities["documentSymbolProvider"] then
    require("nvim-navic").attach(client, bufnr)
  end

  local bkm = function(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- Mappings.
  bkm('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  bkm('n', 'gd', '<cmd>Trouble lsp_definitions<CR>', opts)
  bkm('n', 'gr', '<cmd>Trouble lsp_references<CR>', opts)
  bkm('n', 'gI', '<cmd>Trouble lsp_implementations<CR>', opts)
  bkm('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
  --km('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts) -- not sure if it is useful

  -- Which key mappings
  wk.register({
    l = {
      name = 'LSP',
      a = { '<cmd>lua vim.lsp.buf.code_action()<CR>', 'Code Actions', noremap = true, silent = true },
      D = { '<cmd>lua vim.lsp.buf.type_definition()<CR>', 'Type Definition', noremap = true, silent = true },
      r = { '<cmd>Lspsaga rename<cr>', 'Rename', noremap = true, silent = true },
      f = { '<cmd>lua vim.lsp.buf.format()<CR>', 'Format', noremap = true, silent = true },
    }
  }, {
    prefix = "<leader>",
    noremap = true,
    silent = true,
    buffer = bufnr,
  })
end

local servers = {
  'pyright',
  'rust_analyzer',
  'tsserver',
  'clangd',
  'lua_ls',
  'omnisharp',
  'cmake',
  'cssls',
  'denols',
  'html',
  'jsonls',
  'texlab',
  'svelte',
  'vimls',
  'zls',
  'rnix',
  'intelephense',
  'ocamllsp',
  'emmet_language_server',
  'dartls',
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- Yanked from NvChad
capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

-- LSP Auto Config
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Server Specific config
lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/extensions/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}
