-- NOTE: most of the autocmds found in lazy.vim autocmds :
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- EXAMPLE: auto format on save.
-- autocmd({ "BufWritePre" }, {
--   group = augroup("auto_format"),
--   callback = function()
--     vim.lsp.buf.format()
--   end,
-- })
-- NOTE: conform plugin provide more formatting configs.
--
local function augroup(name)
	return vim.api.nvim_create_augroup("vaz_" .. name, { clear = true })
end
local autocmd = vim.api.nvim_create_autocmd

local next = next

-- Turn off paste mode when leaving insert
autocmd("InsertLeave", {
	group = augroup("insert_leave"),
	pattern = "*",
	command = "set nopaste",
})

-- Disable the concealing in some file formats
autocmd("FileType", {
	group = augroup("json_concealing"),
	pattern = { "json", "jsonc", "markdown" },
	callback = function()
		vim.opt.conceallevel = 0
	end,
})

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

-- Highlight on yank
autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})

-- resize splits if window got resized
autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
			return
		end
		vim.b[buf].lazyvim_last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- close some filetypes with <q>
autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"checkhealth",
		"dbout",
		"gitsigns-blame",
		"grug-far",
		"help",
		"lspinfo",
		"neotest-output",
		"neotest-output-panel",
		"neotest-summary",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, {
				buffer = event.buf,
				silent = true,
				desc = "Quit buffer",
			})
		end)
	end,
})

-- make it easier to close man-files when opened inline
autocmd("FileType", {
	group = augroup("man_unlisted"),
	pattern = { "man" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
	end,
})

-- wrap and check for spell in text filetypes
autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

local function clear_lsp()
	for _, client in ipairs(vim.lsp.get_clients()) do
		local lsp_attached = next(client.attached_buffers)
		if lsp_attached == nil then
			---@diagnostic disable-next-line: param-type-mismatch
			client.stop(true)
			-- vim.print("to stop: " .. client.name)
		end
	end
end

autocmd("BufDelete", {
	group = augroup("clear_lsp"),
	callback = function()
		vim.defer_fn(clear_lsp, 2000)
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

autocmd({ "InsertLeave" }, {
	group = augroup("disable_snippet"),
	callback = function()
		if vim.snippet then
			vim.snippet.stop()
		end
	end,
})

autocmd("FileType", {
	group = augroup("set Cargo"),
	pattern = { "rust" },
	callback = function()
		vim.opt.makeprg = "cargo"
	end,
})

local function jump_from_qf_custom()
	local line = vim.api.nvim_get_current_line()

	local path, row, col = line:match("([%w%d%._%-/]+):(%d+):(%d+)")
	if not col then
		col = 2
	end

	if path and row and col then
		vim.cmd("wincmd p")
		vim.cmd(string.format("edit +%s %s", row, path))
		vim.api.nvim_win_set_cursor(0, { tonumber(row), tonumber(col) - 1 })
	else
		print("No valid file path:line:col found on this line.")
	end
end

-- 5. Create the keymap specifically for Quickfix buffers
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.keymap.set("v", "gf", jump_from_qf_custom, { buffer = true, desc = "Jump to location" })
	end,
})

-- Prefer LSP folding if client supports it
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client:supports_method("textDocument/foldingRange") then
			local win = vim.api.nvim_get_current_win()
			vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
		end
	end,
})

-- Treesitter
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

-- Custom filetype for KernelScript

vim.filetype.add({
	extension = {
		ks = "kernelscript",
		kh = "kernelscript",
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "kernelscript",
	callback = function()
		vim.bo.commentstring = "// %s"
	end,
})
