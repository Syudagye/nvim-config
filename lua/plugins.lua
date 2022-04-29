--      +---------------------+
--      | Plugin Installation |
--      +---------------------+

-- Packer auto installation
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
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
    use {'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp'}
    use {'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp'}
    use {'hrsh7th/cmp-path', after = 'nvim-cmp'}
    use {'hrsh7th/cmp-buffer', after = 'nvim-cmp'}
    use {'f3fora/cmp-spell', after = 'nvim-cmp'}


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
        require('packer').sync()
    end
end)
