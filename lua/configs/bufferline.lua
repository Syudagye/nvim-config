-- Options
require("bufferline").setup{
    options = {
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left"
            }
        },
        show_tab_indicators = true,
        always_show_bufferline = false
    }
}

-- Keymaps
local function km(...) vim.api.nvim_set_keymap(...) end

km('n', '<A-,>', '<cmd>BufferLineCyclePrev<CR>', {})
km('n', '<A-;>', '<cmd>BufferLineCycleNext<CR>', {})
km('n', '<A-?>', '<cmd>BufferLineMovePrev<CR>', {})
km('n', '<A-.>', '<cmd>BufferLineMoveNext<CR>', {})
km('n', '<A-C>', '<cmd>BufferLineCloseOthers<CR>', {})
