--  ╭────────────────────────────────────────────────────────────╮
--  │ A neovim plugin that helps managing crates.io dependencies │
--  ╰────────────────────────────────────────────────────────────╯
local Plugin = { "saecki/crates.nvim" }

Plugin.tag = "v0.4.0"
Plugin.dependencies = { "nvim-lua/plenary.nvim" }
Plugin.event = { "BufRead Cargo.toml" }
Plugin.lazy = true
Plugin.init = function()
  local crates_group = vim.api.nvim_create_augroup("crates", {})

  vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = "toml",
    group = crates_group,
    command = "nnoremap <silent> K :lua require('crates').show_popup()<CR>"
  })

  vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    pattern = 'Cargo.toml',
    group = crates_group,
    callback = function(ev)
      local function opts(desc)
        return {
          buffer = ev.buf,
          desc = desc
        }
      end
      local crates = require("crates")

      -- vim.keymap.set('n', '<leader>ct', "<cmd>lua require('crates').toggle<cr>", opts("crates: enable/disable info"))
      vim.keymap.set('n', '<leader>ct', crates.toggle, opts("crates: enable/disable info"))
      vim.keymap.set('n', '<leader>cu', crates.upgrade_crate, opts("crates: update current"))
      vim.keymap.set('n', '<leader>cl', crates.upgrade_all_crates, opts("crates: update all"))
      vim.keymap.set("n", "<leader>cr", crates.reload, opts("crates: reload cache"))
      vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, opts("crates: details w/version info"))
      vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts("crates: details w/feature info"))
    end
  })
end

Plugin.config = function()
  require("crates").setup()
end

return Plugin
