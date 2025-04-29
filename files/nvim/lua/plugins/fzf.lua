return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  event = "VeryLazy",
  keys = {
    -- {
    --   "sf",
    --   function()
    --     require("fzf-lua").files({ resume = true })
    --   end,
    --   desc = "File File",
    -- },
    {
      ";r",
      function()
        require("fzf-lua").live_grep()
      end,
      desc = "Live Grep",
    },
    -- {
    --   ";e",
    --   function()
    --     require("fzf-lua").lsp_document_diagnostics()
    --   end,
    --   desc = "Document Diagnostics",
    -- },
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
    },
  },
  opts = {},
}
