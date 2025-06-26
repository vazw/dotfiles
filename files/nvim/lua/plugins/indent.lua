return {
  {
    "nvimdev/indentmini.nvim",
    event = { "BufReadPre" },
    config = function()
      -- Current indent line highlight
      vim.cmd.highlight("IndentLine guifg=#303030")
      vim.cmd.highlight("IndentLineCurrent guifg=green")
      require("indentmini").setup() -- use default config
    end,
  },
}
