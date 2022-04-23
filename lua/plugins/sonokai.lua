-- Sonokai color scheme

-- Return if terminal do not support true colors
if not vim.fn.exists('+termguicolors') then
    return
end

vim.opt.termguicolors = true

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
