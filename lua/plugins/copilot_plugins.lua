return {
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_filetypes = {
				["gitcommit"] = true,
			}
		end,
	},
	{
		"olimorris/codecompanion.nvim",
		opts = {
			adapters = {
				llama3 = function()
					return require("codecompanion.adapters").extend("ollama"),
						{
							name = "llama3.2",
							schema = {
								model = {
									default = "llama3.2:latest",
								},
							},
						}
				end,
				azure_openai = function()
					return require("codecompanion.adapters").extend("azure_openai"),
						{
							env = {
								api_key = os.getenv("AZURE_OPENAI_API_KEY"),
								api_base = os.getenv("AZURE_OPENAI_ENDPOINT"),
							},
							schema = {
								model = {
									default = os.getenv("AZURE_OPENAI_MODEL"),
								},
							},
						}
				end,
			},
			strategies = {
				chat = {
					adapter = {
						name = "copilot",
						model = "gpt-4.1",
					},
				},
				inline = {
					adapter = {
						name = "copilot",
						model = "gpt-4.1",
					},
				},
				cmd = {
					adapter = {
						name = "copilot",
						model = "gpt-4.1",
					},
				},
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
}
