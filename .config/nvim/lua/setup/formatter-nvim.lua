-- require("turboladen/installers").npm_install("prettier")
-- require("turboladen/installers").npm_install("lua-fmt")

require("formatter").setup(
  {
    filetype = {
      markdown = {
        -- prettier for markdown
        function()
          return {
            exe = "prettier",
            args = {
              "--stdin-filepath",
              vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
              "--single-quote"
            },
            stdin = true
          }
        end
      },
      lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = { "--indent-count", 4, "--stdin" },
            stdin = true
          }
        end
      }
    }
  }
)

vim.cmd([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.lua FormatWrite
augroup END
]])
