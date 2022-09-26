local status, null_ls = pcall(require, "null-ls")
if not status then
	return
end

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })

null_ls.setup({
	sources = {
		-- Python
		null_ls.builtins.formatting.isort.with({
			extra_args = { "--line-length", "79", "--profile", "black" },
		}),
		null_ls.builtins.formatting.black.with({
			extra_args = { "--line-length", "79" },
		}),
		null_ls.builtins.diagnostics.flake8.with({
			filetypes = { "python" },
			extra_args = { "--extend-ignore", "E203" },
		}),
		-- refactoring plugin but...
		-- null_ls.builtins.code_actions.refactoring.with({ filetypes = { "python" } }),
		-- Lua
		null_ls.builtins.formatting.stylua.with({ filetypes = { "lua" } }),
		-- Spell checking
		-- null_ls.builtins.diagnostics.codespell.with({
		--     args = { "--builtin", "clear,rare,code", "-" },
		-- }),
	},
	on_attach = function(client, bufnr)
		if client.server_capabilities.documentFormattingProvider then
			vim.api.nvim_clear_autocmds({ buffer = 0, group = augroup_format })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup_format,
				buffer = 0,
				callback = function()
					vim.lsp.buf.formatting_seq_sync(nill, 10000)
				end,
			})
		end
	end,
})
