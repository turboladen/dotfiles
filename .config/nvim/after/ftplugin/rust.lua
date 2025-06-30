-- Rust-specific keymaps for rustaceanvim
-- This file is sourced after rustaceanvim initializes

local bufnr = vim.api.nvim_get_current_buf()

-- Rust-specific LSP keymaps
local map = function(keys, func, desc)
  vim.keymap.set("n", keys, func, { silent = true, buffer = bufnr, desc = "Rust: " .. desc })
end

-- Override default hover with rust-analyzer's hover actions
map("K", function()
  vim.cmd.RustLsp({ "hover", "actions" })
end, "Hover Actions")

-- Rust-specific actions
map("<leader>ra", function()
  vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
end, "Code [A]ctions")

map("<leader>rr", function()
  vim.cmd.RustLsp("runnables")
end, "[R]unnables")

map("<leader>rt", function()
  vim.cmd.RustLsp("testables")
end, "[T]estables")

map("<leader>rd", function()
  vim.cmd.RustLsp("debuggables")
end, "[D]ebuggables")

map("<leader>rm", function()
  vim.cmd.RustLsp("expandMacro")
end, "Expand [M]acro")

map("<leader>rc", function()
  vim.cmd.RustLsp("openCargo")
end, "Open [C]argo.toml")

map("<leader>rp", function()
  vim.cmd.RustLsp("parentModule")
end, "[P]arent Module")

map("<leader>rj", function()
  vim.cmd.RustLsp("joinLines")
end, "[J]oin Lines")

map("<leader>rs", function()
  vim.cmd.RustLsp("ssr")
end, "[S]tructural Search Replace")
