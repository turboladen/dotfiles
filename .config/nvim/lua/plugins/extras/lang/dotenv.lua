-- Dependencies to install:
-- dotenv-linter: brew install dotenv-linter

return {
  -- Add dotenv-linter conditionally for .env files
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}

      -- Create autocmd to conditionally add dotenv-
      -- Add dotenv-linter to sh filetype for .env files
      local existing_sh_linters = opts.linters_by_ft.sh or {}
      opts.linters_by_ft.sh = existing_sh_linters

      -- Create autocmd to conditionally add dotenv-linter for .env files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "sh",
        callback = function()
          local filename = vim.fn.expand("%:t")
          -- Check if this is a .env file
          if filename:match("^%.env") or filename:match("%.env$") or filename == ".env" then
            -- Add dotenv-linter to the buffer-local linters
            local lint = require("lint")
            local current_linters = lint.linters_by_ft.sh or {}
            local has_dotenv_linter = false
            for _, linter in ipairs(current_linters) do
              if linter == "dotenv_linter" then
                has_dotenv_linter = true
                break
              end
            end
            if not has_dotenv_linter then
              vim.list_extend(current_linters, { "dotenv_linter" })
              lint.linters_by_ft.sh = current_linters
            end
          end
        end,
      })

      opts.linters_by_ft.sh = opts.linters_by_ft.sh or {}
      table.insert(opts.linters_by_ft.sh, "dotenv_linter")
      return opts
    end,
  },
}
