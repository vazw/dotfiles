local status, indents = pcall(require, "indent_blankline")
if not status then
	return
end

indents.setup({
	-- for example, context is off by default, use this to turn it on
	show_current_context = true,
	show_current_context_start = true,
})
