-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local g = vim.g
local opts = { noremap = true, silent = true }

g.mapleader = " "

-- Basic motion
-- Resize window (NOT WORKING)
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")
keymap.set("n", "<C-left>", "<C-w><")

-- move in insert mode
keymap.set("i", "<C-h>", "<Left>")
keymap.set("i", "<C-l>", "<Right>")
keymap.set("i", "<C-j>", "<Down>")
keymap.set("i", "<C-k>", "<Up>")
-- keymap.set("t", "<C-ESC>", "<C-\\><C-n>", opts)

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

keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission
vim.api.nvim_create_user_command("SaveAsRoot", "w !pkexec tee > /dev/null %", {})

-- New tab
keymap.set("n", "te", ":tabedit ")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

keymap.set("n", "<leader>o", "o<ESC>", { silent = true, desc = "Create New Line Below" })
keymap.set("n", "<leader>O", "O<ESC>", { silent = true, desc = "Create New Line Above" })

keymap.set({ "n", "v" }, "<leader>x", "<ESC>:q<CR>", { desc = "Close" })

keymap.set("n", "<leader>cw", "<cmd>cd %:p:h <CR>", { desc = "Set as working Dir" })
keymap.set("n", "<leader>cW", "<cmd>lcd %:p:h <CR>", { desc = "Set local working Dir" })

keymap.set("n", "sf", function()
  local count = vim.v.count1
  local path = vim.fn.expand("%:p:h")
  local cmd = string.format("cd %s & lf", path)
  require("toggleterm").exec(cmd, count, 0, path, "float", "lf", true, true)
end, { desc = "LF Files Explorer" })

keymap.set("n", "sF", "<cmd>FZF<CR>", { desc = "FZF Files Finder" })

keymap.set("n", "<leader>gg", function()
  local count = vim.v.count1
  local path = vim.fn.expand("%:p:h")
  local cmd = string.format("cd %s & lazygit", path)
  require("toggleterm").exec(cmd, count, 0, path, "float", "lazygit", true, true)
end, { desc = "Lazygit Toggle" })
