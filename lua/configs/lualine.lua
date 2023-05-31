require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'sonokai',
    component_separators = { left = '', right = '' },
    section_separators = '',
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = { "NvimTree" },
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      'branch',
      'diff'
    },
    lualine_c = {
      {
        function()
          return '%='
        end,
        separator = ''
      },
      {
        'filename',
      }
    },
    lualine_x = {
      'searchcount',
      {
        'diagnostics',
        sources = { "nvim_lsp" },
        separator = ''
      },
      {
        -- Grabs the currently running lsp server name
        -- (Copied from https://github.com/nvim-lualine/lualine.nvim/blob/05d78e9fd0cdfb4545974a5aa14b1be95a86e9c9/examples/evil_lualine.lua#L160)
        function()
          local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return ''
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return ''
        end,
        icon = '',
      }
    },
    lualine_y = {
      'filetype',
      'encoding',
      'location'
    },
    lualine_z = { 'progress' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
