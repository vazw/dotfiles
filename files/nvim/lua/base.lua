vim.cmd("autocmd!")
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.wo.number = true

vim.opt.title = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 3
vim.opt.termguicolors = true
vim.opt.scrolloff = 5
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
vim.opt.clipboard = { "unnamed", "unnamedplus" }

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- indent
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.indentexpr = "on"

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append("<>[]hl")

-- use mouse click
vim.opt.mouse = "a"
vim.opt.signcolumn = "yes"
vim.api.nvim_set_option_value("colorcolumn", "80", {})
