local null_ls = require("null-ls")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.cmake_format, -- pip3 install cmakelang
        null_ls.builtins.formatting.nixfmt,
        null_ls.builtins.formatting.prettier, -- npm install -g prettier
        null_ls.builtins.formatting.rubocop,
        null_ls.builtins.formatting.shellharden,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.stylua, -- cargo install stylua
        null_ls.builtins.formatting.taplo, -- cargo install taplo-cli
        null_ls.builtins.formatting.terraform_fmt,
        null_ls.builtins.formatting.trim_whitespace,
        ---------------
        -- diagnostics
        ---------------
        null_ls.builtins.diagnostics.cppcheck,
        null_ls.builtins.diagnostics.hadolint,
        -- null_ls.builtins.diagnostics.luacheck, -- luarocks install luacheck
        null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.diagnostics.rubocop,
        null_ls.builtins.diagnostics.selene,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.diagnostics.statix,
        null_ls.builtins.diagnostics.vale,
        null_ls.builtins.diagnostics.vint,
        null_ls.builtins.diagnostics.yamllint,
        ---------------
        -- code actions
        ---------------
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.code_actions.proselint,
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.code_actions.statix,
        ---------------
        -- hover
        ---------------
        null_ls.builtins.hover.dictionary,
        ---------------
        -- completion
        ---------------
        null_ls.builtins.completion.spell,
    },
    should_attach = function(buffer_num)
        -- Skipping on rust so nvim doesn't ask me every time I save which LSP I want to use.
        local ft = vim.api.nvim_buf_get_option(buffer_num, "filetype")
        return not (ft:match("rust") or ft:match("cpp"))
    end,
})
