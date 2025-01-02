-- ╭──────────────────────────────────────────────────────────────────────╮
-- │  This plugin is a replacement for the included filetype.vim that is  │
-- │  sourced on startup.                                                 │
-- ╰──────────────────────────────────────────────────────────────────────╯
--  "nathom/filetype.nvim",
require("filetype").setup({
  overrides = {
    extensions = {
      -- Set the filetype of *.pn files to potion
      jbuilder = "ruby"
    },
    complex = {
      ["*.rs.hbs"] = "rust.handlebars", -- Included in the plugin
    },
  },
})

-- ╭────────────────────────────────╮
-- │ A solid language pack for Vim. │
-- ╰────────────────────────────────╯
-- "sheerun/vim-polyglot",
-- https://github.com/tbastos/vim-lua
vim.g.lua_syntax_fancynotequal = 1

vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_conceal = 0
vim.g.vim_markdown_follow_anchor = 1
vim.g.vim_markdown_new_list_item_indent = 2
vim.g.vim_markdown_no_default_key_mappings = 1
vim.g.vim_markdown_strikethrough = 1

-- ╭────────────────────────╮
-- │ "rhysd/committia.vim", │
-- ╰────────────────────────╯
vim.g.committia_hooks = {}

vim.g.committia_hooks.edit_open = function(info)
  vim.opt_local.spell = true
  vim.opt_local.spelllang = "en_us"

  -- If no commit message, start with insert mode
  if info.vcs == "git" and vim.fn.getline(1) == "" then
    vim.fn.startinsert()
  end
end
