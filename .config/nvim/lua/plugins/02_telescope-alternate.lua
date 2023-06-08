-- ╭───────────────────────────────────────────────────────────────────────╮
-- │ Alternate between common files using pre-defined regexp. Just map the │
-- │ patterns and starting navigating between files that are related.      │
-- ╰───────────────────────────────────────────────────────────────────────╯
return {
  "otavioschwanck/telescope-alternate",
  dependencies = { "nvim-telescope/telescope.nvim" },
  opts = {
    mappings = {
      { "app/(.*)/(.*).js", {
        { "app/[1]/adapter.js",                                       "Adapter" },
        { "app/[1]/controller.js",                                    "Controller" },
        { "app/[1]/model.js",                                         "Model" },
        { "app/[1]/route.js",                                         "Route" },
        { "app/[1]/service.js",                                       "Service" },
        { "app/[1]/template.hbs",                                     "Template" },
        { "app/[1]/view.js",                                          "View" },
        { "../backend/app/assets/javascripts/pods/[1]/adapter.js",    "Old Adapter" },
        { "../backend/app/assets/javascripts/pods/[1]/controller.js", "Old Controller" },
        { "../backend/app/assets/javascripts/pods/[1]/model.js",      "Old Model" },
        { "../backend/app/assets/javascripts/pods/[1]/route.js",      "Old Route" },
        { "../backend/app/assets/javascripts/pods/[1]/view.js",       "Old View" },
        { "tests/[1]/controller-test.js",                             "Controller Tests" },
        { "tests/[1]/route-test.js",                                  "Route Tests" },
        { "tests/[1]/model-test.js",                                  "Model Tests" },
        { "tests/[1]/service-test.js",                                "Service Tests" },
        { "tests/[1]/view-test.js",                                   "View Tests" },
      } }
    },
    presets = { "rails", "rspec" }
  },
  config = function(_, opts)
    local telescope = require("telescope")
    require("telescope-alternate").setup(opts)

    telescope.load_extension("telescope-alternate")
  end
}
