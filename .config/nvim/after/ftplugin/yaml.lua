-- YAML-specific settings and keymaps
-- This file is sourced after LSP initializes for YAML files

local bufnr = vim.api.nvim_get_current_buf()

-- YAML-specific buffer settings
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true
vim.bo.commentstring = "# %s"

-- YAML-specific window settings
vim.wo.wrap = false
vim.wo.foldmethod = "indent"

-- YAML-specific keymaps
local map = function(keys, func, desc)
  vim.keymap.set("n", keys, func, { silent = true, buffer = bufnr, desc = "YAML: " .. desc })
end

-- Schema validation helpers
map("<leader>yv", function()
  -- Trigger YAML validation
  vim.lsp.buf.code_action()
end, "[V]alidate Schema")

-- YAML structure navigation
map("<leader>yf", function()
  -- Find next key at same level
  vim.fn.search("^" .. string.rep(" ", vim.fn.indent(".")) .. "\\w\\+:", "W")
end, "Next [F]ield")

map("<leader>yF", function()
  -- Find previous key at same level
  vim.fn.search("^" .. string.rep(" ", vim.fn.indent(".")) .. "\\w\\+:", "bW")
end, "Previous [F]ield")

-- Fold management for large YAML files
map("<leader>yo", function()
  -- Open all folds
  vim.cmd("normal! zR")
end, "[O]pen All Folds")

map("<leader>yc", function()
  -- Close all folds
  vim.cmd("normal! zM")
end, "[C]lose All Folds")

-- YAML value manipulation
map("<leader>yt", function()
  -- Toggle boolean value (true/false, yes/no)
  local line = vim.api.nvim_get_current_line()
  local new_line = line

  if line:match(": true$") then
    new_line = line:gsub(": true$", ": false")
  elseif line:match(": false$") then
    new_line = line:gsub(": false$", ": true")
  elseif line:match(": yes$") then
    new_line = line:gsub(": yes$", ": no")
  elseif line:match(": no$") then
    new_line = line:gsub(": no$", ": yes")
  end

  if new_line ~= line then
    vim.api.nvim_set_current_line(new_line)
  end
end, "[T]oggle Boolean")

-- List item helpers
map("<leader>yi", function()
  -- Add new list item
  local line = vim.api.nvim_get_current_line()
  local indent = string.match(line, "^%s*") or ""
  local new_item = indent .. "- "
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(bufnr, row, row, false, { new_item })
  vim.api.nvim_win_set_cursor(0, { row + 1, #new_item })
end, "Add List [I]tem")

-- Docker Compose specific helpers (when in docker-compose files)
local filename = vim.api.nvim_buf_get_name(bufnr)
if filename:match("docker%-compose%.ya?ml$") or filename:match("compose%.ya?ml$") then
  map("<leader>ds", function()
    -- Jump to services section
    vim.fn.search("^services:", "w")
  end, "Go to [S]ervices")

  map("<leader>dv", function()
    -- Jump to volumes section
    vim.fn.search("^volumes:", "w")
  end, "Go to [V]olumes")

  map("<leader>dn", function()
    -- Jump to networks section
    vim.fn.search("^networks:", "w")
  end, "Go to [N]etworks")
end

-- Kubernetes specific helpers (when in k8s files)
if
  filename:match("%.k8s%.ya?ml$")
  or filename:match("/k8s/")
  or filename:match("/kubernetes/")
  or vim.fn.getline(1):match("apiVersion:")
then
  map("<leader>ka", function()
    -- Jump to apiVersion
    vim.fn.search("^apiVersion:", "w")
  end, "Go to [A]piVersion")

  map("<leader>kk", function()
    -- Jump to kind
    vim.fn.search("^kind:", "w")
  end, "Go to [K]ind")

  map("<leader>km", function()
    -- Jump to metadata
    vim.fn.search("^metadata:", "w")
  end, "Go to [M]etadata")

  map("<leader>ks", function()
    -- Jump to spec
    vim.fn.search("^spec:", "w")
  end, "Go to [S]pec")
end

-- GitHub Actions specific helpers (when in workflow files)
if filename:match("%.github/workflows/") then
  map("<leader>gj", function()
    -- Jump to jobs section
    vim.fn.search("^jobs:", "w")
  end, "Go to [J]obs")

  map("<leader>gs", function()
    -- Jump to steps in current job
    vim.fn.search("  steps:", "w")
  end, "Go to [S]teps")

  map("<leader>ge", function()
    -- Jump to env section
    vim.fn.search("  env:", "w")
  end, "Go to [E]nv")
end
