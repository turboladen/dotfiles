return {
  -- ╭───────────────────────────╮
  -- │ Ruby on Rails power tools │
  -- ╰───────────────────────────╯
  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby", "rspec" },
  },
  -- ╭───────────────────────────────────────╮
  -- │ It's like rails.vim without the rails │
  -- ╰───────────────────────────────────────╯
  {
    "tpope/vim-rake",
    ft = { "ruby", "eruby", "rspec" },
    dependencies = {
      "tpope/vim-projectionist",
    },
  },

  -- ╭─────╮
  -- │ RBS │
  -- ╰─────╯
  -- use '~/Development/projects/vim-rbs'
  {
    "turboladen/vim-rbs",
    ft = { "ruby", "rbs", "ruby.rbs", "rspec" }
  },
}
