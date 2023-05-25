local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')
local cond = require('nvim-autopairs.conds')

npairs.setup({
  fast_wrap = {}
})
npairs.add_rules({
  Rule('r#"', '"#', 'rust'),
  Rule('<', '>', 'rust')
      :with_pair(cond.before_regex("[A-Za-z:%d]")),
  Rule('/*', '*/', { 'css', 'java', 'c' }),
  Rule('<!--', '-->', { 'html', 'svelte' }),
})
