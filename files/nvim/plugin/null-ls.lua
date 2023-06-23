local status, null_ls = pcall(require, "null-ls")
if not status then
	return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
		timeout_ms = 5000,
	})
end

null_ls.setup({
	sources = {
		-- Python
		null_ls.builtins.formatting.black.with({
			extra_args = { "--line-length", "80" },
		}),
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.rustfmt,

		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.formatting.beautysh,
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
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ buffer = bufnr, group = augroup })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end,
})
vim.api.nvim_create_user_command("DisableLspFormatting", function()
	vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
end, { nargs = 0 })
