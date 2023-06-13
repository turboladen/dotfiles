-- ╭──────────────────────────────────╮
-- │ Distraction-free writing in Vim. │
-- ╰──────────────────────────────────╯
return {
  "junegunn/goyo.vim",
  cmd = "Goyo",
  init = function()
    vim.g.goyo_width = 102
  end
}
