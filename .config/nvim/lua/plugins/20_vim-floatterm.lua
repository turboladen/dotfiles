-- ╭──────────────────────────────────╮
-- │ 🌟 Terminal manager for (neo)vim │
-- ╰──────────────────────────────────╯
local already_opened = false

function CustomOpenFloaterm()
  if already_opened then
    vim.cmd("FloatermToggle myfloat")
  else
    already_opened = true
    vim.cmd("FloatermNew --wintype=split --height=20 --position=botright --autoclose=2 --name=myfloat zsh")
  end
end

return {
  "voldikss/vim-floaterm",
  keys = {
    { "<C-t>", CustomOpenFloaterm,  { desc = "Open a floating term" } },
    { "<C-h>", "<C-\\><C-n>:q<CR>", { mode = "t", desc = "Hide the floating term" } },
  }
}
