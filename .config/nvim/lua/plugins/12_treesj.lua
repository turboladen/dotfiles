-- ╭────────────────────────────────────────────────────╮
-- │ Neovim plugin for splitting/joining blocks of code │
-- ╰────────────────────────────────────────────────────╯
return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter' },
  opts = {
    use_default_keymaps = false,
  },
  config = function(_, opts)
    require('treesj').setup(opts)

    -- Fallback to splitjoin on unsupported language: https://github.com/Wansmer/treesj/discussions/19
    local langs = require('treesj.langs')['presets']

    vim.api.nvim_create_autocmd({ 'FileType' }, {
      pattern = '*',
      callback = function()
        local map_opts = { buffer = true }

        if langs[vim.bo.filetype] then
          vim.keymap.set('n', 'gS', '<Cmd>TSJSplit<CR>', map_opts)
          vim.keymap.set('n', 'gJ', '<Cmd>TSJJoin<CR>', map_opts)
        else
          vim.keymap.set('n', 'gS', '<Cmd>SplitjoinSplit<CR>', map_opts)
          vim.keymap.set('n', 'gJ', '<Cmd>SplitjoinJoin<CR>', map_opts)
        end
      end,
    })
  end
}
