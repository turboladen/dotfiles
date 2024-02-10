-- ╭────────────────────────────────────╮
-- │ It sets vim.ui.select to telescope │
-- ╰────────────────────────────────────╯
local Plugin = { 'nvim-telescope/telescope-ui-select.nvim' }

Plugin.extension_config = function()
  return {
    require("telescope.themes").get_dropdown {
      -- even more opts
    }

    -- pseudo code / specification for writing custom displays, like the one
    -- for "codeactions"
    -- specific_opts = {
    --   [kind] = {
    --     make_indexed = function(items) -> indexed_items, width,
    --     make_displayer = function(widths) -> displayer
    --     make_display = function(displayer) -> function(e)
    --     make_ordinal = function(e) -> string
    --   },
    --   -- for example to disable the custom builtin "codeactions" display
    --      do the following
    --   codeactions = false,
    -- }
  }
end

return Plugin
