local cb = require 'diffview.config'.diffview_callback

require 'diffview'.setup {
  key_bindings = {
    file_panel = {
      ["l"] = cb("select_entry"),
    }
  }
}

require 'which-key'.register({
  g = {
    name = 'Git',
    d = { '<cmd>DiffviewOpen<cr>', 'Diffview', noremap = true },
    c = { '<cmd>DiffviewClose<cr>', 'Close Diffview', noremap = true },
    h = { '<cmd>DiffviewFileHistory<cr>', 'File History', noremap = true },
    l = { '<cmd>LazyGit<cr>', 'Lazygit', noremap = true },
    f = { '<cmd>LazyGitFilter<cr>', 'Lazygit Filter', noremap = true },
  }
}, {
  prefix = '<leader>'
})
