return {
  {
    "nvimtools/none-ls.nvim", -- none-ls is null-ls from community
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- import null-ls plugin
      local null_ls = require("null-ls")
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

      -- configure null_ls
      null_ls.setup({
        -- setup formatters & linters
        sources = {
          formatting.black,
          formatting.clang_format,
          formatting.leptosfmt --[[ .with({ extra_args = { "-r" } }) ]],
          formatting.shfmt,
          completion.nvim_snippets,
          completion.tags,
          formatting.shfmt,
        },
      })
    end,
  },
}
