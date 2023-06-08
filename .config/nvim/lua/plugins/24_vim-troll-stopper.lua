-- ╭──────────────────────────────────────────╮
-- │ Protect against weird unicode copy/paste │
-- ╰──────────────────────────────────────────╯
return {
  "vim-utils/vim-troll-stopper",
  init = function()
    vim.cmd([[highlight TrollStopper ctermbg = red guibg = #FF0000 ]])
  end
}
