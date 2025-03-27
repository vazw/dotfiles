-- bootstrap lazy.nvim, LazyVim and your plugins
-- Neovide Config
if vim.g.neovide then
  vim.o.guifont = "ComicShannsMono Nerd Font Mono:h12"
end
require("config.lazy")
