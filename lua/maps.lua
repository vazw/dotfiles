local keymap = vim.keymap
local g = vim.g

g.mapleader = " "
keymap.set('n', 'x', '"_x')

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a word backwards
keymap.set('n', 'dw', 'vb"_d')

-- NO highlight find
keymap.set('n', '<ESC>', '<cmd> noh <CR>')

-- RUN PYTHON
keymap.set('n', '<F5>', function() require('nvterm.terminal').send('python ' .. vim.fn.expand('%')) end)

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- New tab
keymap.set('n', 'te', ':tabedit')
-- Split window
keymap.set('n', 'ss', ':split<Return><C-w>w')
keymap.set('n', 'vs', ':vsplit<Return><C-w>w')
-- Move window
-- keymap.set('n', '<Space>', '<C-w>w')
keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')

-- Resize window
keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')

-- toggle comment
keymap.set('n', '<leader>/', "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>")
keymap.set('v', '<leader>/', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")

-- toggle terminal
local toggle_modes = { 'n', 't' }
keymap.set(toggle_modes, '<leader>h', function() require("nvterm.terminal").toggle('horizontal') end)

-- close buffer
keymap.set({ 'n', 'i', 'v' }, '<leader>x', "<ESC> :close<CR>")
