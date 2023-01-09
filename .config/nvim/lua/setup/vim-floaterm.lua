local already_opened = false

function CustomOpenFloaterm()
  if already_opened then
    vim.cmd("FloatermToggle myfloat")
  else
    already_opened = true
    vim.cmd("FloatermNew --wintype=split --height=20 --position=botright --autoclose=2 --name=myfloat zsh")
  end

end

vim.keymap.set("n", "t", "<cmd>lua CustomOpenFloaterm()<CR>")
vim.keymap.set("t", "<C-h>", "<C-\\><C-n>:q<CR>")
