-- LSP configuration, mostly copied from the github repo readmes
local wk = require("which-key")
local lsp_installer = require('nvim-lsp-installer')
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
            d = { '<cmd>TroubleToggle document_diagnostics<CR>', 'Open diagnostics window for current document', noremap = true, silent = true },
            w = { '<cmd>TroubleToggle workspace_diagnostics<CR>', 'Open diagnostics window for current workspace', noremap = true, silent = true },
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

    local bkm = function(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    -- Mappings.
    bkm('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    bkm('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    bkm('n', 'gr', '<cmd>TroubleToggle lsp_references<CR>', opts)
    bkm('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    bkm('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
    --km('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts) -- not sure if it is useful

    -- Which key mappings
    wk.register({
        l = {
            name = 'LSP',
            a = { '<cmd>Lspsaga code_action<CR>', 'Code Actions', noremap = true, silent = true },
            D = { '<cmd>lua vim.lsp.buf.type_definition()<CR>', 'Type Definition', noremap = true, silent = true },
            r = { '<cmd>Lspsaga rename<CR>', 'Rename', noremap = true, silent = true },
            f = { '<cmd>lua vim.lsp.buf.formatting()<CR>', 'Format', noremap = true, silent = true },
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
    'sumneko_lua',
    'omnisharp',
    'cmake',
    'cssls',
    'denols',
    'html',
    'jsonls',
    'texlab',
    'zeta_note',
    'svelte',
    'vimls',
    'zls',
}

-- Server auto-installation
lsp_installer.setup {
    ensure_installed = servers
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
    capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
end

for _, lsp in pairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            -- This will be the default in neovim 0.7+
            debounce_text_changes = 150,
        }
    }
end

-- Setup fidget
require "fidget".setup {
    window = {
        blend = 0
    }
}
