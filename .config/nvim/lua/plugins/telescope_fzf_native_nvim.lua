local Plugin = { 'nvim-telescope/telescope-fzf-native.nvim' }

Plugin.build =
'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'

Plugin.extension_config = function()
  return {
    fuzzy = true,                       -- false will only do exact matching
    override_generic_sorter = true,     -- override the generic sorter
    override_file_sorter = true,        -- override the file sorter
    case_mode = "smart_case",           -- or "ignore_case" or "respect_case"
    -- the default case_mode is "smart_case"
  }
end

return Plugin
