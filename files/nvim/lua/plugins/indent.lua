return {
  "lukas-reineke/indent-blankline.nvim",
  lazy = false,
  config = function()
    local indent = require("ibl")
    indent.setup()
  end,
}
