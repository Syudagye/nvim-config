local M = {}

function M.is_file_present_in_parent(file)
  local n = #vim.fs.find(file, {
    upward = true,
    stop = vim.loop.os_homedir(),
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
  })
  return n >= 1
end

function M.register_tool(file_match, setup_fn, remove_fn)
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*" },
    callback = function()
      if M.is_file_present_in_parent(file_match) then
        setup_fn()
      else
        remove_fn()
      end
    end
  })
end

return M
