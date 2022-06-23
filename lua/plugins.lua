--      +---------------------+
--      | Plugin Installation |
--      +---------------------+

-- Packer auto installation
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

-- Mappings for plugin related things
local status_ok, wk = pcall(require, 'which-key')
if status_ok then
    wk.register({
        p = {
            name = 'Plugins',
            u = { '<cmd>PackerSync<cr>', 'Update Packages', noremap = true },
            s = { '<cmd>PackerStatus<cr>', 'Packer Status', noremap = true },
        }
    }, { prefix = "<leader>" })
end

-- Packages
return packer.startup(function(use)
    -- Packer itself
    use 'wbthomason/packer.nvim'

    -- Color scheme
    use {
        'sainnhe/sonokai',
        config = [[require('plugins.sonokai')]]
    }

    -- Buffer line
    use {
        'akinsho/bufferline.nvim',
        tag = '*',
        requires = 'kyazdani42/nvim-web-devicons',
        config = [[require('plugins.bufferline')]]
    }

    -- File Tree
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = [[require('plugins.nvim-tree')]]
    }

    -- Keymaps Menu
    use {
        'folke/which-key.nvim',
        config = [[require('plugins.which-key')]]
    }

    -- Completion
    use 'onsails/lspkind.nvim' -- for vscode-like icons in completion menu
    use 'L3MON4D3/LuaSnip' -- Snippets engine
    use {
        'hrsh7th/nvim-cmp',
        config = [[require('plugins.cmp')]]
    }
    use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
    use { 'f3fora/cmp-spell', after = 'nvim-cmp' }

    -- LSP
    use 'williamboman/nvim-lsp-installer'
    use {
        'neovim/nvim-lspconfig',
        config = [[require('plugins.lsp')]],
        afert = 'cmp-nvim-lsp'
    }
    use 'j-hui/fidget.nvim' -- Shows lsp info on the bottom right corner
    use 'tami5/lspsaga.nvim'
    use {
        'folke/trouble.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('trouble').setup {}
        end
    }
    use {
        'weilbith/nvim-code-action-menu',
        cmd = 'CodeActionMenu',
    }
    use 'liuchengxu/vista.vim'

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        config = [[require('plugins.treesitter')]]
    }
    use 'p00f/nvim-ts-rainbow'
    use 'nvim-treesitter/nvim-treesitter-textobjects'

    -- Git
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }
    use 'kdheepak/lazygit.nvim'
    use {
        'sindrets/diffview.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = [[require('plugins.diffview')]]
    }

    -- Utilities
    use 'kazhala/close-buffers.nvim'
    use 'ntpeters/vim-better-whitespace'
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require("indent_blankline").setup {
                space_char_blankline = " ",
                show_current_context = true,
                show_current_context_start = true,
            }
        end
    }
    use {
        'windwp/nvim-autopairs',
        config = [[require('plugins.autopairs')]]
    }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use 'https://gitlab.com/yorickpeterse/nvim-pqf'
    use {
        'ahmedkhalf/project.nvim',
        config = function() require('project_nvim').setup {} end
    }
    use {
        'startup-nvim/startup.nvim',
        requires = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
        config = function() require('startup').setup({ theme = 'evil' }) end
    }


    ---- Language specific things ----

    -- Rust
    use {
        'saecki/crates.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = [[require('crates').setup()]] -- Need to dive into configuring this later
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        packer.sync()
    end
end,
    {
    config = {
        display = {
            open_fn = require('packer.util').float,
        }
    }
})
