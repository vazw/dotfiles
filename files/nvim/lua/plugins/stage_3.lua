-- NOTE: Load appearance such as Colorizer, Icons/Themes and Git things
-- *OR* plugin that depend on filetype *OR* per projects

---------------------------------------------------------------------
local have_autopair, autopair = pcall(require, "nvim-autopairs")
if have_autopair then
	autopair.setup()
end
local have_autotag, autotag = pcall(require, "nvim-ts-autotag")
if have_autotag then
	autotag.setup({
		opts = {
			-- Defaults
			enable_close = true, -- Auto close tags
			enable_rename = true, -- Auto rename pairs of tags
			enable_close_on_slash = false, -- Auto close on trailing </
		},
	})
end

-- PLUGIN: fzf
local have_fzf, fzf = pcall(require, "fzf-lua")
if have_fzf then
	fzf.setup({
		files = {
			actions = {
				["ctrl-u"] = function(_, opts)
					local parent = vim.fn.fnamemodify(opts.cwd or vim.uv.cwd() or vim.fn.getcwd(), ":h")
					fzf.files({ cwd = parent })
				end,
			},
		},
	})

	vim.keymap.set("n", "sf", function()
		fzf.files()
	end, { desc = "File File" })

	vim.keymap.set("n", "sF", function()
		-- require("fzf-lua").files({ cwd = vim.fn.getcwd() })
		fzf.files({ cwd = vim.fn.expand("%:p:h") })
	end, { desc = "File File" })

	-- vim.keymap.set("n", ";e", function()
	--   require("fzf-lua").live_grep()
	-- end, { desc = "Live Grep" })
	--
	vim.keymap.set("n", ";r", function()
		fzf.live_grep()
	end, { desc = "Live Grep" })

	-- vim.keymap.set("n", ";r", function()
	--   require("fzf-lua").live_grep({resume=true})
	-- end, { desc = "Live Grep Resume" })
	--
	vim.keymap.set("n", ";e", function()
		require("fzf-lua").lsp_document_diagnostics()
	end, { desc = "Document Diagnostics" })

	vim.keymap.set("n", ";;", function()
		require("fzf-lua").lsp_workspace_diagnostics()
	end, { desc = "Workspace Diagnostics" })

	vim.keymap.set("n", "<leader>ca", function()
		require("fzf-lua").lsp_code_actions()
	end, { desc = "Code Action", silent = true })

	vim.keymap.set("n", ";q", function()
		require("fzf-lua").lgrep_quickfix()
	end, { desc = "Live Grep QuickFix", silent = true })

	vim.keymap.set("n", ";b", function()
		require("fzf-lua").buffers()
	end, { desc = "Buffers" })

	-- Custom Fzf Menu

	local rules = {
		Golang = {
			Function = [[^func +(?:\([a-zA-Z0-9_]+ +\*?[a-zA-Z0-9_]+(?:\[.+\])?\))? *[A-Z][a-zA-Z0-9_]* -- !*test* ]],
			Type = [[^type +[A-Z][a-zA-Z0-9_]+ -- !*test* ]],
		},
		Odin = {
			Function = [[^[a-zA-Z0-9_]+ +:: +proc -- !*test* ]],
			Type = [[^\w+ +:: +(?:struct|union|enum|distinct) -- !*test* ]],
		},
		Lua = {
			Function = [[(?:function [a-zA-Z0-9_]+\(|[a-zA-Z0-9_]+ = function\(|= def\()]],
		},
		Rust = {
			-- We don't filter by file extension because Rust API searches often target
			-- individual files, unlike Go or Odin, where the package system makes it
			-- more common to search the entire directory.
			Function_and_Macro = [[(^\s*pub (const )?(unsafe )?fn +[a-zA-Z0-9_#]+|^\s*macro_rules! [a-zA-Z0-9_#]+|^impl )]],
			Type = [[^\s*pub (?:struct|union|enum|trait|type) [a-zA-Z0-9_#]+]],
		},
	}

	local parse_programming_language = function(path)
		if path:match("%.go$") or path == "go.mod" then
			return "Golang"
		elseif path:match("%.odin$") then
			return "Odin"
		elseif path:match("%.lua$") then
			return "Lua"
		elseif path:match("%.rs$") or path:lower() == "cargo.toml" then
			return "Rust"
		end
		return nil
	end

	local module_api_search = function(cwd)
		local path = vim.api.nvim_buf_get_name(0)
		local operation = fzf.grep

		local programming_language = nil
		if not path:match("^oil://.*") then
			programming_language = parse_programming_language(path)
		else
			if not cwd then
				cwd = vim.uv.cwd()
			end
			local handle = vim.uv.fs_scandir(cwd)
			if handle then
				while true do
					local name, t = vim.uv.fs_scandir_next(handle)
					if not name then
						break
					end
					if t == "file" then
						programming_language = parse_programming_language(name)
						if programming_language then
							break
						end
					end
				end
			end
		end
		if programming_language == nil then
			fzf.live_grep()
			return
		else
			if not path:match("^oil://.*") and (programming_language == "Rust" or programming_language == "Lua") then
				operation = fzf.grep_curbuf
			end
			local items = {}
			for item in pairs(rules[programming_language]) do
				table.insert(items, item)
			end
			table.sort(items)
			table.insert(items, "Any")
			fzf.fzf_exec(items, {
				prompt = string.format("Search Package (%s) > ", programming_language),
				actions = {
					["default"] = function(selected, opts)
						if selected == nil then
							return
						end
						selected = selected[1]
						if selected == "Any" then
							fzf.live_grep()
						else
							operation({
								search = rules[programming_language][selected],
								no_esc = true,
								-- Error: unable to init vim.regex
								-- https://github.com/ibhagwan/fzf-lua/issues/1858#issuecomment-2689899556
								-- The message is mostly informational, this happens due to the
								-- previewer trying to convert the regex to vim magic pattern (in
								-- order to highlight it), but not all cases can be covered so the
								-- previewer will highlight the cursor column only (instead of the
								-- entire pattern).
								silent = true,
							})
						end
					end,
				},
			})
		end
	end

	vim.keymap.set("n", "<C-Space>", fzf.builtin, { desc = "fzf builtin" })
	vim.keymap.set("n", "<leader>cd", function()
		module_api_search(vim.fn.expand("%:p:h"))
	end, { desc = "fzf api search" })

	FzfLua.register_ui_select()
end

local miniclue = require("mini.clue")
miniclue.setup({
	triggers = {
		-- Leader triggers
		{ mode = "n", keys = "<Leader>" },
		{ mode = "x", keys = "<Leader>" },

		-- Built-in completion
		{ mode = "i", keys = "<C-x>" },

		-- `g` key
		{ mode = "n", keys = "g" },
		{ mode = "x", keys = "g" },

		{ mode = "n", keys = "f" },
		{ mode = "x", keys = "f" },

		{ mode = "n", keys = ";" },
		{ mode = "x", keys = ";" },

		-- Marks
		{ mode = "n", keys = "'" },
		{ mode = "n", keys = "`" },
		{ mode = "x", keys = "'" },
		{ mode = "x", keys = "`" },

		-- Registers
		{ mode = "n", keys = '"' },
		{ mode = "x", keys = '"' },
		{ mode = "i", keys = "<C-r>" },
		{ mode = "c", keys = "<C-r>" },

		-- Window commands
		{ mode = "n", keys = "<C-w>" },

		-- `z` key
		{ mode = "n", keys = "z" },
		{ mode = "x", keys = "z" },
	},

	clues = {
		-- Enhance this by adding descriptions for <Leader> mapping groups
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
		miniclue.gen_clues.z(),
	},
})

local hi = require("mini.hipatterns")
local color_opts = {
	-- custom LazyVim option to enable the tailwind integration
	tailwind = {
		enabled = true,
		ft = {
			"astro",
			"css",
			"heex",
			"html",
			"html-eex",
			"javascript",
			"javascriptreact",
			"rust",
			"svelte",
			"typescript",
			"typescriptreact",
			"vue",
		},
		-- full: the whole css class will be highlighted
		-- compact: only the color will be highlighted
		style = "full",
	},
	highlighters = {
		hex_color = hi.gen_highlighter.hex_color({ priority = 2000 }),
		fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
		hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
		warn = { pattern = "%f[%w]()WARN()%f[%W]", group = "DiagnosticSignWarn" },
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
		note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

		shorthand = {
			pattern = "()#%x%x%x()%f[^%x%w]",
			group = function(_, _, data)
				---@type string
				local match = data.full_match
				local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
				local hex_color = "#" .. r .. r .. g .. g .. b .. b

				return hi.compute_hex_color_group(hex_color, "bg")
			end,
			extmark_opts = { priority = 2000 },
		},
	},
}
if type(color_opts.tailwind) == "table" and color_opts.tailwind.enabled then
	-- reset hl groups when colorscheme changes
	local hi_colors = require("utils.colors")
	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = function()
			hi_colors.hl = {}
		end,
	})
	color_opts.highlighters.tailwind = {
		pattern = function()
			if not vim.tbl_contains(color_opts.tailwind.ft, vim.bo.filetype) then
				return
			end
			if color_opts.tailwind.style == "full" then
				return "%f[%w:-]()[%w:-]+%-[a-z%-]+%-%d+()%f[^%w:-]"
			elseif color_opts.tailwind.style == "compact" then
				return "%f[%w:-][%w:-]+%-()[a-z%-]+%-%d+()%f[^%w:-]"
			end
		end,
		group = function(_, _, m)
			---@type string
			local match = m.full_match
			---@type string, number
			local color, shade = match:match("[%w-]+%-([a-z%-]+)%-(%d+)")
			local nshade = tonumber(shade)
			if nshade then
				local bg = vim.tbl_get(hi_colors.colors, color, nshade)
				if bg then
					local hl = "hi_colorsiniHipatternsTailwind" .. color .. shade
					if not hi_colors.hl[hl] then
						hi_colors.hl[hl] = true
						local bg_shade = nshade == 500 and 950 or nshade < 500 and 900 or 100
						local fg = vim.tbl_get(hi_colors.colors, color, bg_shade)
						vim.api.nvim_set_hl(0, hl, { bg = "#" .. bg, fg = "#" .. fg })
					end
					return hl
				end
			end
		end,
		extmark_opts = { priority = 2000 },
	}
end
hi.setup(color_opts)

if vim.bo.filetype == "typst" then
	require("typst-preview").update()
	require("typst-preview").setup()
end
