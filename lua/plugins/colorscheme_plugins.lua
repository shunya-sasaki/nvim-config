return {
	{
		"folke/tokyonight.nvim",
		priority = 10000,
		lazy = false,
		config = function()
			require("tokyonight").setup({
				transparent = true,
				terminal_colors = true,
				styles = {
					sidebars = "transparent",
					floats = "transparent",
				},
			})
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		"catppuccin/nvim",

		config = function()
			require("catppuccin").setup({
				transparent_background = true,
				term_colors = true,
			})
		end,
	},
	{
		"EdenEast/nightfox.nvim",
		config = function()
			require("nightfox").setup({
				options = {
					transparent = true,
					terminal_colors = true,
					dim_inactive = false,
					module_default = true,
				},
			})
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				undercurl = true,
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { italic = true },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = true,
				dimInactive = false,
				terminalColors = true,
				colors = {
					palette = {},
					theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
				},
				overrides = function(colors)
					return {}
				end,
				theme = "wave",
				background = {
					dark = "wave",
					light = "lotus",
				},
			})
		end,
	},
	{
		"navarasu/onedark.nvim",
		config = function()
			require("onedark").setup({
				style = "dark",
				transparent = true,
				term_colors = true,
				ending_tildes = false,
				cmp_itemkind_reverse = false,
				toggle_style_key = nil,
				toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" },
				code_style = {
					comments = "italic",
					keywords = "none",
					functions = "none",
					strings = "none",
					variables = "none",
				},
				lualine = {
					transparent = true,
				},
				colors = {},
				highlights = {},
				diagnostics = {
					darker = true,
					undercurl = true,
					background = true,
				},
			})
		end,
	},
	{ "marko-cerovac/material.nvim" },
	{
		"sainnhe/sonokai",
		config = function()
			vim.g.sonokai_style = "default"
			vim.g.sonokai_enable_italic = true
			vim.g.sonokai_transparent_background = 2
		end,
	},
	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority = 10000,
		config = function()
			require("cyberdream").setup({
				variant = "default",
				transparent = true,
				saturation = 1.0,
				italic_comments = true,
				hide_fillchars = false,
				borderless_pickers = false,
				terminal_colors = true,
			})
		end,
	},
}
