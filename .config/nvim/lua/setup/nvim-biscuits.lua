-- local icon = ""
-- local icon = ""
local icon = "✨"

require("nvim-biscuits").setup({
  toggle_keybind = "<leader>cb",
  show_on_start = true,
  cursor_line_only = true,
  default_config = {
    max_distance = 25,
    prefix_string = " " .. icon .. " ",
  },
})
