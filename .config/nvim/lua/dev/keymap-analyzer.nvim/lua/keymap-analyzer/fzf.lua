-- Keymap Analyzer FZF Module
-- Provides fzf-lua specific display functionality for keymap analysis

local M = {}

-- Show duplicate keymaps in fzf-lua
function M.show_duplicates()
  local analyzer = require("keymap-analyzer")
  local details = analyzer.get_duplicate_details()

  if #details == 0 then
    vim.notify("🎉 No duplicate keymaps found!", vim.log.levels.INFO)
    return
  end

  -- Format for fzf-lua display
  local fzf_items = {}
  for _, item in ipairs(details) do
    local display_line = string.format("🔑 %s (%d occurrences)", item.key, item.count)
    local detail_lines = {}

    for _, occurrence in ipairs(item.occurrences) do
      table.insert(
        detail_lines,
        string.format("  📁 %s:%d - %s", occurrence.file, occurrence.line, occurrence.content)
      )
    end

    table.insert(fzf_items, {
      display = display_line,
      details = table.concat(detail_lines, "\n"),
      key = item.key,
      occurrences = item.occurrences,
    })
  end

  require("fzf-lua").fzf_exec(function(cb)
    for _, item in ipairs(fzf_items) do
      cb(string.format("%s\n%s", item.display, item.details))
    end
    cb(nil) -- signal end of data
  end, {
    prompt = "Duplicate Keymaps❯ ",
    fzf_opts = {
      ["--delimiter"] = "\n",
      ["--with-nth"] = "1",
      ["--preview-window"] = "right:50%:wrap",
    },
    previewer = false,
    actions = {
      ["default"] = function(selected)
        if not selected or #selected == 0 then
          return
        end

        -- Extract key from selected line
        local key = selected[1]:match("🔑 ([^%(]+)")
        if key then
          key = key:gsub("%s+$", "") -- trim trailing spaces

          -- Find the item and jump to first occurrence
          for _, item in ipairs(fzf_items) do
            if item.key == key and #item.occurrences > 0 then
              local first = item.occurrences[1]
              analyzer.jump_to_keymap(first.full_path, first.line)
              vim.notify(string.format("Opened %s at line %d", first.file, first.line))
              break
            end
          end
        end
      end,
      ["ctrl-a"] = function(selected)
        if not selected or #selected == 0 then
          return
        end

        -- Send all occurrences to quickfix
        local key = selected[1]:match("🔑 ([^%(]+)")
        if key then
          key = key:gsub("%s+$", "")

          for _, item in ipairs(fzf_items) do
            if item.key == key then
              analyzer.send_to_quickfix(
                item.occurrences,
                string.format("Duplicate keymap '%s'", key)
              )
              break
            end
          end
        end
      end,
    },
    winopts = {
      height = 0.8,
      width = 0.9,
      title = " Duplicate Keymaps ",
      title_pos = "center",
    },
  })
end

-- Show all keymaps in fzf-lua
function M.show_all()
  local analyzer = require("keymap-analyzer")
  local all_keymaps = analyzer.get_all_keymaps()

  if #all_keymaps == 0 then
    vim.notify("No keymaps found in config", vim.log.levels.WARN)
    return
  end

  require("fzf-lua").fzf_exec(function(cb)
    for _, keymap in ipairs(all_keymaps) do
      local line = string.format(
        "🔑 %-20s 📁 %s:%d - %s",
        keymap.key,
        keymap.relative_file,
        keymap.line,
        keymap.content
      )
      cb(line)
    end
    cb(nil)
  end, {
    prompt = "All Keymaps❯ ",
    fzf_opts = {
      ["--nth"] = "1,2",
    },
    actions = {
      ["default"] = function(selected)
        if not selected or #selected == 0 then
          return
        end

        -- Extract file and line from selected
        local file_line = selected[1]:match("📁 ([^%-]+)")
        if file_line then
          local file, line = file_line:match("([^:]+):(%d+)")
          if file and line then
            local full_path = vim.fn.stdpath("config") .. "/" .. file
            analyzer.jump_to_keymap(full_path, tonumber(line))
            vim.notify(string.format("Opened %s at line %d", file, line))
          end
        end
      end,
      ["ctrl-a"] = function(selected)
        -- Send all visible keymaps to quickfix
        local qf_keymaps = {}
        for _, keymap in ipairs(all_keymaps) do
          table.insert(qf_keymaps, {
            key = keymap.key,
            full_path = keymap.file,
            line = keymap.line,
            content = keymap.content,
          })
        end
        analyzer.send_to_quickfix(qf_keymaps, "All keymaps")
      end,
    },
    winopts = {
      height = 0.8,
      width = 0.9,
      title = " All Keymaps ",
      title_pos = "center",
    },
  })
end

-- Show keymap statistics
function M.show_stats()
  local analyzer = require("keymap-analyzer")
  local stats = analyzer.get_duplicate_stats()
  local all_keymaps = analyzer.get_all_keymaps()

  local message = string.format(
    "📊 Keymap Statistics:\n"
      .. "• Total keymaps: %d\n"
      .. "• Duplicate keys: %d\n"
      .. "• Total duplicates: %d\n"
      .. "• Status: %s",
    #all_keymaps,
    stats.duplicate_keys,
    stats.total_duplicates,
    stats.has_duplicates and "⚠️  Duplicates found" or "✅ No duplicates"
  )

  vim.notify(message, stats.has_duplicates and vim.log.levels.WARN or vim.log.levels.INFO)
end

return M
