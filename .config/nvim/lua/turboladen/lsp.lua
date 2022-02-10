local function make_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
    capabilities = vim.tbl_extend("keep", capabilities, require("lsp-status").capabilities)

    return capabilities
end

local function hover()
    local filetype = vim.bo.filetype

    if vim.tbl_contains({ "vim", "help" }, filetype) then
        vim.cmd("h " .. vim.fn.expand("<cword>"))
    elseif vim.tbl_contains({ "man" }, filetype) then
        vim.cmd("Man " .. vim.fn.expand("<cword>"))
    else
        vim.lsp.buf.hover()
    end
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local function make_on_attach(server_name)
    return function(client, bufnr)
        local aerial = require("aerial")
        aerial.on_attach(client, bufnr)

        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end

        local function buf_set_option(...)
            vim.api.nvim_buf_set_option(bufnr, ...)
        end

        -- Enable completion triggered by <c-x><c-o>
        buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Mappings.
        local opts = { noremap = true, silent = true }

        -- Aerial does not set any mappings by default, so you'll want to set some up
        -- Toggle the aerial window with <leader>a
        buf_set_keymap("n", "<leader>aa", "<cmd>AerialToggle!<CR>", opts)

        -- Jump forwards/backwards with '{' and '}'
        buf_set_keymap("n", "{", "<cmd>AerialPrev<CR>", opts)
        buf_set_keymap("n", "}", "<cmd>AerialNext<CR>", opts)

        -- Jump up the tree with '[[' or ']]'
        buf_set_keymap("n", "[[", "<cmd>AerialPrevUp<CR>", opts)
        buf_set_keymap("n", "]]", "<cmd>AerialNextUp<CR>", opts)

        buf_set_keymap("n", "<leader>at", "<cmd>ArealTreeToggle<CR>", opts)
        buf_set_keymap("n", "<leader>ao", "<cmd>ArealTreeOpenAll<CR>", opts)

        -- See `:help vim.lsp.*` for documentation on any of the below functions
        buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

        if server_name == "rust_analyzer" then
            buf_set_keymap("n", "K", "<cmd>RustHoverActions<CR>", opts)
        else
            buf_set_keymap("n", "K", "<cmd>lua require('turobladen/lsp').hover()<CR>", opts)
        end

        buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        buf_set_keymap("n", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

        buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
        buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

        -- buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
        -- if server_name == "rust_analyzer" then
        --     buf_set_keymap("n", "<leader>ca", "<cmd>RustCodeAction<CR>", opts)
        --     buf_set_keymap("v", "<leader>ca", "<cmd>RustCodeAction<CR>", opts)
        -- else
        buf_set_keymap("n", "<leader>ca", "<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>", opts)
        buf_set_keymap("v", "<leader>ca", "<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>", opts)
        -- end
        buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        -- buf_set_keymap("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", opts)
        buf_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
        buf_set_keymap("n", "[g", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
        buf_set_keymap("n", "]g", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
        buf_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
        -- buf_set_keymap("n", "<leader>ff", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
        if server_name == "rust_analyzer" then
            buf_set_keymap("n", "<leader>ff", "<cmd>RustFmt<CR>", opts)
        else
            buf_set_keymap("n", "<leader>ff", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
        end

        buf_set_keymap("n", "<leader>so", [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
        buf_set_keymap(
            "n",
            "<leader>sw",
            [[<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>]],
            opts
        )

        if server_name == "rust_analyzer" then
            buf_set_keymap("n", "gJ", "<cmd>RustJoinLines<CR>", opts)
        end
        require("fidget").setup({})
    end
end

local function make_flags()
    return {
        debounce_text_changes = 350,
    }
end

local function make_lua_cmd()
    -- brew install lua-language-server
    local sumneko_binary = require("turboladen/homebrew").prefix() .. "/bin/lua-language-server"

    return { sumneko_binary }
end

local function make_lua_settings()
    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    local runtime_files = vim.api.nvim_get_runtime_file("", true)
    vim.tbl_extend("keep", runtime_files, {
        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
    })

    return {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = runtime_files,
            },
        },
    }
end

local function setup_lsp()
    local lsp_status = require("lsp-status")
    lsp_status.register_progress()

    local lspconfig = require("lspconfig")
    local capabilities = make_capabilities()
    local flags = make_flags()

    lspconfig.solargraph.setup({
        capabilities = capabilities,
        on_attach = make_on_attach("solargraph"),
        flags = flags,
    })

    lspconfig.clangd.setup({
        capabilities = capabilities,
        on_attach = make_on_attach("clangd"),
        flags = flags,
    })

    lspconfig.sumneko_lua.setup({
        cmd = make_lua_cmd(),
        capabilities = capabilities,
        on_attach = make_on_attach("sumneko_lua"),
        -- flags = flags
        settings = make_lua_settings(),
    })

    lspconfig.jsonls.setup({
        capabilities = capabilities,
        on_attach = make_on_attach("jsonls"),
        flags = flags,
        settings = {
            json = {
                schemas = require("schemastore").json.schemas({
                    select = {
                        "CMake Presets",
                        "GitHub Action",
                        "GitHub Issue Template configuration",
                        "GitHub Workflow",
                        "GitHub Workflow Template Properties",
                        "GitHub issue forms",
                        "GitVersion",
                        "JSON Schema Draft 2020-12",
                        "JSON Schema Draft 4",
                        "JSON Schema Draft 7",
                        "JSON Schema Draft 8",
                        "JSON-API",
                        "prettierrc.json",
                        "Swagger API 2.0",
                        "VSCode Code Snippets",
                        "compile_commands.json",
                        "docker-compose.yml",
                        "geojson.json",
                        "markdownlint.json",
                        "package.json",
                        "yamllint",
                    },
                }),
            },
        },
    })

    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
end

return {
    hover = hover,
    make_capabilities = make_capabilities,
    make_on_attach = make_on_attach,
    make_flags = make_flags,
    setup_lsp = setup_lsp,
}
