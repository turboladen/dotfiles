return {
  -- Treesitter: parser management only (new API for Neovim 0.12+)
  -- highlight, indent, textobjects are no longer configured here
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0,
    init = function(plugin)
      -- Add nvim-treesitter queries to rtp early so other plugins (matchup, etc.)
      -- can find them before the plugin fully loads
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        "diff",
        "html",
        "printf",
        "query",
        "regex",
        "vim",
        "vimdoc",
        "xml",
      },
    },
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        local seen = {}
        local deduped = {}
        for _, parser in ipairs(opts.ensure_installed) do
          if not seen[parser] then
            seen[parser] = true
            table.insert(deduped, parser)
          end
        end
        opts.ensure_installed = deduped
      end
      require("nvim-treesitter").setup(opts)
      -- Enable treesitter highlighting and indent per buffer
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(ev)
          if pcall(vim.treesitter.start, ev.buf) then
            vim.bo[ev.buf].indentexpr = 'v:lua.require("nvim-treesitter").indentexpr()'
          end
        end,
      })
    end,
  },

  -- Textobject selection: replaces nvim-treesitter-textobjects (frozen/incompatible with new API)
  -- Keymaps: af/if=function, ac/ic=class, aa/ia=parameter, al/il=loop, ai/ii=conditional, ak=comment
  -- NOTE: move mappings (]m, [m, etc.) are not replicated here
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    config = function()
      local ai = require("mini.ai")
      ai.setup({
        n_lines = 500,
        custom_textobjects = {
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
          l = ai.gen_spec.treesitter({ a = "@loop.outer", i = "@loop.inner" }),
          i = ai.gen_spec.treesitter({ a = "@conditional.outer", i = "@conditional.inner" }),
          k = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.outer" }),
          a = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),
        },
      })
    end,
  },

  -- Enhanced % matching for blocks like do/end, if/end, etc.
  {
    "andymass/vim-matchup",
    event = { "BufReadPost" },
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_hi_surround_always = 1
      vim.g.loaded_matchit = 1
    end,
  },
}
