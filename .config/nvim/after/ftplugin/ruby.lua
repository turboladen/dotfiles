-- Ruby-specific settings
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true

-- Highlight debugging statements as errors to make them obvious
vim.cmd([[
  augroup highlight_ruby_debug
    autocmd! * <buffer>
    autocmd BufEnter <buffer> syn match error contained "\<binding\.pry\>"
    autocmd BufEnter <buffer> syn match error contained "\<debugger\>"
    autocmd BufEnter <buffer> syn match error contained "\<byebug\>"
  augroup END
]])
