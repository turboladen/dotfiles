-- Dependency Analyzer Builtin Display Module
-- Uses Neovim's built-in features for display

local M = {}

-- Display using vim.notify and basic print
function M.show_summary()
  local analyzer = require("dependency-analyzer")

  -- Show loading message
  vim.notify("🔍 Checking dependencies...", vim.log.levels.INFO, { title = "Dependency Check" })

  analyzer.analyze_async(function(results)
    vim.schedule(function()
      local summary = {
        total_tools = results.summary.total_tools,
        installed = results.summary.installed,
        missing = results.summary.missing,
        has_missing = results.summary.missing > 0,
      }

      local level = summary.has_missing and vim.log.levels.WARN or vim.log.levels.INFO
      local status_icon = summary.has_missing and "⚠️" or "✅"

      local message = string.format(
        "%s Dependencies: %d total, %d installed, %d missing",
        status_icon,
        summary.total_tools,
        summary.installed,
        summary.missing
      )

      vim.notify(message, level, { title = "Dependency Check" })
    end)
  end)
end

-- Display missing tools in a new buffer
function M.show_missing()
  local analyzer = require("dependency-analyzer")

  -- Show loading message
  vim.notify("🔍 Analyzing dependencies...", vim.log.levels.INFO)

  analyzer.analyze_async(function(results)
    vim.schedule(function()
      local missing = {}

      for tool_name, tool_data in pairs(results.all_tools) do
        if not tool_data.install_status.installed then
          table.insert(missing, {
            name = tool_name,
            type = tool_data.info.type,
            source = tool_data.info.source,
            found_in = tool_data.found_in,
            install_cmd = nil, -- Will be populated from comments if available
          })
        end
      end

      -- Add install commands from comments
      for _, tool in ipairs(missing) do
        for file_name, file_data in pairs(results.by_file) do
          if file_data.comments[tool.name] and file_data.comments[tool.name].install_cmd then
            tool.install_cmd = file_data.comments[tool.name].install_cmd
            break
          end
        end
      end

      if #missing == 0 then
        vim.notify("✅ All dependencies are installed!", vim.log.levels.INFO)
        return
      end

      -- Create a new buffer
      local buf = vim.api.nvim_create_buf(false, true)
      local lines = {
        "# Dependencies Analysis",
        "",
        string.format(
          "Found %d missing tools and %d installed tools:",
          #missing,
          results.summary.installed
        ),
        "",
      }

      -- Missing tools section
      if #missing > 0 then
        table.insert(lines, "## ❌ Missing Tools")
        table.insert(lines, "")

        -- Group missing tools by type
        local missing_by_type = {}
        for _, tool in ipairs(missing) do
          local tool_type = tool.type or "unknown"
          if not missing_by_type[tool_type] then
            missing_by_type[tool_type] = {}
          end
          table.insert(missing_by_type[tool_type], tool)
        end

        for tool_type, tools in pairs(missing_by_type) do
          table.insert(lines, string.format("### %s (%d)", tool_type:upper(), #tools))
          table.insert(lines, "")

          for _, tool in ipairs(tools) do
            table.insert(lines, string.format("**%s**", tool.name))
            if tool.install_cmd then
              table.insert(lines, string.format("  Install: `%s`", tool.install_cmd))
            end
            table.insert(lines, string.format("  Found in: %s", table.concat(tool.found_in, ", ")))
            table.insert(lines, string.format("  Source: %s", tool.source))
            table.insert(lines, "")
          end
        end
      end

      -- Installed tools section
      if results.summary.installed > 0 then
        table.insert(lines, "## ✅ Installed Tools")
        table.insert(lines, "")

        -- Group installed tools by type
        local installed_by_type = {}
        for tool_name, tool_data in pairs(results.all_tools) do
          if tool_data.install_status.installed then
            local tool_type = tool_data.info.type or "unknown"
            if not installed_by_type[tool_type] then
              installed_by_type[tool_type] = {}
            end
            table.insert(installed_by_type[tool_type], {
              name = tool_name,
              version = tool_data.install_status.version,
              found_in = tool_data.found_in,
            })
          end
        end

        for tool_type, tools in pairs(installed_by_type) do
          table.insert(lines, string.format("### %s (%d)", tool_type:upper(), #tools))
          table.insert(lines, "")

          for _, tool in ipairs(tools) do
            local version = tool.version or "version unknown"
            table.insert(lines, string.format("**%s**: %s", tool.name, version))
            table.insert(lines, string.format("  Found in: %s", table.concat(tool.found_in, ", ")))
            table.insert(lines, "")
          end
        end
      end

      -- Set buffer content
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

      -- Open in a new window
      vim.cmd("vsplit")
      vim.api.nvim_win_set_buf(0, buf)

      -- Set buffer options
      vim.bo[buf].filetype = "markdown"
      vim.bo[buf].modifiable = false
      vim.bo[buf].buftype = "nofile"
      vim.wo.wrap = true

      -- Set buffer name
      vim.api.nvim_buf_set_name(buf, "[Dependencies Overview]")

      local level = #missing > 0 and vim.log.levels.WARN or vim.log.levels.INFO
      local message =
        string.format("Dependencies: %d missing, %d installed", #missing, results.summary.installed)
      vim.notify(message, level)
    end)
  end)
end

-- Show install commands in a way that's easy to copy
function M.show_install_commands()
  local analyzer = require("dependency-analyzer")

  -- Show loading message
  vim.notify("🔍 Generating install script...", vim.log.levels.INFO)

  analyzer.analyze_async(function(results)
    vim.schedule(function()
      local missing = {}

      for tool_name, tool_data in pairs(results.all_tools) do
        if not tool_data.install_status.installed then
          table.insert(missing, {
            name = tool_name,
            type = tool_data.info.type,
            source = tool_data.info.source,
            found_in = tool_data.found_in,
            install_cmd = nil, -- Will be populated from comments if available
          })
        end
      end

      -- Add install commands from comments
      for _, tool in ipairs(missing) do
        for file_name, file_data in pairs(results.by_file) do
          if file_data.comments[tool.name] and file_data.comments[tool.name].install_cmd then
            tool.install_cmd = file_data.comments[tool.name].install_cmd
            break
          end
        end
      end

      if #missing == 0 then
        vim.notify("✅ All dependencies are installed!", vim.log.levels.INFO)
        return
      end

      -- Create a new buffer with install commands
      local buf = vim.api.nvim_create_buf(false, true)
      local lines = {
        "#!/bin/bash",
        "# Install missing dependencies for Neovim config",
        "# Generated by dependency-analyzer",
        "",
      }

      -- Group by installer for batch installation
      local by_installer = {}
      for _, tool in ipairs(missing) do
        if tool.install_cmd then
          local installer = tool.install_cmd:match("^(%w+)")
          if installer then
            if not by_installer[installer] then
              by_installer[installer] = {}
            end
            table.insert(by_installer[installer], tool)
          end
        end
      end

      -- Order installers for logical grouping
      local installer_order = { "brew", "cargo", "npm", "pip", "go", "gem" }

      for _, installer in ipairs(installer_order) do
        if by_installer[installer] then
          table.insert(lines, string.format("# %s tools", installer:upper()))
          for _, tool in ipairs(by_installer[installer]) do
            table.insert(lines, string.format("echo 'Installing %s...'", tool.name))
            table.insert(lines, tool.install_cmd)
            table.insert(lines, "")
          end
        end
      end

      -- Handle other installers not in the ordered list
      for installer, tools in pairs(by_installer) do
        if not vim.tbl_contains(installer_order, installer) then
          table.insert(lines, string.format("# %s tools", installer:upper()))
          for _, tool in ipairs(tools) do
            table.insert(lines, string.format("echo 'Installing %s...'", tool.name))
            table.insert(lines, tool.install_cmd)
            table.insert(lines, "")
          end
        end
      end

      -- Add manual tools
      local manual_tools = {}
      for _, tool in ipairs(missing) do
        if not tool.install_cmd then
          table.insert(manual_tools, tool)
        end
      end

      if #manual_tools > 0 then
        table.insert(lines, "# Manual installation needed:")
        for _, tool in ipairs(manual_tools) do
          table.insert(
            lines,
            string.format("# %s (found in: %s)", tool.name, table.concat(tool.found_in, ", "))
          )
        end
      end

      -- Set buffer content
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

      -- Open in a new window
      vim.cmd("split")
      vim.api.nvim_win_set_buf(0, buf)

      -- Set buffer options
      vim.bo[buf].filetype = "bash"
      vim.bo[buf].modifiable = true
      vim.bo[buf].buftype = "nofile"

      -- Set buffer name
      vim.api.nvim_buf_set_name(buf, "[Install Commands]")

      vim.notify("Install script ready - review and run as needed", vim.log.levels.INFO)
    end)
  end)
end

-- Show full report in a buffer
function M.show_full_report()
  local analyzer = require("dependency-analyzer")

  -- Show loading message
  vim.notify("🔍 Generating full report...", vim.log.levels.INFO)

  analyzer.analyze_async(function(results)
    vim.schedule(function()
      -- Create a new buffer
      local buf = vim.api.nvim_create_buf(false, true)
      local lines = {
        "# Neovim External Dependencies Analysis",
        "",
        "## Summary",
        string.format("- Total tools: %d", results.summary.total_tools),
        string.format("- ✅ Installed: %d", results.summary.installed),
        string.format("- ❌ Missing: %d", results.summary.missing),
        "",
      }

      -- Add by-type breakdown
      if next(results.summary.by_type) then
        table.insert(lines, "### By Type")
        for tool_type, count in pairs(results.summary.by_type) do
          table.insert(lines, string.format("- %s: %d", tool_type, count))
        end
        table.insert(lines, "")
      end

      -- Missing tools section
      if results.summary.missing > 0 then
        table.insert(lines, "## ❌ Missing Tools")
        table.insert(lines, "")

        for tool_name, tool_data in pairs(results.all_tools) do
          if not tool_data.install_status.installed then
            table.insert(lines, string.format("### %s (%s)", tool_name, tool_data.info.type))
            table.insert(
              lines,
              string.format("- Found in: %s", table.concat(tool_data.found_in, ", "))
            )
            table.insert(lines, string.format("- Source: %s", tool_data.info.source))

            -- Check for install command in comments
            for file_name, file_data in pairs(results.by_file) do
              if file_data.comments[tool_name] and file_data.comments[tool_name].install_cmd then
                table.insert(
                  lines,
                  string.format("- Install: `%s`", file_data.comments[tool_name].install_cmd)
                )
                break
              end
            end
            table.insert(lines, "")
          end
        end
      end

      -- Installed tools section
      if results.summary.installed > 0 then
        table.insert(lines, "## ✅ Installed Tools")
        table.insert(lines, "")

        for tool_name, tool_data in pairs(results.all_tools) do
          if tool_data.install_status.installed then
            local version = tool_data.install_status.version or "version unknown"
            table.insert(
              lines,
              string.format("- **%s**: %s (%s)", tool_name, version, tool_data.info.type)
            )
          end
        end
        table.insert(lines, "")
      end

      -- By file breakdown
      table.insert(lines, "## By Configuration File")
      table.insert(lines, "")

      for file_name, file_data in pairs(results.by_file) do
        local has_tools = false
        local tool_count = 0

        -- Count tools in this file
        for category, tools in pairs(file_data) do
          if type(tools) == "table" and category ~= "comments" then
            tool_count = tool_count + vim.tbl_count(tools)
            if vim.tbl_count(tools) > 0 then
              has_tools = true
            end
          end
        end

        if has_tools or next(file_data.comments) then
          table.insert(lines, string.format("### %s.lua (%d tools)", file_name, tool_count))

          for category, tools in pairs(file_data) do
            if type(tools) == "table" and vim.tbl_count(tools) > 0 then
              if category == "comments" then
                local comment_tools = {}
                for tool, info in pairs(tools) do
                  if type(info) == "table" then
                    table.insert(comment_tools, string.format("%s: %s", tool, info.install_cmd))
                  end
                end
                if #comment_tools > 0 then
                  table.insert(lines, "- Comments:")
                  for _, comment in ipairs(comment_tools) do
                    table.insert(lines, string.format("  - %s", comment))
                  end
                end
              else
                local tool_names = vim.tbl_keys(tools)
                table.sort(tool_names)
                table.insert(
                  lines,
                  string.format("- %s: %s", category, table.concat(tool_names, ", "))
                )
              end
            end
          end
          table.insert(lines, "")
        end
      end

      -- Set buffer content
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

      -- Open in a new window
      vim.cmd("tabnew")
      vim.api.nvim_win_set_buf(0, buf)

      -- Set buffer options
      vim.bo[buf].filetype = "markdown"
      vim.bo[buf].modifiable = false
      vim.bo[buf].buftype = "nofile"
      vim.wo.wrap = true

      -- Set buffer name
      vim.api.nvim_buf_set_name(buf, "[Dependency Report]")
    end)
  end)
end

return M
