--- Bootstrap lazy.nvim

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

require("lazy").setup({
  -- Colorscheme
  {
    'sainnhe/sonokai',
    config = function()
      require('configs.sonokai')
    end
  },
  'xiyaowong/transparent.nvim', -- To remove background color

  -- Buffer line
  {
    'akinsho/bufferline.nvim',
    config = function()
      require('configs.bufferline')
    end
  },

  -- status line
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require("configs.lualine")
    end
  },

  -- File Tree
  'nvim-tree/nvim-web-devicons',
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    config = function()
      require("configs.nvim-tree")
    end,
  },

  -- Keymaps Menu
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
  },

  -- Completion
  'onsails/lspkind.nvim', -- for vscode-like icons in completion menu
  {
    "L3MON4D3/LuaSnip",   -- Snippets engine
    version = "v2.*",     -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    build = "make install_jsregexp"
  },
  {
    'hrsh7th/nvim-cmp',
    config = function()
      require('configs.cmp')
    end
  },
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lsp-signature-help',
  'hrsh7th/cmp-nvim-lua',
  'FelipeLema/cmp-async-path',
  'hrsh7th/cmp-buffer',
  'f3fora/cmp-spell',
  {
    'petertriho/cmp-git',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },

  -- LSP
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('configs.lsp')
    end,
  },
  {
    'j-hui/fidget.nvim', -- Shows lsp info on the bottom right corner
    config = function()
      require("fidget").setup {
        window = {
          blend = 0
        }
      }
    end,
    event = "LspAttach",
    branch = 'legacy'
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        ui = {
          title = false
        },
        symbol_in_winbar = {
          enable = false
        }
      })
    end,
  },
  {
    'folke/trouble.nvim',
    event = "LspAttach",
    config = function()
      require('trouble').setup {}
    end
  },

  -- Cool, but maybe not be a necessity
  'liuchengxu/vista.vim',

  -- hints for function args when typing
  {
    'ray-x/lsp_signature.nvim',
    event = "LspAttach",
    config = function()
      require('lsp_signature').setup({}) -- TODO: configure
    end
  },
  -- Symbols on the topbar (VSCode Style)
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
    },
    config = function()
      require('barbecue').setup({
        attach_navic = false,
      })
    end
  },


  -- DAP
  {
    'mfussenegger/nvim-dap',
    config = function()
      require('configs.dap')
    end,
    dependencies = { 'nvim-neotest/nvim-nio' },
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap' },
  },


  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('configs.treesitter')
    end
  },
  'nvim-treesitter/nvim-treesitter-textobjects',

  -- Git
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },
  'kdheepak/lazygit.nvim',

  -- Utilities
  {
    'ntpeters/vim-better-whitespace',
    config = function()
      vim.g.better_whitespace_filetypes_blacklist = {
        -- defaults
        'diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'fugitive',
        -- specific ones
        'dashboard'
      }
    end
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    opts = {
      exclude = { filetypes = { 'dashboard' } },
      scope = { enabled = true }
    }
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('configs.autopairs')
    end
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    config = function()
      require('configs.alpha')
    end
  },
  {
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup()
    end
  },
  {
    'nmac427/guess-indent.nvim',
    config = function() require('guess-indent').setup {} end,
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').load_extension('projects')

      require('which-key').add({
        { "<leader>f", "<cmd>Telescope find_files<CR>", desc = "Telescope file browser",  remap = false },
        { "<leader>p", "<cmd>Telescope projects<CR>",   desc = "Telescope projects list", remap = false },
      })
    end
  },
  {
    'davidgranstrom/nvim-markdown-preview',
    config = function()
      require('which-key').add({
        { "<leader>m", "<cmd>MarkdownPreview<cr>", desc = "Toggle peak MarkDown preview", remap = false },
      })
    end
  },

  ---- Language specific things ----

  -- Rust
  {
    'saecki/crates.nvim',
    dpendencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crates').setup() -- Need to dive into configuring this later
    end,
    event = "BufEnter Cargo.toml"
  },
  -- TODO: Make this work, or find an alternative...
  -- {
  --   'simrat39/rust-tools.nvim',
  --   dependencies = { 'nvim-lua/plenary.nvim' },
  --   config = function()
  --     require('configs.lang-tools.rust')
  --   end
  -- },

  -- RON
  {
    'ron-rs/ron.vim',
    event = "BufEnter *.ron"
  },

  -- CMake
  {
    'Civitasv/cmake-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      -- require('configs.lang-tools.cmake')
    end
  },

  -- GLSL
  'tikhomirov/vim-glsl',

  -- Ocaml
  {
    'Syudagye/utop.nvim',
    opts = {
      insert_on_open = false,
      evaluate_keybind = "<leader>v",
      open_keybind = "<leader>o",
    }
  },
})
