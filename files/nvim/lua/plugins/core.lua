return {
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-/>]],
      direction = "horizontal",
    },
    keys = {
      { "<c-/>", '<Cmd>exe v:count1 . "ToggleTerm"<CR>', desc = "Toggle Term" },
    },
  },
}
