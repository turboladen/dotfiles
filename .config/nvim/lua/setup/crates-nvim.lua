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
local crates = require("crates")

crates.setup()

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>ct", crates.toggle, opts)
vim.keymap.set("n", "<leader>cr", crates.reload, opts)
vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, opts)
vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts)

vim.api.nvim_exec([[
  augroup crates
  autocmd FileType toml nnoremap <silent> K :lua require('crates').show_popup()<CR>
  augroup END
]],
  false)
