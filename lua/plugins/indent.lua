return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {
			indent = {
				char = "▏",
				priority = 1,
				smart_indent_cap = true,
				repeat_linebreak = false,
			},
			scope = {
				enabled = false,
			},
		},
	},
}
