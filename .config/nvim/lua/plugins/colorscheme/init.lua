return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      options = {
        dim_inactive = true,
        colorblind = {
          enable = true,
        },
        styles = {
          comments = "italic",
          keywords = "italic",
          types = "italic,bold",
        },
      },
    },
    config = function(_, opts)
      require("nightfox").setup(opts)
    end,
  },
}
