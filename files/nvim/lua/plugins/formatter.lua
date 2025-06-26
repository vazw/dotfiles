vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
return {
  "stevearc/conform.nvim",
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>cf",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      rust = { "rustfmt", "leptosfmt" },
      -- You can use a function here to determine the formatters dynamically
      python = function(bufnr)
        if require("conform").get_formatter_info("ruff_format", bufnr).available then
          return { "ruff_format", "isort", "black" }
        else
          return { "isort", "black" }
        end
      end,
      markdown = { "markdownlint" },
      c = { "clang_format" },
      bash = { "shfmt" },
      typst = { "prettypst" },
      zig = { "zigfmt" },
      ["*"] = { "codespell" },
      ["_"] = { "trim_whitespace" },
    },
    -- Set default options
    default_format_opts = {
      lsp_format = "fallback",
      timeout_ms = 3000,
      async = true,
      quiet = false,
    },
    -- Set up format-on-save
    format_on_save = {
      timeout_ms = 3000,
      lsp_format = "fallback",
    },
    -- Customize formatters
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
      leptosfmt = {
        condition = function(self, ctx)
          return require("lspconfig.util").root_pattern("leptosfmt.toml")(ctx.filename)
        end,
        append_args = { "--rustfmt" },
      },
    },
  },
}
