return {
  {
    "turboladen/init.rs",
    dev = true,
    config = function()
      vim.o.completefunc = "v:lua.require'init_rs'.regex_buffer_completer"
    end
  },
}
