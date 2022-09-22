local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })

null_ls.setup({
    sources = {
        -- Python
        null_ls.builtins.formatting.yapf,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.diagnostics.flake8,

        -- Lua
        -- null_ls.builtins.formatting.stylua.with { filetypes = { "lua" } },
        -- Spell checking
        null_ls.builtins.diagnostics.codespell.with({
            args = { "--builtin", "clear,rare,code", "-" },
        }),
    },
    on_attach = function(client, bufnr)
        if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format }
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup_format,
                buffer = 0,
                callback = function() vim.lsp.buf.formatting_seq_sync() end
            })
        end
    end,
})
