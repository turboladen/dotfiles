local function set_keymaps()
  vim.keymap.set('n', 'gx', require("ofirgall/open").open_cword)
end

return {
  set_keymaps = set_keymaps
}
