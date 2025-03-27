-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- vim.cmd("autocmd!")
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
vim.wo.number = true

vim.opt.title = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 3
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 5
vim.opt.shell = "fish"
vim.opt.relativenumber = true
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.inccommand = "split"
vim.opt.numberwidth = 5
-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
-- wrap lines
vim.opt.wrap = true
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolders
vim.opt.wildignore:append({ "*/node_modules/*", "*/__pycache__/*", "*/env/*" })
-- System clipboard
vim.opt.clipboard = { "unnamed", "unnamedplus" }
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.splitkeep = "cursor"

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- undo
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- indent
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.indentexpr = "on"
vim.opt.smarttab = true
vim.opt.breakindent = true

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append("<>[]hl")

-- use mouse click but disable when typing
vim.opt.mouse = "nvch"
vim.opt.signcolumn = "yes"
vim.api.nvim_set_option_value("colorcolumn", "80", {})
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.wildoptions = "pum"
vim.opt.pumblend = 5
-- vim.opt.background = "dark"

-- highlight yanked text for 200ms using the "Visual" highlight group
vim.cmd([[
  augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=100})
  augroup END
]])

-- LSP Server to use for Rust.
-- Set to "bacon-ls" to use bacon-ls instead of rust-analyzer.
-- only for diagnostics. The rest of LSP support will still be
-- provided by rust-analyzer.
vim.g.lazyvim_rust_diagnostics = "rust-analyzer"
-- vim.g.lazyvim_rust_diagnostics = "bacon-ls"
vim.g.lazyvim_picker = "snacks"
