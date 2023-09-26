--      +----------+
--      | Mappings |
--      +----------+

local function km(...) vim.api.nvim_set_keymap(...) end

km('n', '<A-c>', '<cmd>bd<CR>', {})
km('n', '<esc>', '<cmd>noh<CR>', {})
