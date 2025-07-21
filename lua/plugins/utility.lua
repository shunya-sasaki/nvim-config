return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = function(opts, _)
			opts.presets = {
				bottom_search = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = false,
				command_palette = {
					views = {
						cmdline_popup = {
							position = {
								row = "50%",
								col = "50%",
							},
							width = "auto",
							height = "auto",
						},
					},
				},
			}
			opts.lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			}
		end,
	},
}
