return {
	"jose-elias-alvarez/null-ls.nvim", -- configure formatters & linters
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- import null-ls plugin
		local null_ls = require("null-ls")

		local null_ls_utils = require("null-ls.utils")

		-- for conciseness
		local formatting = null_ls.builtins.formatting -- to setup formatters
		local diagnostics = null_ls.builtins.diagnostics -- to setup linters

		-- to setup format on save
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		local rustfmt_setting = {}

		local util = require("lspconfig/util")
		local cargo_path = util.root_pattern("Cargo.toml")(vim.fn.getcwd())
		if cargo_path then
			local leptos_path = util.root_pattern("leptosfmt.toml")(vim.fn.getcwd())
			if leptos_path then
				rustfmt_setting.command = "leptosfmt"
				rustfmt_setting.extra_args = { "-m", "80" }
			else
				rustfmt_setting.extra_args = { "--config", "max_width=80" }
			end
		end

		-- print("Rustfmt table" .. vim.inspect(rustfmt_setting))

		-- configure null_ls
		null_ls.setup({
			-- add package.json as identifier for root (for typescript monorepos)
			root_dir = null_ls_utils.root_pattern(
				".null-ls-root",
				"Makefile",
				".git",
				"package.json",
				"Cargo.toml",
				"requirements.txt"
			),
			-- setup formatters & linters
			sources = {
				--  to disable file types use
				--  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
				-- Python
				formatting.ruff.with({
					command = "ruff",
					extra_args = { "format", "--line-length", "80", "." },
				}),
				formatting.clang_format,
				formatting.rustfmt.with(rustfmt_setting),

				diagnostics.shellcheck,
				formatting.beautysh,
				formatting.prettier.with({
					extra_filetypes = { "svelte" },
				}), -- js/ts formatter
				formatting.stylua, -- lua formatter
				diagnostics.eslint_d.with({
					-- js/ts linter
					condition = function(utils)
						return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs" }) -- only enable if root has .eslintrc.js or .eslintrc.cjs
					end,
				}),
			},
			-- configure format on save
			on_attach = function(current_client, bufnr)
				if current_client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								filter = function(client)
									--  only use null-ls for formatting instead of lsp server
									return client.name == "null-ls"
								end,
								bufnr = bufnr,
								timeout_ms = 5000,
							})
						end,
					})
				end
			end,
		})
	end,
}
