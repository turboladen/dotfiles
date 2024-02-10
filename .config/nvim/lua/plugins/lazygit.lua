-- ╭────────────────────────────────────────────────╮
-- │ Plugin for calling lazygit from within neovim. │
-- ╰────────────────────────────────────────────────╯
local Plugin = { "kdheepak/lazygit.nvim" }

Plugin.dependencies = { "nvim-lua/plenary.nvim" }
Plugin.cmd = { "LazyGit", "LazyGitConfig" }

return Plugin
