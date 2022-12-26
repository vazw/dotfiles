local status, nvimtree = pcall(require, "nvim-tree")
if not status then
	return
end

nvimtree.setup({
	disable_netrw = false,
	hijack_cursor = false,
	hijack_netrw = true,
	hijack_unnamed_buffer_when_opening = false,
	ignore_buffer_on_setup = false,
	open_on_setup = false,
	reload_on_bufenter = false,
	open_on_setup_file = false,
	sort_by = "case_sensitive",
	view = {
		adaptive_size = true,
		mappings = {
			list = {
				{ key = "u", action = "dir_up" },
			},
		},
	},
	renderer = {
		group_empty = true,
	},
	hijack_directories = {
		enable = false,
		auto_open = false,
	},
	filters = {
		dotfiles = true,
	},
})
