local status, nvimtree = pcall(require, "nvim-tree")
if not status then
	return
end

nvimtree.setup({
	disable_netrw = false,
	hijack_cursor = false,
	hijack_netrw = true,
	hijack_unnamed_buffer_when_opening = false,
	reload_on_bufenter = false,
	sort_by = "case_sensitive",
	view = {
		adaptive_size = true,
		mappings = {},
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
