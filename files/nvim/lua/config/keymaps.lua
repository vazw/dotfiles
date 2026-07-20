local keymap = vim.keymap
local g = vim.g
local opts = { noremap = true, silent = true }

-- MAP <LEADER> TO <SPACEBAR>
g.mapleader = " "

-- Basic motion
-- Resize window
keymap.set("n", "<C-left>", "<C-w><")
keymap.set("n", "<C-right>", "<C-w>>")
keymap.set("n", "<C-up>", "<C-w>+")
keymap.set("n", "<C-down>", "<C-w>-")

-- move in insert mode
keymap.set("i", "<C-h>", "<Left>")
keymap.set("i", "<C-l>", "<Right>")
keymap.set("i", "<C-j>", "<Down>")
keymap.set("i", "<C-k>", "<Up>")
keymap.set("t", "<C-ESC>", "<C-\\><C-n>", opts)

-- Fast shift move
keymap.set("n", "H", "<S-Left>")
keymap.set("n", "L", "<S-Right>")

-- do not skip line when it's warped
keymap.set("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
keymap.set("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")
-- Don't copy pasting yanked
keymap.set("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { silent = true })

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')
keymap.set("v", "d", '"_d')
keymap.set("n", "x", '"_x')

-- NO highlight find
keymap.set("n", "<ESC>", "<cmd> noh <CR>")

keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select All" })

-- New tab
keymap.set("n", "te", ":tabedit ")
keymap.set("n", "<tab>", ":tabnext<CR>", opts)
keymap.set("n", "<s-tab>", ":tabprev<CR>", opts)
-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
keymap.set("n", "fe", "<cmd>Lexplore<CR>", { silent = true, desc = "netrw Lexplorer" })

keymap.set("n", "<leader>o", "o<ESC>", { silent = true, desc = "Create New Line Below" })
keymap.set("n", "<leader>O", "O<ESC>", { silent = true, desc = "Create New Line Above" })

keymap.set({ "n", "v" }, "<leader>x", "<ESC>:bdelete<CR>", { desc = "Close" })

keymap.set("n", "<leader>cw", "<cmd>lcd %:p:h <CR>", { desc = "Set local working Dir" })
keymap.set("n", "<leader>cW", "<cmd>cd %:p:h <CR>", { desc = "Set as working Dir" })

-- Move Lines
keymap.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
keymap.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
keymap.set("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
keymap.set("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- Comment String
keymap.set("n", "<C-c>", ":norm gcc<CR>", opts)
keymap.set({ "x", "o" }, "<C-c>", "gc", { remap = true })

-- Macro norm!
-- keymap.set("v", "m", ":norm! _", { desc = "norm!" })

-- better indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Formatter
-- vim.api.nvim_create_user_command("Format", ":lua vim.lsp.buf.format()", { desc = "Manual Format" })
-- conform
vim.api.nvim_create_user_command("Format", ":lua require'conform'.formatexpr()", { desc = "Manual Format" })

vim.api.nvim_create_user_command("InlayHint", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, {})
keymap.set("n", "<leader>ch", ":InlayHint<CR>", { desc = "Toggle InlayHints" })

-- Save with root permission
-- NOTE: change pkexec to your system dialog or polkit
-- sudo may need external dialogs too.
vim.api.nvim_create_user_command("SaveAsRoot", "w !pkexec tee > /dev/null %:p", {})

-- LSP
vim.keymap.set("n", "gD", function()
	vim.lsp.buf.declaration()
end, { desc = "Go To Declaration" })

vim.keymap.set("n", "gd", function()
	vim.lsp.buf.definition()
end, { desc = "Go To Definition" })

vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover()
end, { desc = "Lsp Hover" })

vim.keymap.set("n", "<c-k>", function()
	vim.diagnostic.open_float()
end, { desc = "Diagnostic" })

keymap.set({ "n" }, "<c-/>", ":ToggleTerminal<CR>")
keymap.set({ "t" }, "<c-/>", "<c-\\><c-n>:ToggleTerminal<CR>")

keymap.set("n", "<leader>co", ":copen<cr>", { desc = "copen after make" })

local tmux = vim.fn.getenv("TMUX")
if tmux ~= nil then
	keymap.set({ "n" }, "<c-_>", ":ToggleTerminal<CR>")
	keymap.set({ "t" }, "<c-_>", "<c-\\><c-n>:ToggleTerminal<CR>")
end

vim.api.nvim_create_user_command("LspLog", ":tabe ~/.local/state/nvim/lsp.log", {})
