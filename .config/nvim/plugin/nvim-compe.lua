-- nvim-compe

-- local compe = require('compe')

-- compe.setup({
--   source = {
--     nvim_lsp = {priority = 9},
--     vsnip = {priority = 8},
--     buffer = {priority = 7},
--     path = {priority = 6},
--     spell = {priority = 5},
--     calc = {priority = 4},
--     emoji = {priority = 3},

--     nvim_lua = true,
--     treesitter = false,
--     ultisnips = false,
--   },
-- })

-- -- https://github.com/andersevenrud/dotfiles/blob/master/.config/nvim/lua/shims.lua
-- -- add basic snippet support when language server does not
-- -- replaces: https://github.com/windwp/nvim-autopairs#using-nvim-compe
-- -- ref: https://github.com/hrsh7th/nvim-compe/issues/302
-- local helper = require'compe.helper'

-- helper.convert_lsp_orig = helper.convert_lsp

-- helper.convert_lsp = function(args)
--   local response = args.response or {}
--   local items = response.items or response

--   for _, item in ipairs(items) do
--     if item.inserttext == nil and (item.kind == 2 or item.kind == 3 or item.kind == 4) then
--       item.inserttext = item.label .. '(${1})'
--       item.inserttextformat = 2
--     end
--   end

--   return helper.convert_lsp_orig(args)
-- end
