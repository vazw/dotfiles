return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "jose-elias-alvarez/typescript.nvim",
        "hrsh7th/cmp-nvim-lsp",
        {
            "smjonas/inc-rename.nvim",
            config = true,
        },
    },
    opts = {
        inlay_hints = { enabled = true },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local protocol = require("vim.lsp.protocol")
        -- import typescript plugin
        local typescript = require("typescript")

        local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
        local enable_format_on_save = function(_, bufnr)
            vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup_format,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
        -- Set up completion using nvim_cmp with LSP source
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer
        local on_attach = function(client, bufnr)
            local function buf_set_keymap(...)
                vim.api.nvim_buf_set_keymap(bufnr, ...)
            end

            local function buf_set_option(name, func)
                vim.api.nvim_set_option_value(name, func, { buf = bufnr })
            end
            if client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(true)
            end

            --Enable completion triggered by <c-x><c-o>
            buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

            -- Mappings.
            local opts = { noremap = true, silent = true }

            -- See `:help vim.lsp.*` for documentation on any of the below functions
            buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
            buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
            buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
            buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
            buf_set_keymap("n", "<C-k>", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
            if client.name == "tsserver" then
                opts.desc = "Rename file and update file imports"
                vim.keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports

                opts.desc = "Rename file and update file imports"
                vim.keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>", opts) -- organize imports (not in youtube nvim video)

                opts.desc = "Remove unused imports"
                vim.keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>", opts) -- remove unused variables (not in youtube nvim video)
            end
        end
        protocol.CompletionItemKind = {
            "󱌯 ", -- Text
            "ƒ", -- Method
            "󰡱 ", -- Function
            " ", -- Constructor
            " ", -- Field
            "󰫧 ", -- Variable
            " ", -- Class
            " ", -- Interface
            "󰕳 ", -- Module
            " ", -- Property
            " ", -- Unit
            " ", -- Value
            " ", -- Enum
            " ", -- Keyword
            " ", -- Snippet
            " ", -- Color
            " ", -- File
            " ", -- Reference
            " ", -- Folder
            " ", -- EnumMember
            " ", -- Constant
            " ", -- Struct
            "", -- Event
            " ", -- Operator
            " ", -- TypeParameter
        }

        lspconfig.bashls.setup({
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                enable_format_on_save(client, bufnr)
            end,
            capabilities = capabilities,
        })

        lspconfig.ruff_lsp.setup({
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                enable_format_on_save(client, bufnr)
            end,
            capabilities = capabilities,
        })

        lspconfig.rust_analyzer.setup({
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                enable_format_on_save(client, bufnr)
            end,
            capabilities = capabilities,
            settings = {
                ["rust-analyzer"] = {
                    rustfmt = {
                        overrideCommand = { "leptosfmt", "--stdin", "--rustfmt" },
                    },
                    -- Add clippy lints for Rust.
                    -- checkOnSave = {
                    --     allFeatures = true,
                    --     command = "clippy",
                    --     extraArgs = { "--no-deps" },
                    -- },
                    diagnostics = {
                        disabled = "inactive-code",
                    },
                    imports = {
                        granularity = {
                            group = "module",
                        },
                        prefix = "self",
                    },
                    cargo = {
                        allFeatures = true,
                        loadOutDirsFromCheck = true,
                        runBuildScripts = true,
                    },
                    procMacro = {
                        enable = true,
                        ignored = {
                            ["async-trait"] = { "async_trait" },
                            ["napi-derive"] = { "napi" },
                            ["async-recursion"] = { "async_recursion" },
                        },
                    },
                },
            },
        })
        lspconfig.csharp_ls.setup({
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                enable_format_on_save(client, bufnr)
            end,
            capabilities = capabilities,
        })

        lspconfig.clangd.setup({
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                enable_format_on_save(client, bufnr)
            end,
            capabilities = capabilities,
        })

        lspconfig.pyright.setup({
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                enable_format_on_save(client, bufnr)
            end,
            capabilities = capabilities,
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        diagnosticMode = "workspace",
                        useLibraryCodeForTypes = true,
                        typeCheckingMode = "off",
                        logLevel = "Error",
                        autoImportCompletions = true,
                    },
                },
            },
        })

        lspconfig.lua_ls.setup({
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                enable_format_on_save(client, bufnr)
            end,
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { "vim" },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                },
            },
        })
        lspconfig["html"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure typescript server with plugin
        typescript.setup({
            server = {
                capabilities = capabilities,
                on_attach = on_attach,
            },
        })

        -- configure css server
        lspconfig["cssls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure tailwindcss server
        lspconfig["tailwindcss"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure svelte server
        lspconfig["svelte"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure prisma orm server
        lspconfig["prismals"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure graphql language server
        lspconfig["graphql"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
        })

        -- configure emmet language server
        lspconfig["emmet_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
        })

        -- Nix language server
        lspconfig["nil_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
        lspconfig.zls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            underline = true,
            update_in_insert = true,
            virtual_text = { spacing = 4, prefix = "●" },
            severity_sort = true,
            signs = true,
        })

        -- Diagnostic symbols in the sign column (gutter)
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        vim.diagnostic.config({
            virtual_text = {
                prefix = "●",
            },
            severity_sort = true,
            signs = {
                priority = 1,
            },
            update_in_insert = true,
            float = {
                source = "if_many", -- Or "always"
                -- namespace = 1,
            },
        })
    end,
}
