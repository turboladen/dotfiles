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
require("crates").setup()

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<leader>ct", '<cmd>lua require("crates").toggle()<CR>', opts)
vim.api.nvim_set_keymap("n", "<leader>cr", '<cmd>lua require("crates").reload()<CR>', opts)
vim.api.nvim_set_keymap("n", "<leader>cv", '<cmd>lua require("crates").show_versions_popup()<CR>', opts)
vim.api.nvim_set_keymap("n", "<leader>cf", '<cmd>lua require("crates").show_features_popup()<CR>', opts)

vim.api.nvim_exec([[
augroup crates
autocmd FileType toml nnoremap <silent> K :lua require('crates').show_popup()<CR>
augroup END
]], false)
