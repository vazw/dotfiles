return {
  "numToStr/Comment.nvim",
  keys = {
    {
      "<C-c>",
      "<cmd>lua require('Comment.api').toggle.linewise()<CR>",
      mode = "n",
      desc = "Toggle Line Comment",
    },
    {
      "<C-c>",
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      mode = "v",
      desc = "Toggle Multi-Line Comment",
    },
    { "gc", false },
    { "gcc", false },
  },
  event = "BufReadPre",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    -- import comment plugin safely
    local comment = require("Comment")

    local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

    -- enable comment
    comment.setup({
      -- for commenting tsx and jsx files
      pre_hook = ts_context_commentstring.create_pre_hook(),
      mappings = {
        basic = false,
        extra = false,
      },
    })
  end,
}
