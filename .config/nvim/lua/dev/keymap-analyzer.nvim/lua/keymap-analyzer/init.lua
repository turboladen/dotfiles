-- Keymap Analyzer - A Neovim plugin for analyzing keymap conflicts
-- Main module providing core keymap analysis functionality

local M = {}

-- Helper function to extract keymaps from a Lua file
local function extract_keymaps_from_file(filepath)
  local keymaps = {}
  local file = io.open(filepath, "r")
  if not file then
    return keymaps
  end

  local content = file:read("*all")
  file:close()

  local line_num = 1
  for line in content:gmatch("[^\r\n]+") do
    -- Pattern to match various keymap definitions
    local patterns = {
      -- vim.keymap.set patterns: vim.keymap.set("n", "<leader>x", ...)
      'vim%.keymap%.set%(["\']([nvxsoilct]*)["\'],%s*["\']([^"\']+)["\']',
      -- keys table patterns in lazy.nvim specs: { "<leader>x", ..., desc = "..." }
      '{%s*["\']([^"\']+)["\'],%s*[^,]*,%s*desc%s*=%s*["\']([^"\']*)["\']',
      -- Local map function patterns: map("<leader>x", ...)
      'map%(["\']([^"\']+)["\']',
      -- which-key patterns: { "<leader>x", group = "..." }
      '{%s*["\']([^"\']+)["\'],%s*group%s*=%s*["\']([^"\']*)["\']',
    }

    for _, pattern in ipairs(patterns) do
      local key = line:match(pattern)
      if key and key ~= "" then
        -- Skip non-keymap patterns and config-like strings
        if not key:match("^<[A-Z%-]+>$")
           and not key:match("^mode$")
           and not key:match("^desc$")
           and not key:match("^group$")
           and not key:match("^buffer$")
           and key:len() > 1 then
          table.insert(keymaps, {
            key = key,
            line = line_num,
            file = filepath,
            content = line:gsub("^%s+", ""):gsub("%s+$", ""), -- trim whitespace
          })
        end
      end
    end

    line_num = line_num + 1
  end

  return keymaps
end

-- Scan config directory for Lua files
local function get_config_files()
  local config_path = vim.fn.stdpath("config")
  local files = {}

  -- Use vim.fn.globpath to recursively find .lua files
  local lua_files = vim.fn.globpath(config_path, "**/*.lua", true, true)

  for _, file in ipairs(lua_files) do
    -- Skip lazy-lock.json and other non-config files
    if not file:match("lazy%-lock") and not file:match("%.git") then
      table.insert(files, file)
    end
  end

  return files
end

-- Get all keymaps with their locations
function M.get_all_keymaps()
  local all_keymaps = {}
  local files = get_config_files()

  -- Extract keymaps from all files
  for _, file in ipairs(files) do
    local keymaps = extract_keymaps_from_file(file)
    for _, keymap in ipairs(keymaps) do
      -- Add relative path for cleaner display
      keymap.relative_file = keymap.file:gsub(vim.fn.stdpath("config") .. "/", "")
      table.insert(all_keymaps, keymap)
    end
  end

  -- Sort by key
  table.sort(all_keymaps, function(a, b)
    return a.key < b.key
  end)

  return all_keymaps
end

-- Find duplicate keymaps
function M.find_duplicates()
  local all_keymaps = M.get_all_keymaps()

  -- Group keymaps by key
  local keymap_groups = {}
  for _, keymap in ipairs(all_keymaps) do
    if not keymap_groups[keymap.key] then
      keymap_groups[keymap.key] = {}
    end
    table.insert(keymap_groups[keymap.key], keymap)
  end

  -- Filter for duplicates only
  local duplicates = {}
  for key, keymaps in pairs(keymap_groups) do
    if #keymaps > 1 then
      duplicates[key] = keymaps
    end
  end

  return duplicates
end

-- Get duplicate statistics
function M.get_duplicate_stats()
  local duplicates = M.find_duplicates()
  local total_duplicates = 0
  local duplicate_keys = 0

  for _, keymaps in pairs(duplicates) do
    duplicate_keys = duplicate_keys + 1
    total_duplicates = total_duplicates + #keymaps
  end

  return {
    duplicate_keys = duplicate_keys,
    total_duplicates = total_duplicates,
    has_duplicates = duplicate_keys > 0,
  }
end

-- Get detailed duplicate information for display
function M.get_duplicate_details()
  local duplicates = M.find_duplicates()
  local details = {}

  for key, keymaps in pairs(duplicates) do
    local item = {
      key = key,
      count = #keymaps,
      occurrences = {}
    }

    for _, keymap in ipairs(keymaps) do
      table.insert(item.occurrences, {
        file = keymap.relative_file,
        line = keymap.line,
        content = keymap.content,
        full_path = keymap.file,
      })
    end

    table.insert(details, item)
  end

  -- Sort by key name
  table.sort(details, function(a, b)
    return a.key < b.key
  end)

  return details
end

-- Jump to a specific keymap location
function M.jump_to_keymap(filepath, line_num)
  if not vim.fn.filereadable(filepath) then
    vim.notify("File not readable: " .. filepath, vim.log.levels.ERROR)
    return false
  end

  vim.cmd("edit " .. filepath)
  if line_num and line_num > 0 then
    vim.api.nvim_win_set_cursor(0, { line_num, 0 })
  end

  return true
end

-- Create quickfix list from keymaps
function M.send_to_quickfix(keymaps, title)
  local qf_items = {}

  for _, keymap in ipairs(keymaps) do
    table.insert(qf_items, {
      filename = keymap.full_path or keymap.file,
      lnum = keymap.line,
      text = string.format("[%s] %s", keymap.key or "unknown", keymap.content),
    })
  end

  if #qf_items > 0 then
    vim.fn.setqflist(qf_items)
    vim.cmd("copen")
    if title then
      vim.notify(string.format("%s: Added %d items to quickfix", title, #qf_items))
    end
    return true
  end

  return false
end

return M
