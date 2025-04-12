return {
  {
    "nvimtools/none-ls.nvim", -- none-ls is null-ls from community
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- import null-ls plugin
      local null_ls = require("null-ls")

      -- for conciseness

      -- code action sources
      local code_actions = null_ls.builtins.code_actions

      -- diagnostic sources
      local diagnostics = null_ls.builtins.diagnostics

      -- formatting sources
      local formatting = null_ls.builtins.formatting

      -- hover sources
      local hover = null_ls.builtins.hover

      -- completion sources
      local completion = null_ls.builtins.completion
      local helper = require("null-ls.helpers")

      -- to setup format on save
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      -- configure null_ls
      null_ls.setup({
        -- setup formatters & linters
        --   opts.sources = opts.sources or {}
        sources = {
          -- Python
          formatting.black,
          -- C
          formatting.clang_format,
          -- Rust - Leptos FrameWork
          formatting.leptosfmt --[[ .with({ extra_args = { "-r" } }) ]],
          -- Bash
          formatting.shfmt,
          -- Nvim
          completion.nvim_snippets,
          completion.tags,
          -- PHP
          diagnostics.phpcs,
          formatting.phpcsfixer,
        },
        -- configure format on save
        on_attach = function(current_client, bufnr)
          if current_client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({
                  filter = function(client)
                    --  only use null-ls for formatting instead of lsp server
                    return client.name == "null-ls"
                  end,
                  bufnr = bufnr,
                  timeout_ms = 10000,
                })
              end,
            })
          end
        end,
      })
    end,
  },
}
