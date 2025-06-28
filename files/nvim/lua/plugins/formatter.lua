-- vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
return {
  "stevearc/conform.nvim",
  lazy = false,
  keys = {
    {
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
      -- angular, css, flow, graphql, html, json, jsx, javascript, less, markdown, scss, typescript, vue, yaml
      angular = { "prettierd", stop_after_first = true },
      javascript = { "prettierd", stop_after_first = true },
      html = { "prettierd", stop_after_first = true },
      typescript = { "prettierd", stop_after_first = true },
      css = { "prettierd", stop_after_first = true },
      scss = { "prettierd", stop_after_first = true },
      json = { "prettierd", stop_after_first = true },
      vue = { "prettierd", stop_after_first = true },
      yaml = { "prettierd", stop_after_first = true },
      graphql = { "prettierd", stop_after_first = true },
      markdown = { "markdown-toc", "prettierd" },

      rust = { "rustfmt", "leptosfmt" },
      -- You can use a function here to determine the formatters dynamically
      python = function(bufnr)
        if require("conform").get_formatter_info("ruff_format", bufnr).available then
          return { "ruff_format", "isort", "black" }
        else
          return { "isort", "black" }
        end
      end,
      c = { "clang_format" },
      bash = { "shfmt" },
      typst = { "prettypst" },
      zig = { "zigfmt" },
      -- ["*"] = { "codespell" },
      -- ["_"] = { "trim_whitespace" },
    },
    -- Set default options
    default_format_opts = {
      lsp_format = "fallback",
      timeout_ms = 2000,
      async = true,
      quiet = true,
    },
    -- Set up format-on-save
    format_on_save = {
      lsp_format = "fallback",
      timeout_ms = 2000,
      async = false,
      quiet = false,
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
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
