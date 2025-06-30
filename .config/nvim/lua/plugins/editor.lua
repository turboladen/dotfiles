return {
  -- Edit directories like buffers
  {
    "elihunter173/dirbuf.nvim",
    opts = {},
  },

  -- Unix shell commands for file operations
  {
    "tpope/vim-eunuch",
    event = { "BufReadPre", "BufNewFile" },
    cmd = {
      "Delete",
      "Unlink",
      "Move",
      "Rename",
      "Chmod",
      "Mkdir",
      "Cfind",
      "Clocate",
      "Lfind",
      "Wall",
      "SudoWrite",
      "SudoEdit",
    },
  },

  -- Fast fuzzy finder
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    keys = {
      { "<leader><leader>", "<cmd>FzfLua files<cr>", desc = "Find: Files" },
      { "<leader><cr>", "<cmd>FzfLua buffers<cr>", desc = "Find: Buffers" },
      {
        "<leader>fn",
        function()
          require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "Find: Neovim config",
      },
      { "<leader>fg", "<cmd>FzfLua git_status<cr>", desc = "Find: Git status" },
      { "<leader>fk", "<cmd>FzfLua grep_cword<cr>", desc = "Find: Grep word" },
      { "<leader>fm", "<cmd>FzfLua marks<cr>", desc = "Find: Marks" },
      { "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "Find: Recent files" },
      { "<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Find: Live grep" },
      { "<leader>ss", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "Find: LSP symbols" },
    },
    opts = {
      winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.50,
        preview = {
          scrollbar = "float",
        },
      },
      keymap = {
        builtin = {
          ["<F1>"] = "toggle-help",
          ["<F2>"] = "toggle-fullscreen",
          ["<F3>"] = "toggle-preview-wrap",
          ["<F4>"] = "toggle-preview",
          ["<C-d>"] = "preview-page-down",
          ["<C-u>"] = "preview-page-up",
        },
        fzf = {
          ["ctrl-z"] = "abort",
          ["ctrl-u"] = "unix-line-discard",
          ["ctrl-f"] = "half-page-down",
          ["ctrl-b"] = "half-page-up",
          ["ctrl-a"] = "beginning-of-line",
          ["ctrl-e"] = "end-of-line",
          ["ctrl-j"] = "down",
          ["ctrl-k"] = "up",
          ["alt-a"] = "toggle-all",
          ["f3"] = "toggle-preview-wrap",
          ["f4"] = "toggle-preview",
          ["shift-down"] = "preview-page-down",
          ["shift-up"] = "preview-page-up",
        },
      },
      previewers = {
        bat = {
          cmd = "bat",
          args = "--style=numbers,changes --color always",
          theme = "Coldark-Dark",
        },
      },
      files = {
        prompt = "Files❯ ",
        multiprocess = true,
        git_icons = true,
        file_icons = true,
        color_icons = true,
      },
      grep = {
        prompt = "Rg❯ ",
        input_prompt = "Grep For❯ ",
        multiprocess = true,
        git_icons = true,
        file_icons = true,
        color_icons = true,
      },
      buffers = {
        prompt = "Buffers❯ ",
        file_icons = true,
        color_icons = true,
        sort_lastused = true,
      },
      lsp = {
        prompt_postfix = "❯ ",
        cwd_only = true,
      },
    },
  },

  -- Git signs and hunks
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
        ignore_whitespace = false,
      },
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      max_file_length = 40000,
      preview_config = {
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Git: Next hunk" })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Git: Previous hunk" })

        -- Actions
        map("n", "<leader>ghs", gs.stage_hunk, { desc = "Git: Stage hunk" })
        map("n", "<leader>ghr", gs.reset_hunk, { desc = "Git: Reset hunk" })
        map("v", "<leader>ghs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Git: Stage hunk" })
        map("v", "<leader>ghr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Git: Reset hunk" })
        map("n", "<leader>ghS", gs.stage_buffer, { desc = "Git: Stage buffer" })
        map("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Git: Undo stage" })
        map("n", "<leader>ghR", gs.reset_buffer, { desc = "Git: Reset buffer" })
        map("n", "<leader>ghp", gs.preview_hunk_inline, { desc = "Git: Preview hunk" })
        map("n", "<leader>ghb", function()
          gs.blame_line({ full = true })
        end, { desc = "Git: Blame line" })
        map("n", "<leader>ghB", function()
          gs.blame()
        end, { desc = "Git: Blame buffer" })
        map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Git: Toggle blame" })
        map("n", "<leader>ghd", gs.diffthis, { desc = "Git: Diff this" })
        map("n", "<leader>ghD", function()
          gs.diffthis("~")
        end, { desc = "Git: Diff this ~" })
        map("n", "<leader>td", gs.toggle_deleted, { desc = "Git: Toggle deleted" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Git: Select hunk" })
      end,
    },
  },

  -- Manipulate surroundings (quotes, brackets, tags, etc.)
  {
    "tpope/vim-surround",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- Exchange two text regions
  {
    "tommcdo/vim-exchange",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- Ripgrep integration
  {
    "jremmen/vim-ripgrep",
    cmd = "Rg",
    keys = {
      { "<leader>.", ":Rg<space>", desc = "Rg: Search" },
    },
  },

  -- Find and list TODO, HACK, BUG, etc comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoQuickFix", "TodoTrouble" },
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "TODO: Next",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "TODO: Previous",
      },
      { "<leader>xt", "<CMD>TodoQuickFix<CR>", desc = "TODO: Quickfix" },
      {
        "<leader>xT",
        "<CMD>Trouble todo filter = {tag = {TODO,FIX,FIXME}}<CR>",
        desc = "TODO: Trouble",
      },
    },
    opts = {},
  },

  -- Create comment boxes and decorations
  {
    "LudoPinelli/comment-box.nvim",
    keys = {
      {
        "<leader>cb",
        function()
          require("comment-box").albox()
          vim.lsp.buf.format({ async = false })
        end,
        desc = "Code: Comment box",
        mode = { "n", "v" },
      },
      {
        "<leader>cB",
        function()
          require("comment-box").ccbox(3)
          vim.lsp.buf.format({ async = false })
        end,
        desc = "Code: Title box",
        mode = { "n", "v" },
      },
      {
        "<leader>cl",
        function()
          require("comment-box").line()
          vim.lsp.buf.format({ async = false })
        end,
        desc = "Code: Comment line",
        mode = { "n", "v" },
      },
      {
        "<leader>cc",
        function()
          require("comment-box").catalog()
        end,
        desc = "Code: Box catalog",
      },
    },
    opts = {},
  },

  -- Better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    keys = {
      { "<leader>xx", "<CMD>Trouble diagnostics toggle<CR>", desc = "Trouble: Diagnostics" },
      {
        "<leader>xX",
        "<CMD>Trouble diagnostics toggle filter.buf=0<CR>",
        desc = "Trouble: Buffer diag",
      },
      { "<leader>xs", "<CMD>Trouble symbols toggle focus=false<CR>", desc = "Trouble: Symbols" },
      {
        "<leader>xl",
        "<CMD>Trouble lsp_definitions toggle<CR>",
        desc = "Trouble: Definitions",
      },
      { "<leader>xL", "<CMD>Trouble loclist toggle<CR>", desc = "Trouble: Loclist" },
      { "<leader>xQ", "<CMD>Trouble quickfix toggle<CR>", desc = "Trouble: Quickfix" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Trouble: Previous",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Trouble: Next",
      },
    },
    opts = {
      modes = {
        lsp = {
          win = { position = "right" },
        },
      },
    },
  },

  -- Which-key for keymap management and discovery
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      spec = {
        {
          mode = { "n", "v" },
          -- Single char groups (vim conventions)
          { "g", group = "goto" },
          { "]", group = "next" },
          { "[", group = "prev" },

          -- Leader groups based on actual usage patterns
          { "<leader>b", group = "buffer" },
          { "<leader>c", group = "code/comments" },
          { "<leader>d", group = "dap/debug" },
          { "<leader>f", group = "file/find" },
          { "<leader>g", group = "git" },
          { "<leader>gh", group = "hunks" },
          { "<leader>l", group = "lsp/lint/lua" },
          { "<leader>m", group = "markdown" },
          { "<leader>p", group = "packages" },
          { "<leader>r", group = "rust/rails/ruby" },
          { "<leader>s", group = "search" },
          { "<leader>t", group = "test/toggle" },
          { "<leader>u", group = "ui" },
          { "<leader>w", group = "windows" },
          { "<leader>x", group = "diagnostics/quickfix" },
        },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Which: Buffer maps",
      },
    },
  },
}
