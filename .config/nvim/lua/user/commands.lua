local function define_wasm_autocmds()
  -- vim -b : edit binary using xxd-format!
  local wasm_group = vim.api.nvim_create_augroup("WasmGroup", {})

  vim.api.nvim_create_autocmd({ 'BufReadPre' }, {
    pattern = "*.wasm",
    group = wasm_group,
    command = "let &bin=1"
  })

  vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
    pattern = "*.wasm",
    group = wasm_group,
    command = "if &bin | %!xxd"
  })
  vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
    pattern = "*.wasm",
    group = wasm_group,
    command = "set ft=xxd | endif"
  })

  vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = "*.wasm",
    group = wasm_group,
    command = "if &bin | %!xxd -r"
  })
  vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = "*.wasm",
    group = wasm_group,
    command = "endif"
  })

  vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    pattern = "*.wasm",
    group = wasm_group,
    command = "if &bin | %!xxd"
  })
  vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    pattern = "*.wasm",
    group = wasm_group,
    command = "set nomod | endif"
  })
end

define_wasm_autocmds()

local group = vim.api.nvim_create_augroup('user_ft', { clear = true })

vim.api.nvim_create_autocmd('BufEnter', {
  desc = "Lua-specific options",
  group = group,
  pattern = "*.lua",
  callback = function()
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  desc = "Ruby-specific options",
  group = group,
  pattern = "*.rb",
  callback = function()
    vim.opt_local.colorcolumn = "80,120"
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  desc = "Rust-specific options",
  group = group,
  pattern = "*.rs",
  callback = function()
    vim.opt_local.colorcolumn = "100"
  end,
})
