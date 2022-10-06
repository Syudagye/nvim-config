--      +-----------------+
--      | General options |
--      +-----------------+

local o = vim.opt

o.number = true
o.title = true
o.showmode = false
o.cursorline = true
o.mouse = 'nv'
o.termguicolors = true
o.signcolumn = 'yes'
o.scrolloff = 8
o.linebreak = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.expandtab = true
o.smartindent = true
o.ignorecase = true
o.smartcase = true
o.completeopt = 'menuone,preview,noinsert'
o.spelllang = 'en,fr'
o.autoread = true
o.swapfile = false
-- o.matchpairs = '(:),{:},[:],<:>,":",\':\',`:`,/*:*/'
o.undofile = true
o.guifont = 'iosevka:h9'
o.timeoutlen = 500
o.pumwidth = 30 -- minimum completion menu width (do not work idk)

vim.g.mapleader = ' '
