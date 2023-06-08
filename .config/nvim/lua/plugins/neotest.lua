-- ╭───────────────────────────────────────────────────────────────────╮
-- │ An extensible framework for interacting with tests within NeoVim. │
-- ╰───────────────────────────────────────────────────────────────────╯
function NeotestRunNearest()
  local neotest = require('neotest')
  neotest.run.run()
  neotest.output.open({ enter = true })
  -- neotest.summary.open()
end

function NeotestDebugNearest()
  local neotest = require('neotest')
  neotest.run.run({ strategy = 'dap' })
  neotest.output.open({ enter = true })
  -- neotest.summary.open()
end

function NeotestRunCurrentFile()
  local neotest = require('neotest')
  neotest.run.run(vim.fn.expand('%'))
  neotest.output.open({ enter = true })
  -- neotest.summary.open()
end

return {
  "nvim-neotest/neotest",
  enabled = false,
  dependencies = {
    "antoinemadec/FixCursorHold.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "olimorris/neotest-rspec",
    "rouge8/neotest-rust"
  },
  opts = function()
    return {
      adapters = {
        require('neotest-rspec'),
        require("neotest-rust")
      }
    }
  end,
  config = function(_, opts)
    local neotest = require("neotest")
    neotest.setup(opts)

    vim.keymap.set("n", "<leader>tn", NeotestRunNearest)
    vim.keymap.set("n", "<leader>tf", NeotestRunCurrentFile)
    vim.keymap.set(
      "n",
      "<leader>td",
      NeotestDebugNearest
    )

    vim.keymap.set("n", "<leader>tt", require('neotest').summary.toggle)
    vim.keymap.set("n", "<leader>to", "<cmd>lua require('neotest').output.open({ enter = true })<CR>")


    vim.keymap.set("n", "[n", "<cmd>lua require('neotest').jump.prev({ status = 'failed' })<CR>", { silent = true })
    vim.keymap.set("n", "]n", "<cmd>lua require('neotest').jump.next({ status = 'failed' })<CR>", { silent = true })
  end
}
