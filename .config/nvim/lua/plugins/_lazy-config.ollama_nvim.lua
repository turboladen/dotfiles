-- ╭────────────────────────────────────────────────────────────────────────╮
-- │ A plugin for managing and integrating your ollama workflows in neovim. │
-- ╰────────────────────────────────────────────────────────────────────────╯
local Plugin = { "nomnivore/ollama.nvim" }

Plugin.dependencies = {
  "nvim-lua/plenary.nvim"
}

Plugin.cmd = {
  "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop"
}

Plugin.opts = {
  model = "codellama",
}

Plugin.keys = {
  -- Sample keybind for prompt menu. Note that the <c-u> is important for selections to work properly.
  {
    "<leader>co",
    ":<c-u>lua require('ollama').prompt()<cr>",
    desc = "ollama prompt",
    mode = { "n", "v" },
  },

  -- Sample keybind for direct prompting. Note that the <c-u> is important for selections to work properly.
  {
    "<leader>cG",
    ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
    desc = "ollama Generate Code",
    mode = { "n", "v" },
  },
}

return Plugin
