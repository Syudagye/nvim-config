--      +----------+
--      | Mappings |
--      +----------+

local wk = require('which-key')

wk.register({
  c = {
    name = 'Configuration',
    e = { '<cmd>e $HOME/.config/nvim/init.lua<cr>', 'Edit Config', noremap = true },
    r = { '<cmd>luafile $HOME/.config/nvim/init.lua<cr>', 'Reload Config', noremap = true },
  }
}, { prefix = "<leader>" })
