local keymap = vim.keymap
local g = vim.g

g.mapleader = " "

-- Basic motion
-- move in insert mode
keymap.set("i", "<C-h>", "<Left>")
keymap.set("i", "<C-l>", "<Right>")
keymap.set("i", "<C-j>", "<Down>")
keymap.set("i", "<C-k>", "<Up>")
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
keymap.set("n", "x", '"_x')
keymap.set("v", "d", '"_d')

-- NO highlight find
keymap.set("n", "<ESC>", "<cmd> noh <CR>")

-- RUN PYTHON
keymap.set("n", "<F5>", function()
	require("nvterm.terminal").send("python " .. vim.fn.expand("%"))
end)

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- New tab
keymap.set("n", "te", ":tabe ")
-- Split window
keymap.set("n", "ss", ":split<Return><C-w>w")
keymap.set("n", "sv", ":vsplit<Return><C-w>w")

-- Move window
-- keymap.set('n', '<Space>', '<C-w>w')
keymap.set("", "sh", "<C-w>h")
keymap.set("", "sk", "<C-w>k")
keymap.set("", "sj", "<C-w>j")
keymap.set("", "sl", "<C-w>l")

-- Resize window (NOT WORKING)
-- keymap.set('n', '<C-w><left>', '<C-w><')
-- keymap.set('n', '<C-w><right>', '<C-w>>')
-- keymap.set('n', '<C-w><up>', '<C-w>+')
-- keymap.set('n', '<C-w><down>', '<C-w>-')

-- toggle comment
keymap.set("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>")
keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")

-- toggle terminal
local toggle_modes = { "n", "t" }
keymap.set(toggle_modes, "<leader>h", function()
	return require("nvterm.terminal").toggle("horizontal")
end)

-- close buffer
keymap.set({ "n", "v" }, "<leader>x", "<ESC>:q<CR>")

vim.keymap.set("n", "<leader>]", function()
	vim.diagnostic.goto_next()
end)
vim.keymap.set("n", "<leader>[", function()
	vim.diagnostic.goto_prev()
end)
