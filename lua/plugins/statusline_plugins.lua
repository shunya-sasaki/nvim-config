return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			opts = function(_, opts)
				if Config.with_nf then
					require("nvim-web-devicons").setup({
						override = {
							toml = { icon = "" },
						},
					})
				end
			end,
		},
		opts = function(_, opts)
			local options = nil
			if Config.with_nf then
				options = { theme = "onedark" }
			else
				options = {
					theme = "onedark",
					icons_enabled = false,
					component_separators = { left = "»", right = "«" },
					section_separators = { left = "»", right = "«" },
				}
			end
			require("lualine").setup({
				globalstatus = true,
				options = options,
				tabline = {
					lualine_a = {
						{
							"buffers",
							mode = 4,
							icons_enabled = true,
							show_filename_only = true,
							hide_filename_extensions = false,
						},
					},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = { "tabs" },
				},
			})
		end,
	},
}
