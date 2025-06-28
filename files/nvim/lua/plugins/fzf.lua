return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  event = "VeryLazy",
  keys = {
    {
      "sf",
      function()
        require("fzf-lua").files()
      end,
      desc = "File File",
    },
    {
      "sF",
      function()
        -- require("fzf-lua").files({ cwd = vim.fn.getcwd() })
        require("fzf-lua").files({ cwd = vim.fn.expand("%:p:h") })
      end,
      desc = "File File",
    },
    {
      ";r",
      function()
        require("fzf-lua").live_grep()
      end,
      desc = "Live Grep",
    },
    {
      ";;",
      function()
        require("fzf-lua").lsp_document_diagnostics()
      end,
      desc = "Document Diagnostics",
    },
    {
      ";e",
      function()
        require("fzf-lua").lsp_workspace_diagnostics()
      end,
      desc = "Workspace Diagnostics",
    },
    {
      "<leader>ca",
      function()
        require("fzf-lua").lsp_code_actions()
      end,
      desc = "Code Action",
      silent = true,
    },
  },
  opts = {
    files = {
      actions = {
        ["ctrl-u"] = function(_, opts)
          local parent = vim.fn.fnamemodify(opts.cwd or vim.uv.cwd() or vim.fn.getcwd(), ":h")
          require("fzf-lua").files({ cwd = parent })
        end,
      },
    },
  },
  config = function(_, opts)
    -- register FzfLua to handle vim.ui.select
    require("fzf-lua").setup(opts)
    vim.cmd("FzfLua register_ui_select")
  end,
}
