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

wk.add({
  { "<leader>l",   group = "LSP",                                  remap = false },
  { "<leader>lI",  "<cmd>LspInstallInfo<CR>",                      desc = "Installed Servers Infos",                       remap = false },
  { "<leader>lR",  "<cmd>LspRestart<CR>",                          desc = "Restart LSP",                                   remap = false },
  { "<leader>ld",  group = "Diagnostics",                          remap = false },
  { "<leader>ldd", "<cmd>TroubleToggle document_diagnostics<CR>",  desc = "Open diagnostics window for current document",  remap = false },
  { "<leader>ldw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Open diagnostics window for current workspace", remap = false },
  { "<leader>li",  "<cmd>LspInfo<CR>",                             desc = "Infos",                                         remap = false },
});

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
  wk.add({
    { "<leader>l",  buffer = 1,                                   group = "LSP", remap = false },
    { "<leader>lD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", buffer = 1,    desc = "Type Definition", remap = false },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>",     buffer = 1,    desc = "Code Actions",    remap = false },
    { "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>",          buffer = 1,    desc = "Format",          remap = false },
    { "<leader>lr", "<cmd>Lspsaga rename<cr>",                    buffer = 1,    desc = "Rename",          remap = false },
  })
  print("setup done")
end

local servers = {
  'pyright',
  'rust_analyzer',
  'ts_ls',
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
  'intelephense',
  'ocamllsp',
  'emmet_language_server',
  'dartls',
  'gdscript',
  'elmls',
  'lemminx',
  'glsl_analyzer',
  'jdtls'
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

lspconfig.nixd.setup {
  on_attach = on_attach,
  capabilities = capabilities,

  settings = {
    nixd = {
      formatting = {
        command = { "nixfmt" },
      },
    },
  },
}
