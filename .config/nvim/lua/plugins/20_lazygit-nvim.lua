-- ╭────────────────────────────────────────────────╮
-- │ Plugin for calling lazygit from within neovim. │
-- ╰────────────────────────────────────────────────╯
return {
  "kdheepak/lazygit.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "LazyGit" }
}
