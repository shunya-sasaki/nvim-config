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
				options = { theme = "auto" }
			else
				options = {
					theme = "auto",
					icons_enabled = false,
					component_separators = { left = "»", right = "«" },
					section_separators = { left = "»", right = "«" },
				}
			end
			opts.globalstatus = true
			opts.options = options
			opts.tabline = {
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
			}
			opts.sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { require("components.statusline_spinner") },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			}
		end,
	},
}
