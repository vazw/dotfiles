return {
    {
    "lewis6991/gitsigns.nvim",
    priority = 1000,
    event = { "BufReadPre", "BufNewFile" },
    config = true,
    },
  {
    "dinhhuy258/git.nvim",
    event = "BufReadPre",
    opts = {
      keymaps = {
        -- Open blame window
        blame = "<Leader>gb",
        -- Open file/folder in git repository
        browse = "<Leader>go",
      },
    },
  },
}
