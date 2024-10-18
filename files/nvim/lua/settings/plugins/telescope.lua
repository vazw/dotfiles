return {
	"nvim-telescope/telescope.nvim",
	priority = 1000,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-tree/nvim-web-devicons",
		"ThePrimeagen/harpoon",
		"nvim-telescope/telescope-file-browser.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	config = function()
		-- import telescope plugin safely
		local telescope = require("telescope")

		-- import telescope actions safely
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		-- import telescope-ui-select safely
		local themes = require("telescope.themes")

		local fb_actions = require("telescope").extensions.file_browser.actions

		-- configure telescope
		telescope.setup({
			-- configure custom mappings
			defaults = {
				path_display = { "truncate" },
				warp_results = true,
				-- layout_config = { prompt_position = "bottom" },
				-- sorting_strategy = "ascending",
				winblend = 0,
				mappings = {
					n = {
						["<ESC>"] = actions.close,
						["q"] = actions.close,
					},
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
					},
				},
			},
			extensions = {
				["ui-select"] = {
					themes.get_dropdown({}),
				},
				file_browser = {
					theme = "dropdown",
					-- disables netrw and use telescope-file-browser in its place
					hijack_netrw = true,
					mappings = {
						-- your custom insert mode mappings
						["i"] = {
							-- Delete Backward
							["<C-w>"] = function()
								vim.cmd("normal vbd")
							end,
						},
						["n"] = {
							-- your custom normal mode mappings
							["N"] = fb_actions.create,
							["h"] = fb_actions.goto_parent_dir,
							["/"] = function()
								vim.cmd("startinsert")
							end,
						},
					},
				},
			},
		})
		telescope.load_extension("ui-select")
		telescope.load_extension("file_browser")
		telescope.load_extension("fzf")

		local function telescope_buffer_dir()
			return vim.fn.expand("%:p:h")
		end
		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "sf", function()
			telescope.extensions.file_browser.file_browser({
				path = "%:p:h",
				cwd = telescope_buffer_dir(),
				respect_gitignore = false,
				hidden = true,
				grouped = true,
				previewer = false,
				initial_mode = "normal",
				layout_config = { height = 40 },
			})
		end)
		keymap.set("n", ";f", function()
			builtin.find_files({
				no_ignore = false,
				hidden = true,
			})
		end)
		keymap.set("n", ";r", function()
			builtin.live_grep()
		end)
		keymap.set("n", "\\\\", function()
			builtin.buffers()
		end)
		keymap.set("n", ";t", function()
			builtin.help_tags()
		end)
		keymap.set("n", ";;", function()
			builtin.resume()
		end)
		keymap.set("n", ";e", function()
			builtin.diagnostics()
		end)
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" }) -- find string under cursor in current working directory
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Show open buffers" }) -- list open buffers in current neovim instance
		keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Show git commits" }) -- list all git commits (use <cr> to checkout) ["gc" for git commits]
		keymap.set(
			"n",
			"<leader>gfc",
			"<cmd>Telescope git_bcommits<cr>",
			{ desc = "Show git commits for current buffer" }
		) -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
		keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Show git branches" }) -- list git branches (use <cr> to checkout) ["gb" for git branch]
		keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Show current git changes per file" }) -- list current changes per file with diff preview ["gs" for git status]
		keymap.set("n", "<leader>hf", "<cmd>Telescope harpoon marks<cr>", { desc = "Show harpoon marks" }) -- show harpoon marks
		-- toggle comment
		keymap.set("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>")
		keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")
	end,
}
