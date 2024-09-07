-- DAP Configuration
local dap = require('dap')
local wk = require('which-key')

dap.adapters = {
  codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
      command = 'codelldb',
      args = { '--port', '${port}' }
    }
  }
}

local opts = { noremap = true, silent = true }
local function km(...) vim.api.nvim_set_keymap(...) end

km('n', '<F5>', '<cmd>lua require("dap").continue()<cr>', opts)
km('n', '<F9>', '<cmd>lua require("dap").terminate() <cr>', opts)
km('n', '<F10>', '<cmd>lua require("dap").step_over() <cr>', opts)
km('n', '<F11>', '<cmd>lua require("dap").step_into() <cr>', opts)
km('n', '<F12>', '<cmd>lua require("dap").step_out() <cr>', opts)

wk.add({
  {
    "<leader>b",
    function()
      require('dap').toggle_breakpoint()
    end,
    desc = "Toggle a breakpoint",
    remap = false
  },
})

-- Config for dapui
local dapui = require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

dapui.setup({
  layouts = { {
    elements = { {
      id = "scopes",
      size = 0.25
    }, {
      id = "breakpoints",
      size = 0.25
    }, {
      id = "stacks",
      size = 0.25
    }, {
      id = "watches",
      size = 0.25
    } },
    position = "left",
    size = 40
  }, {
    elements = { {
      id = "repl",
      size = 0.5
    }, {
      id = "console",
      size = 0.5
    } },
    position = "bottom",
    size = 20
  } }
})
