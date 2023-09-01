return {
    'nvimdev/lspsaga.nvim',
    priority = 1000,
    config = function()
        local saga = require('lspsaga')
        saga.setup({
          ui = {
            border = 'rounded',
          },
          symbol_in_winbar = {
            enable = false
          },
          lightbulb = {
            enable = false
          },
          outline = {
            layout = 'float'
          }
        })

        local diagnostic = require("lspsaga.diagnostic")
    end,
}
