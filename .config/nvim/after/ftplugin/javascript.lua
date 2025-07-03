-- JavaScript-specific settings
-- This file is sourced after LSP initializes for JavaScript files

-- JavaScript-specific buffer settings
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true
vim.bo.commentstring = "// %s"

-- JavaScript-specific window settings
vim.wo.wrap = false

-- Check if this is a Deno project
local function is_deno_project()
  local deno_config = vim.fn.findfile("deno.json", ".;")
  local deno_config_jsonc = vim.fn.findfile("deno.jsonc", ".;")
  return deno_config ~= "" or deno_config_jsonc ~= ""
end

if is_deno_project() then
  -- In Deno projects, use denols LSP
  -- JavaScript editing is handled by denols LSP with deno fmt/lint
  vim.b.is_deno_project = true
else
  -- In regular projects, use ts_ls and eslint LSPs
  -- JavaScript editing is handled by ts_ls and eslint LSPs
end
