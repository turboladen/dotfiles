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

local neotest = require("neotest")

neotest.setup({
  adapters = {
    require('neotest-rspec'),
    require("neotest-rust")
  }
})

vim.keymap.set(
  "n",
  "<leader>tn",
  "<cmd>lua NeotestRunNearest()<CR>"
)
vim.keymap.set(
  "n",
  "<leader>tf",
  "<cmd>lua NeotestRunCurrentFile()<CR>"
)
vim.keymap.set(
  "n",
  "<leader>td",
  "<cmd>lua NeotestDebugNearest()<CR>"
)

vim.keymap.set("n", "<leader>tt", "<cmd>lua require('neotest').summary.toggle()<CR>")
vim.keymap.set("n", "<leader>to", "<cmd>lua require('neotest').output.open({ enter = true })<CR>")


vim.keymap.set("n", "[n", "<cmd>lua require('neotest').jump.prev({ status = 'failed' })<CR>", { silent = true })
vim.keymap.set("n", "]n", "<cmd>lua require('neotest').jump.next({ status = 'failed' })<CR>", { silent = true })
