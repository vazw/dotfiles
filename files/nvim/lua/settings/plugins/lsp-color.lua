return {
    'folke/lsp-colors.nvim',
    priority = 1000,
    config = function()
        local colors = require("lsp-colors")
        colors.setup {
            Error = "#db4b4b",
            Warning = "#e0af68",
            Information = "#0db9d7",
            Hint = "#10B981"
        }
    end
}
