-- LSP configuration, mostly copied from the github repo readmes
local wk = require("which-key")
local lsp_installer = require('nvim-lsp-installer')
local lspconfig = require('lspconfig')

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
local km = function(...) vim.api.nvim_set_keymap('n', ...) end
km('<C-k>', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
km('<C-h>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
km('<C-l>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
km('<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
-- Which key global mappings
wk.register({
    l = {
        name = 'LSP',
        i = { '<cmd>LspInfo<CR>', 'Infos', noremap = true, silent = true },
        I = { '<cmd>LspInstallInfo<CR>', 'Installed Servers Infos', noremap = true, silent = true },
        R = { '<cmd>LspRestart<CR>', 'Restart LSP', noremap = true, silent = true },
        d = { '<cmd>lua vim.diagnostic.setloclist()<CR>', 'Open Diagnostics Window', noremap = true, silent = true },
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
    bkm('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    bkm('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    bkm('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    --km('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts) -- not sure if it is useful

    -- Which key mappings
    wk.register({
        l = {
            name = 'LSP',
            a = { '<cmd>lua vim.lsp.buf.code_action()<CR>', 'Code Actions', noremap = true, silent = true },
            D = { '<cmd>lua vim.lsp.buf.type_definition()<CR>', 'Type Definition', noremap = true, silent = true },
            r = { '<cmd>lua vim.lsp.buf.rename()<CR>', 'Rename', noremap = true, silent = true },
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

for _, lsp in pairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        flags = {
            -- This will be the default in neovim 0.7+
            debounce_text_changes = 150,
        }
    }
end
