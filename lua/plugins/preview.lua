return {
	{
		"hedyhli/markdown-toc.nvim",
		ft = "markdown", -- Lazy load on markdown filetype
		cmd = { "Mtoc" }, -- Or, lazy load on "Mtoc" command
		opts = {
			headings = {
				before_toc = false,
				pattern = "^(###?)%s+(.+)$",
			},
			fences = {
				enabled = true,
				start_text = "toc",
				end_text = "/toc",
			},
			auto_update = true,
			toc_list = {
				markers = "-",
				cycle_markers = false,
			},
		},
	},
}
