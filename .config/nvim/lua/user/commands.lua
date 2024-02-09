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

local M = {}

M.crates = function()
  local crates_group = vim.api.nvim_create_augroup("crates", {})

  vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = "toml",
    group = crates_group,
    command = "nnoremap <silent> K :lua require('crates').show_popup()<CR>"
  })

  vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    pattern = 'Cargo.toml',
    group = crates_group,
    callback = require("user.keymaps").crates
  })
end

M.lint = function()
  vim.api.nvim_create_autocmd({ "BufReadPre", "BufWritePost" }, {
    group = vim.api.nvim_create_augroup('user_lint', { clear = true }),
    callback = function()
      require("lint").try_lint()
    end,
  })
end

M.lspconfig = function()
  local group = vim.api.nvim_create_augroup('lsp_cmds', { clear = true })

  vim.api.nvim_create_autocmd('LspAttach', {
    group = group,
    desc = 'LSP actions',
    callback = function(_, bufnr)
      require("user.keymaps").lspconfig(bufnr)

      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('lsp_format', { clear = true }),
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end
      })

      -- ╭───────────────────────────────────╮
      -- │ Disabling while trying out noice. │
      -- ╰───────────────────────────────────╯
      -- require("fidget").setup({})
    end
  })

  -- ╭────────────────────────────────────────────╮
  -- │ Disabling while trying out lsp_lines.nvim. │
  -- ╰────────────────────────────────────────────╯
  -- vim.api.nvim_create_autocmd('CursorHold', {
  --   group = group,
  --   callback = function()
  --     vim.diagnostic.open_float(nil, { focusable = false })
  --   end
  -- })
end

M.mini = function()
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup('user_mini-nvim_setup', { clear = true }),
    pattern = {
      "Trouble",
      "help",
      "lazy",
      "lazyterm",
      "mason",
      "notify",
      "ruby",
      "rust",
    },
    callback = function()
      vim.b.miniindentscope_disable = true
    end,
  })
end

-- ╭───────────────────────────────────────────╮
-- │ To be called in `Wansmer/treesj` config() │
-- ╰───────────────────────────────────────────╯
M.treesj = function()
  local langs = require('treesj.langs')['presets']

  vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = vim.api.nvim_create_augroup('user_treesj_keymaps', { clear = true }),
    pattern = '*',
    callback = function()
      require("user.keymaps").treesj(langs)
    end
  })
end

return M
