return {
	"lukas-reineke/indent-blankline.nvim",
	priority = 1000,
	config = function()
		local indent = require("ibl")
		indent.setup()
	end,
}
