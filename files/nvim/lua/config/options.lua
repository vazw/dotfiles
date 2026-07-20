vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_2html_plugin = 1
-- # DISABLE netrwPlugin
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
-- # DISABLE vim.provider?
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.omni_sql_default_compl_type = "syntax"

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.wo.number = true

vim.opt.title = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
-- 'laststatus' = 0	never a status line
-- 'laststatus' = 1	status line if there is more than one window
-- 'laststatus' = 2	always a status line
-- 'laststatus' = 3	have a global statusline at the bottom instead
-- 			of one for each window
vim.opt.laststatus = 2
vim.opt.scrolloff = 5
vim.opt.shell = "zsh"
vim.opt.relativenumber = true
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.inccommand = "split"
vim.opt.numberwidth = 5
-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
-- wrap lines
vim.opt.wrap = false
-- Note Pad Style Wrap
vim.cmd("set wrap lbr")

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
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
vim.opt.undofile = true

-- swapfile
vim.opt.swapfile = false

-- indent
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 0
vim.opt.indentexpr = "on"
vim.opt.smarttab = true
vim.opt.breakindent = true

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

-- go to previous/next line with left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append("<>[]")

-- use mouse click but disable when typing
vim.opt.mouse = "nvch"
vim.opt.signcolumn = "yes"
vim.api.nvim_set_option_value("colorcolumn", "80", {})
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.wildoptions = "pum"
vim.opt.pumblend = 5

-- Folding
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldtext = ""
vim.opt.foldcolumn = "0"
vim.opt.fillchars:append({ fold = " " })
-- Default to treesitter folding
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- vim.diagnostic.opt.update_in_insert = true
