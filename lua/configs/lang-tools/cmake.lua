local common = require('configs.lang-tools.common')
local cmtools = require('cmake-tools')
local wk = require('which-key')

-- CMake Tools
local function setup_cmtools()
  cmtools.setup({})

  wk.register({
    c = {
      name = 'CMake Tools',
      a = {
        function()
          vim.cmd('CMakeLaunchArgs ' .. vim.fn.input('args: '))
        end,
        'Set launch arguments for CMake executables',
      },
      g = {
        '<cmd>CMakeGenerate<cr>',
        'Generate build files',
      },
      r = {
        '<cmd>CMakeRun<cr>',
        'Run the selected CMake target',
      },
      d = {
        '<cmd>CMakeDebug<cr>',
        'Debug the selected CMake target',
      },
      t = {
        '<cmd>CMakeSelectLaunchTarget<cr>',
        'Select the CMake target',
      },
      q = {
        name = 'Quick Actions',
        r = {
          '<cmd>CMakeQuickRun<cr>',
          'Quickly run a CMake target',
        },
        d = {
          '<cmd>CMakeQuickDebug<cr>',
          'Quickly debug a CMake target',
        },
      }
    }
  }, {
    prefix = '<leader>',
    noremap = true,
    silent = true
  })
end

local function remove_tool()
  wk.register({ c = nil })
end

common.register_tool('CMakeLists.txt', setup_cmtools, remove_tool)
