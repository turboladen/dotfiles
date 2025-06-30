-- Configuration for loading extras
-- Enable/disable extras by setting to true/false

local M = {}

-- Extras configuration
M.extras = {
  -- Colorscheme extras
  colorscheme = true,

  -- AI extras
  ai = true,

  -- Editor extras
  ["editor.search"] = true,

  -- Language extras
  ["lang.python"] = true,

  -- Add other extras here as needed
  -- dap = false,
  -- test = false,
}

-- Get list of enabled extras
function M.get_enabled_extras()
  local enabled = {}
  for name, enabled_flag in pairs(M.extras) do
    if enabled_flag then
      table.insert(enabled, { import = "plugins.extras." .. name })
    end
  end
  return enabled
end

return M
