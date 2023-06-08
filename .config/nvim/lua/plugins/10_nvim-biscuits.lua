-- ╭─────────────────────────────────────╮
-- │ A neovim port of Assorted Biscuits. │
-- ╰─────────────────────────────────────╯
local icon = ""
-- local icon = ""
-- local icon = "✨"

return {
  "code-biscuits/nvim-biscuits",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    toggle_keybind = "<leader>cb",
    show_on_start = true,
    cursor_line_only = true,
    default_config = {
      max_distance = 25,
      prefix_string = " " .. icon .. " ",
    }
  }
}
