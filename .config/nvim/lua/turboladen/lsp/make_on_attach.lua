local make_on_attach = {}

local opts = { noremap = true, silent = true }

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
function make_on_attach._base(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua require('turboladen/lsp').hover()<CR>", opts)

  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)

  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[g", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]g", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>so",
    [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr,
    "n",
    "<leader>sw",
    [[<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>]],
    opts
  )

  -- if server_name == "solargraph" then
  -- client.resolved_capabilities.document_formatting = false
  -- client.resolved_capabilities.document_range_formatting = false
  -- end

  vim.cmd([[
  augroup lsp_formatting
  autocmd BufWritePre * lua vim.lsp.buf.format()
  augroup END
  ]])

  require("fidget").setup({})
end

function make_on_attach.with_formatting(client, bufnr)
  make_on_attach._base(client, bufnr)

  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ff", "<cmd>lua vim.lsp.buf.format({ async = false })<CR>", opts)
end

function make_on_attach.for_rust(client, bufnr)
  make_on_attach.with_formatting(client, bufnr)

  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua require('rust-tools').hover_actions.hover_actions()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>cg",
    "<cmd>lua require('rust-tools').code_action_group.code_action_group()<CR>", opts)

  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ff", "<cmd>RustFmt<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gJ", "<cmd>RustJoinLines<CR>", opts)
  --     vim.api.nvim_buf_set_keymap("n", "<leader>ca", "<cmd>RustCodeAction<CR>", opts)
  --     vim.api.nvim_buf_set_keymap("v", "<leader>ca", "<cmd>RustCodeAction<CR>", opts)
end

function make_on_attach.for_any(client, bufnr)
  make_on_attach._base(client, bufnr)
end

return make_on_attach
