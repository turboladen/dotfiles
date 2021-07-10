--------------
-- rust tools
--------------
local opts = {
  server = {
    assist = {
      importPrefix = "self"
    },
    cargo = {
      allFeatures = true
    },
    completion = {
      autoimport = {
        enable = true
      }
    },
    checkOnSave = {
      allFeatures = true
    },
    inlayHints = {
      enable = true,
      typeHints = true,
    },
    lens = {
      methodReferences = true
    },
    lruCapacity = 4096,
  }
}

require('rust-tools').setup(opts)
