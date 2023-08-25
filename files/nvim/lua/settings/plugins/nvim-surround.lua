return {
    "kylechui/nvim-surround",
    priority = 1000,
    event = { "BufReadPre", "BufNewFile" },
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = true,
}
