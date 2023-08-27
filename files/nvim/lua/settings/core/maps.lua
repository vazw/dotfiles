local keymap = vim.keymap
local g = vim.g

g.mapleader = " "

-- Basic motion

-- Resize window (NOT WORKING)
-- keymap.set('n', '<C-w><left>', '<C-w><')
-- keymap.set('n', '<C-w><right>', '<C-w>>')
-- keymap.set('n', '<C-w><up>', '<C-w>+')
-- keymap.set('n', '<C-w><down>', '<C-w>-')

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

-- New Line
keymap.set("n", "<leader>o", "o<ESC>", { silent = true })
keymap.set("n", "<leader>O", "O<ESC>", { silent = true })

-- toggle comment
keymap.set("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>")
keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")

-- toggle terminal
local toggle_modes = { "n", "t" }
keymap.set(toggle_modes, "<leader>ht", function()
	return require("nvterm.terminal").toggle("horizontal")
end)
keymap.set(toggle_modes, "<leader>hh", function()
	return require("nvterm.terminal").toggle("vertical")
end)

-- Move window
-- keymap.set('n', '<Space>', '<C-w>w')
keymap.set(toggle_modes, "<C-w>h", "<C-w>h")
keymap.set(toggle_modes, "<C-w>k", "<C-w>k")
keymap.set(toggle_modes, "<C-w>j", "<C-w>j")
keymap.set(toggle_modes, "<C-w>l", "<C-w>l")
-- close buffer
keymap.set({ "n", "v" }, "<leader>x", "<ESC>:q<CR>")

keymap.set("n", "<leader>]", function()
	vim.diagnostic.goto_next()
end)
keymap.set("n", "<leader>[", function()
	vim.diagnostic.goto_prev()
end)

-- nvim tree
keymap.set("n", "<C-f>", ":NvimTreeToggle<CR>")
keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer

keymap.set("n", "<leader>j", ":Glow<CR>")

-- nvim dropbar
keymap.set("n", "<leader>k", function()
	return require("dropbar.api").pick()
end)

keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", {})
keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", {})

-- LSP saga
local opts = { noremap = true, silent = true }
keymap.set("n", "<C-j>", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
keymap.set("n", "gl", "<Cmd>Lspsaga show_line_diagnostics<CR>", opts)
keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
keymap.set("n", "gd", "<Cmd>Lspsaga finder<CR>", opts)
keymap.set("n", "gt", "<Cmd>Lspsaga goto_type_definition<CR>", opts)
-- vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
keymap.set("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
keymap.set("n", "gp", "<Cmd>Lspsaga peek_definition<CR>", opts)
keymap.set("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)

-- code action
keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")