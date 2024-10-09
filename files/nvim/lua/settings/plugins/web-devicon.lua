return {
	"nvim-tree/nvim-web-devicons",
	priority = 1000,
	config = function()
		require("nvim-web-devicons").setup({
			override = {
				gql = {
					icon = "",
					color = "#e535ab",
					cterm_color = "199",
					name = "GraphQL",
				},
			},
			color_icons = true,
		})
	end,
}
