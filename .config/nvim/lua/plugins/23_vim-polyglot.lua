-- ╭────────────────────────────────╮
-- │ A solid language pack for Vim. │
-- ╰────────────────────────────────╯
return {
  "sheerun/vim-polyglot",
  priority = 900,
  init = function()
    -- https://github.com/tbastos/vim-lua
    vim.g.lua_syntax_fancynotequal = 1

    vim.g.vim_markdown_folding_disabled = 1
    vim.g.vim_markdown_conceal = 0
    vim.g.vim_markdown_follow_anchor = 1
    vim.g.vim_markdown_new_list_item_indent = 2
    vim.g.vim_markdown_no_default_key_mappings = 1
    vim.g.vim_markdown_strikethrough = 1
  end
}
