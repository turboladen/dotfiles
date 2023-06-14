-- ╭─────────────────────────────────────────────────────╮
-- │ Find, Filter, Preview, Pick. All lua, all the time. │
-- ╰─────────────────────────────────────────────────────╯
-- Setup nvim config file finder
local nvim_config_files = function()
  require("telescope.builtin").find_files({
    cwd = "~/.config/nvim",
    prompt_title = "Find neovim config files"
  })
end

-- Function for defining a telescope picker over all the files that I manage using yadm.io.
local yadm_files = function()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values

  local opts = {
    theme = "dropdown",
    previewer = false,
    layout_config = {
      height = 20,
      width = 80,
    },
  }
  local files_string = vim.fn.system("yadm list -a")
  local files = vim.split(files_string, "\n")

  pickers.new(opts, {
    prompt_title = "YADM Config Files",
    finder = finders.new_table({
      results = files,
      entry_maker = function(entry)
        -- meow
        return {
          value = "~/" .. entry,
          display = entry,
          ordinal = entry,
        }
      end,
    }),
    previewer = conf.file_previewer(opts),
    sorter = conf.file_sorter(opts),
  }):find()
end


return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    -- lazy = false,
    dependencies = {
      "yamatsum/nvim-nonicons",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = function()
      local icons = require("nvim-nonicons")

      return {
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = require("telescope.actions").close,
            },
          },
          prompt_prefix = "  " .. icons.get("telescope") .. "  ",
          selection_caret = " ❯ ",
          entry_prefix = "   ",
        },
        pickers = {
          buffers = {
            theme = "cursor",
            previewer = false,
          },
          find_files = {
            theme = "dropdown",
            previewer = false,
          },
          lsp_code_actions = {
            theme = "cursor",
            layout_config = { height = 15 },
          },
          oldfiles = {
            theme = "dropdown",
          },
        },
      }
    end,
    keys = {
      -- { "<leader><space>", desc = "Fuzzy find" },
      -- { "<leader><CR>",    desc = "Fuzzy find open buffers" },
      { "<leader>fn", nvim_config_files, {
        desc =
        "Show files in ~/.config/nvim/"
      } },
      { "<leader>fy", yadm_files,                                              { desc = "Show YADM files" } },
      { "<leader>fa", "<cmd>Telescope telescope-alternate alternate_file<CR>", { desc = "Show alternate file" } },
      { "<leader>fs", "<cmd>Telescope aerial<CR>",                             { desc = "Show symbols via aerial" } },
    }
  },

  -- ╭───────────────────────────────────────────────────────────────────────╮
  -- │ Alternate between common files using pre-defined regexp. Just map the │
  -- │ patterns and starting navigating between files that are related.      │
  -- ╰───────────────────────────────────────────────────────────────────────╯
  {
    "otavioschwanck/telescope-alternate",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {
      mappings = {
        { "app/(.*)/(.*).js", {
          { "app/[1]/adapter.js",                                       "Adapter" },
          { "app/[1]/controller.js",                                    "Controller" },
          { "app/[1]/model.js",                                         "Model" },
          { "app/[1]/route.js",                                         "Route" },
          { "app/[1]/service.js",                                       "Service" },
          { "app/[1]/template.hbs",                                     "Template" },
          { "app/[1]/view.js",                                          "View" },
          { "../backend/app/assets/javascripts/pods/[1]/adapter.js",    "Old Adapter" },
          { "../backend/app/assets/javascripts/pods/[1]/controller.js", "Old Controller" },
          { "../backend/app/assets/javascripts/pods/[1]/model.js",      "Old Model" },
          { "../backend/app/assets/javascripts/pods/[1]/route.js",      "Old Route" },
          { "../backend/app/assets/javascripts/pods/[1]/view.js",       "Old View" },
          { "tests/[1]/controller-test.js",                             "Controller Tests" },
          { "tests/[1]/route-test.js",                                  "Route Tests" },
          { "tests/[1]/model-test.js",                                  "Model Tests" },
          { "tests/[1]/service-test.js",                                "Service Tests" },
          { "tests/[1]/view-test.js",                                   "View Tests" },
        } }
      },
      presets = { "rails", "rspec" }
    },
    config = function(_, opts)
      local telescope = require("telescope")
      require("telescope-alternate").setup(opts)

      telescope.load_extension("telescope-alternate")
    end
  },

  --  ╭────────────────────────────────────╮
  --  │ 💥 Create key bindings that stick. │
  --  ╰────────────────────────────────────╯
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    -- init = function()
    --   vim.o.timeout = true
    --   vim.o.timeoutlen = 300
    -- end,
    opts = {
      plugins = { spelling = true },
      defaults = {
        ["g"] = { name = "+goto" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>t"] = { name = "+test" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      }
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end
  },

  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "✚" },
        change = { text = "▎" },
        delete = { text = "✖" },
        changedelete = { text = "⇄" },
      },
      current_line_blame = true,
      yadm = { enable = true },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function get_next_hunk()
          if vim.wo.diff then return ']c' end
          -- vim.schedule(function() require("gitsigns").next_hunk() end)
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end

        local function get_prev_hunk()
          if vim.wo.diff then return '[c' end
          -- vim.schedule(function() require("gitsigns").prev_hunk() end)
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end

        local function toggle_blame()
          -- require("gitsigns").toggle_current_line_blame()
          gs.toggle_current_line_blame({ full = true })
        end

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        -- Actions
        map("n", "]c", get_next_hunk, "Next hunk")
        map("n", "[c", get_prev_hunk, "Previous hunk")
        map("n", "<leader>ghb", toggle_blame, "Toggle git blame line")
      end,
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end
  },


  -- ╭──────────────────────────────────────────────────────────────────────╮
  -- │ 🚦 A pretty diagnostics, references, telescope results, quickfix and │
  -- │ location list to help you solve all the trouble your code is causing.│
  -- ╰──────────────────────────────────────────────────────────────────────╯
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble", "TroubleRefresh", "TroubleToggle" },
    opts = {
      -- auto_preview = false,
      auto_close = true,
      use_diagnostic_signs = true
    },
    config = function(_, opts)
      require("trouble").setup(opts)
    end
  },


  -- ╭──────────────────────────────────────────────────────────────────────────╮
  -- │ Highlight and search for todo comments like TODO, HACK, BUG in your      │
  -- │ code base.                                                               │
  -- ╰──────────────────────────────────────────────────────────────────────────╯
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
    -- config = function(_, opts)
    --   vim.keymap.set("n", "]t", require("todo-comments").jump_next, { desc = "Next todo comment" })
    --   vim.keymap.set("n", "[t", require("todo-comments").jump_prev, { desc = "Previous todo comment" })
    -- end,
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
    },
  }
}
