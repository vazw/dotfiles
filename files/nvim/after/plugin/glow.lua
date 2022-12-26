local status, glow = pcall(require, "glow")
if not status then
	return
end

glow.setup({
	-- your override config
	style = "dark",
})
