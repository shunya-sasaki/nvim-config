return {
	{
		"folke/tokyonight.nvim",
		priority = 10000,
		opts = function(_, opts)
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
}
