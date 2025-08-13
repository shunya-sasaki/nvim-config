return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			styles = {
				snacks_image = {
					relative = "cursor", -- cursor, win, editor
					border = "rounded",
					focusable = false,
					backdrop = false,
					row = 1,
					col = 1,
				},
			},
			image = {
				enabled = true,
				doc = { enabled = true, inline = false, float = false, max_width = 80, max_height = 60 },
			},
			bigfile = { enabled = false },
			dashboard = { enabled = false },
			explorer = { enabled = false },
			indent = { enabled = false },
			input = { enabled = false },
			picker = { enabled = false },
			notifier = { enabled = false },
			quickfile = { enabled = false },
			scope = { enabled = false },
			scroll = { enabled = false },
			statuscolumn = { enabled = false },
			words = { enabled = false },
		},
	},
}
