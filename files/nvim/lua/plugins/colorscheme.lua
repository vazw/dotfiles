return {
  {
    "wtfox/jellybeans.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      on_highlights = function(hl, _)
        hl.ColorColumn = { bg = "#252525" }
      end,
      on_colors = function(c)
        local dark_bg = "#121214"
        local light_bg = "#F3F3F4"
        c.background = vim.o.background == "light" and light_bg or dark_bg
      end,
    },
  },
}
