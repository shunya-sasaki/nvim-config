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
				enabled = false,
				start_text = "mtoc-start",
				end_text = "mtoc-end",
			},
			auto_update = true,
			toc_list = {
				markers = "-",
				cycle_markers = false,
			},
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = "cd app && npm install",
		config = function()
			vim.g.mkdp_theme = "dark"
			vim.g.mkdp_markdown_css = vim.fn.stdpath("config") .. "/css/github-markdown.css"
			vim.g.mkdp_highlight_css = vim.fn.stdpath("config") .. "/css/github-dark.css"
			vim.g.mkdp_auto_start = 0
			vim.g.mkdp_auto_close = 0
			vim.g.mkdp_refresh_slow = 0
			vim.g.mkdp_command_for_global = 0
			vim.g.mkdp_open_to_the_world = 0
			vim.g.mkdp_preview_options = {
				mkit = {},
				katex = {},
				uml = {},
				maid = {},
				disable_sync_scroll = 0,
				sync_scroll_type = "middle",
				hide_yaml_meta = 1,
				sequence_diagrams = {},
				flowchart_diagrams = {},
				content_editable = 1,
				disable_filename = 0,
				toc = {},
			}
			vim.g.mkdp_filetypes = { "markdown" }
		end,
	},
}
