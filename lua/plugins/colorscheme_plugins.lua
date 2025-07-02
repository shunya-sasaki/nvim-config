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
	{ "tanvirtin/monokai.nvim" },
	{ "catppuccin/nvim" },
	{ "EdenEast/nightfox.nvim" },
	{ "rebelot/kanagawa.nvim" },
	{ "navarasu/onedark.nvim" },
	{ "marko-cerovac/material.nvim" },
	{ "sainnhe/sonokai" },
	{ "scottmckendry/cyberdream.nvim" },
}
