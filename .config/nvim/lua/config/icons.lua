-- Shared icons and symbols used across multiple plugins
-- This ensures consistency in visual elements throughout the configuration

local M = {}

-- Diagnostic symbols used in LSP, lualine, and other diagnostic displays
M.diagnostics = {
  error = "󰅙",
  warn = "󰀪",
  info = "󰋼",
  hint = "󰌵",
}

-- Git diff symbols for lualine, gitsigns, and other git-related plugins
M.git = {
  added = "󰐕",
  modified = "󰝤",
  removed = "󰍵",
  branch = "󰘬",
  unstaged = "󰄱",
  staged = "󰱒",
  unmerged = "󰘬",
  renamed = "󰁕",
  untracked = "󰋖",
  deleted = "󰍵",
  ignored = "󰈈",
}

-- File type and status symbols
M.files = {
  modified = "●",
  readonly = "󰌾",
  unnamed = "[No Name]",
  newfile = "[New]",
  folder = "󰉋",
  file = "󰈙",
  symlink = "󰌷",
}

-- UI symbols for various interface elements
M.ui = {
  separator = "│",
  close = "󰅖",
  search = "󰍉",
  settings = "󰒓",
  arrow_right = "󰅂",
  arrow_left = "󰅁",
  arrow_up = "󰅄",
  arrow_down = "󰅃",
  check = "󰄬",
  cross = "󰅘",
  loading = "󰔟",
}

-- LSP and language server symbols
M.lsp = {
  server_ready = "󰄳",
  server_loading = "󰔟",
  server_error = "󰅙",
  code_action = "󰌵",
  lightbulb = "󰌵",
}

-- Debug and testing symbols
M.debug = {
  breakpoint = "󰏃",
  breakpoint_conditional = "󰟃",
  breakpoint_rejected = "󰏃",
  log_point = "󰰍",
  stopped = "󰏤",
}

M.test = {
  passed = "󰄬",
  failed = "󰅘",
  running = "󰔟",
  skipped = "󰍷",
}

return M
