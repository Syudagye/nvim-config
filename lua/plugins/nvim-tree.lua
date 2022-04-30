local mappings = {
    { key = {"l", "<CR>", "<2-LeftMouse>"}, action = "edit" },
    { key = {"h", "<BS>"},                  action = "close_node" },
    { key = "C",                            action = "cd" },
    { key = {"<C-h>"},                      action = "toggle_dotfiles" },
}

require'nvim-tree'.setup {
  view = {
    mappings = {
      list = mappings,
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 400,
  },
}
vim.g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
        unstaged = "",
        staged = "✓",
        unmerged = "",
        renamed = "➜",
        untracked = "N",
        deleted = "",
        ignored = "i",
    },
    folder = {
        arrow_open = "",
        arrow_closed = "",
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
        symlink_open = "",
    }
}

-- Spawning an explorer
local wk = require("which-key")

wk.register({
    e = { '<cmd>:NvimTreeToggle<cr>', 'File Tree', noremap = true }
}, { prefix = "<leader>" })
