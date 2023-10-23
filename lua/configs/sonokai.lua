-- Sonokai color scheme

-- Return if terminal do not support true colors
if not vim.fn.exists('+termguicolors') then
  return
end

vim.opt.termguicolors = true

-- Getting a random style at each startup
local styles = {
  'default',
  'atlantis',
  'andromeda',
  'shusia',
  'maia',
  'espresso',
}

vim.cmd('call v:lua.math.randomseed(localtime())')
vim.g.sonokai_style = styles[math.random(1, #styles)]
vim.g.sonokai_better_performance = 1

vim.cmd('colorscheme sonokai')

-- Check if started from neovide (this is the only way it works idk why)
if vim.api.nvim_call_function('exists', { 'g:neovide' }) ~= 1 then
  require('transparent')
  vim.cmd('TransparentEnable')
end
