local alpha = require('alpha')
local theme = require('alpha.themes.theta')
local gen_button = require('alpha.themes.dashboard').button

local function reverse(arr)
  local rev = {}
  for i = #arr, 1, -1 do
    rev[#rev + 1] = arr[i]
  end
  return rev
end

local function projects()
  local pjs = reverse(require('project_nvim').get_recent_projects())

  local tbl = {}
  for i, pj in ipairs(table.move(pjs, 1, 10, 1, {})) do
    local short_pj_name = vim.fn.fnamemodify(pj, ":~")

    -- copied from theta theme
    local path_ok, plenary_path = pcall(require, "plenary.path")
    if path_ok then
      local target_width = 35
      if #short_pj_name > target_width then
        short_pj_name = plenary_path.new(short_pj_name):shorten(1, { -2, -1 })
        if #short_pj_name > target_width then
          short_pj_name = plenary_path.new(short_pj_name):shorten(1, { -1 })
        end
      end
    end

    local shortcut = tostring(i - 1)
    local e = gen_button('p ' .. shortcut, '[' .. shortcut .. '] ' .. short_pj_name,
      "<cmd>cd " .. pj .. " | Telescope find_files<CR>")
    tbl[i] = e
  end

  return {
    type = "group",
    val = tbl,
    opts = {}
  }
end

local section_projects = {
  type = "group",
  val = { {
    opts = {
      hl = "SpecialComment",
      position = "center",
      shrink_margin = false
    },
    type = "text",
    val = "Projects"
  }, {
    type = "padding",
    val = 1
  }, {
    opts = {
      shrink_margin = false
    },
    type = "group",
    val = function()
      return { projects() }
    end
  } }
}

table.insert(theme.config.layout, 4, section_projects)
table.insert(theme.config.layout, 5, theme.config.layout[3])

alpha.setup(theme.config)
