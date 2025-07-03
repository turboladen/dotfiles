-- Dockerfile-specific settings and keymaps
-- This file is sourced after LSP initializes for Dockerfile files

local bufnr = vim.api.nvim_get_current_buf()

-- Dockerfile-specific buffer settings
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true
vim.bo.commentstring = "# %s"

-- Dockerfile-specific window settings
vim.wo.wrap = false

-- Dockerfile-specific keymaps
local map = function(keys, func, desc)
  vim.keymap.set("n", keys, func, { silent = true, buffer = bufnr, desc = "Docker: " .. desc })
end

-- Multi-stage build helpers
map("<leader>ds", function()
  -- Insert stage separator comment
  local lines = {
    "",
    "# " .. string.rep("=", 50),
    "# Stage: ",
    "# " .. string.rep("=", 50),
    "",
  }
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(bufnr, row, row, false, lines)
  vim.api.nvim_win_set_cursor(0, { row + 3, 9 })
end, "[S]tage separator")

-- Common patterns
map("<leader>di", function()
  -- Insert common RUN apt install pattern
  local lines = {
    "RUN apt-get update && \\",
    "    apt-get install -y --no-install-recommends \\",
    "        && \\",
    "    apt-get clean && \\",
    "    rm -rf /var/lib/apt/lists/*",
  }
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(bufnr, row, row, false, lines)
  vim.api.nvim_win_set_cursor(0, { row + 3, 8 })
end, "APT [I]nstall pattern")

-- Build and run helpers (if docker is available)
if vim.fn.executable("docker") == 1 then
  map("<leader>db", function()
    -- Build current Dockerfile
    local dockerfile_dir = vim.fn.expand("%:p:h")
    local build_cmd = string.format("docker build -t temp-build %s", dockerfile_dir)
    vim.cmd("split | terminal " .. build_cmd)
  end, "[B]uild Dockerfile")
end
