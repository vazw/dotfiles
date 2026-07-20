return {
	diagnostics = {
		underline = true,
		update_in_insert = true,
		virtual_text = {
			spacing = 4,
			source = "if_many",
			prefix = "●",
			-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
			-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
			-- prefix = "icons",
		},
		severity_sort = true,
		signs = {
			priority = 1,
			text = {
				[vim.diagnostic.severity.ERROR] = " ",
				[vim.diagnostic.severity.WARN] = " ",
				[vim.diagnostic.severity.HINT] = "󰠠 ",
				[vim.diagnostic.severity.INFO] = " ",
			},
		},
	},

	capabilities = {
		workspace = {
			fileOperations = {
				didRename = true,
				willRename = true,
			},
		},
	},

	format = {
		timeout_ms = 1000,
	},

	-- LSP SERVERS HERE
	servers = {
		pyright = {
			settings = {
				pyright = {
					-- Using Ruff's import organizer
					disableOrganizeImports = true,
				},
				python = {
					analysis = {
						-- Ignore all files for analysis to exclusively use Ruff for linting
						ignore = { "*" },
					},
				},
			},
		},

		jsonls = {
			settings = {
				json = {
					format = {
						enable = true,
					},
				},
				validate = { enable = true },
			},
		},

		cssls = {},
		clangd = {
			enabled = false,
			keys = {
				{ "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
			},
			root_dir = function(fname)
				return require("lspconfig.util").root_pattern(
					"Makefile",
					"configure.ac",
					"configure.in",
					"config.h.in",
					"meson.build",
					"meson_options.txt",
					"build.ninja"
				)(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
					fname
				) or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
			end,
			capabilities = {
				offsetEncoding = { "utf-16" },
			},
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=iwyu",
				"--completion-style=detailed",
				"--function-arg-placeholders",
				"--fallback-style=llvm",
			},
			init_options = {
				usePlaceholders = true,
				completeUnimported = true,
				clangdFileStatus = true,
			},
		},

		ruff = {
			on_attach = function(client, _bufnr)
				if client.name == "ruff_lsp" then
					-- Disable hover in favor of Pyright
					client.server_capabilities.hoverProvider = false
				end
			end,
		},
		vtsls = { enabled = false },
		bacon_ls = {
			enabled = false,
			init_options = {
				updateOnSave = true,
				updateOnSaveWaitMillis = 1000,
			},
		},

		rust_analyzer = {
			enabled = true,
			-- autostart = false,
			settings = {
				-- rust-analyzer language server configuration
				["rust-analyzer"] = {
					imports = {
						granularity = {
							group = "module",
						},
						prefix = "self",
					},
					cargo = {
						allFeatures = true,
						allTargets = true,
						loadOutDirsFromCheck = true,
						buildScripts = {
							enable = true,
						},
					},
					check = {
						command = "clippy",
						extraArgs = {
							"--no-deps",
							"--tests",
						},
						workspace = true,
					},
					checkOnSave = true,
					diagnostics = { enable = true },
					procMacro = {
						enable = true,
						ignored = {
							["async-trait"] = { "async_trait" },
							["napi-derive"] = { "napi" },
							["async-recursion"] = { "async_recursion" },
							-- leptos_macro = { "server", "component" },
						},
					},
					files = {
						excludeDirs = {
							".direnv",
							".git",
							".github",
							".gitlab",
							"bin",
							"node_modules",
							"target",
							"venv",
							".venv",
							"registry",
						},
					},
				},
			},
		},
		tailwindcss = {
			root_dir = function(...)
				return require("lspconfig.util").root_pattern("tailwind.config.js")(...)
			end,
			filetypes = { "html", "css", "rust" },
			settings = {
				tailwindCSS = {
					includeLanguages = {
						rust = "html",
					},
				},
			},
		},

		ts_ls = {
			-- root_dir = function(...)
			--   return require("lspconfig.util").root_pattern(".git")(...)
			-- end,
			settings = {
				typescript = {
					inlayHints = {
						includeInlayParameterNameHints = "literal",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = false,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
				javascript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
			},
		},

		zls = {},
		html = {},
		phpactor = {
			enabled = true,
		},
		marksman = {},

		tinymist = {
			single_file_support = true,
			filetypes = { "typst" },
			settings = {
				exportPdf = "onSave",
			},
		},
		typos_lsp = {
			enabled = true,
			autostart = false,
			init_options = {
				config = "~/.config/typos.toml",
			},
		},

		bashls = {},

		lua_ls = {
			enabled = true,
			single_file_support = true,
			settings = {
				Lua = {
					workspace = {
						checkThirdParty = false,
						library = vim.api.nvim_get_runtime_file("", true),
					},
					-- completion = {
					--   callSnippet = "Disable",
					--   keywordSnippet = "Disable",
					-- },
					misc = {
						parameters = {
							-- "--log-level=trace",
						},
					},
					hint = {
						enable = true,
						setType = false,
						paramType = true,
						paramName = "Disable",
						semicolon = "Disable",
						arrayIndex = "Disable",
					},
					doc = {
						privateName = { "^_" },
					},
					type = {
						castNumberToInteger = true,
					},
					diagnostics = {
						globals = { "vim", "require" },
						disable = { "incomplete-signature-doc", "trailing-space" },
						-- enable = false,
						groupSeverity = {
							strong = "Warning",
							strict = "Warning",
						},
						groupFileStatus = {
							["ambiguity"] = "Opened",
							["await"] = "Opened",
							["codestyle"] = "None",
							["duplicate"] = "Opened",
							["global"] = "Opened",
							["luadoc"] = "Opened",
							["redefined"] = "Opened",
							["strict"] = "Opened",
							["strong"] = "Opened",
							["type-check"] = "Opened",
							["unbalanced"] = "Opened",
							["unused"] = "Opened",
						},
						unusedLocalExclude = { "_*" },
					},
					format = {
						enable = true,
						defaultConfig = {
							indent_style = "space",
							indent_size = "2",
							continuation_indent_size = "2",
						},
					},
				},
			},
		},
	},
}
