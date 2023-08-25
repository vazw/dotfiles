return {
    'lukas-reineke/indent-blankline.nvim',
    priority = 1000,
    config = function()
        local indent = require("indent_blankline")
        indent.setup({
            -- for example, context is off by default, use this to turn it on
            show_current_context = true,
            show_current_context_start = true,
        })
    end,
}
