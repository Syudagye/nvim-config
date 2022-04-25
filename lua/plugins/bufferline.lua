-- Options
require("bufferline").setup{
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

-- Keymaps
local function km(...) vim.api.nvim_set_keymap(...) end

km('n', '<A-,>', ':BufferLineCyclePrev<CR>', {})
km('n', '<A-;>', ':BufferLineCycleNext<CR>', {})
km('n', '<A-?>', ':BufferLineMovePrev<CR>', {})
km('n', '<A-.>', ':BufferLineMoveNext<CR>', {})
km('n', '<A-c>', ':bd<CR>', {})
