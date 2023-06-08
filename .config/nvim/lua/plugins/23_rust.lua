-- ╭────────────────────────────────────────────────────────────╮
-- │ A neovim plugin that helps managing crates.io dependencies │
-- ╰────────────────────────────────────────────────────────────╯
-- nnoremap <silent> <leader>ct :lua require('crates').toggle()<cr>
-- nnoremap <silent> <leader>cr :lua require('crates').reload()<cr>

-- nnoremap <silent> <leader>cv :lua require('crates').show_versions_popup()<cr>
-- nnoremap <silent> <leader>cf :lua require('crates').show_features_popup()<cr>

-- nnoremap <silent> <leader>cu :lua require('crates').update_crate()<cr>
-- vnoremap <silent> <leader>cu :lua require('crates').update_crates()<cr>
-- nnoremap <silent> <leader>ca :lua require('crates').update_all_crates()<cr>
-- nnoremap <silent> <leader>cU :lua require('crates').upgrade_crate()<cr>
-- vnoremap <silent> <leader>cU :lua require('crates').upgrade_crates()<cr>
-- nnoremap <silent> <leader>cA :lua require('crates').upgrade_all_crates()<cr>

return {
  "saecki/crates.nvim",
  -- version = "v0.3.0",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufRead Cargo.toml" },
  init = function()
    local crates_group = vim.api.nvim_create_augroup("crates", {})

    vim.api.nvim_create_autocmd({ 'FileType' }, {
      pattern = "toml",
      group = crates_group,
      command = "nnoremap <silent> K :lua require('crates').show_popup()<CR>"
    })
  end,
  config = function()
    local crates = require("crates")
    crates.setup()

    vim.keymap.set("n", "<leader>ct", crates.toggle, { desc = "Enable/disable crate info" })
    vim.keymap.set("n", "<leader>cr", crates.reload, { desc = "Reload (clear cache)" })
    vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, { desc = "Show crate details w/version info" })
    vim.keymap.set("n", "<leader>cf", crates.show_features_popup, { desc = "Show crate details w/feature info" })
  end,
}
