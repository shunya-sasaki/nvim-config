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
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			{
				"echasnovski/mini.diff",
				opts = function(_, opts)
					local diff = require("mini.diff")
					diff.setup({
						source = diff.gen_source.none(),
					})
				end,
			},
		},
		init = function()
			vim.keymap.set("n", "<Leader>cc", "<cmd>CodeCompanionChat Toggle<CR>", { noremap = true, silent = true })
		end,
		opts = {
			display = {
				chat = {
					-- Change the default icons
					icons = {
						pinned_buffer = " ",
						watched_buffer = "👀 ",
					},
					intro_message = "Welcome to CodeCompanion ✨! Press ? for options",
					show_header_separator = true, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
					separator = "─", -- The separator between the different messages in the chat buffer
					show_references = true, -- Show references (from slash commands and variables) in the chat buffer?
					show_settings = false, -- Show LLM settings at the top of the chat buffer?
					show_token_count = true, -- Show the token count for each response?
					start_in_insert_mode = false, -- Open the chat buffer in insert mode?
				},
				diff = {
					enabled = true,
					close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
					layout = "vertical", -- vertical|horizontal split for default provider
					opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
					provider = "mini_diff", -- default|mini_diff
				},
				-- Alter the sizing of the debug window
				debug_window = {
					---@return number|fun(): number
					width = vim.o.columns - 5,
					---@return number|fun(): number
					height = vim.o.lines - 2,
				},

				-- Options to customize the UI of the chat buffer
				window = {
					layout = "vertical", -- float|vertical|horizontal|buffer
					position = nil, -- left|right|top|bottom (nil will default depending on vim.opt.splitright|vim.opt.splitbelow)
					border = "single",
					height = 0.8,
					width = 0.45,
					relative = "editor",
					full_height = true, -- when set to false, vsplit will be used to open the chat buffer vs. botright/topleft vsplit
					opts = {
						breakindent = true,
						cursorcolumn = false,
						cursorline = false,
						foldcolumn = "0",
						linebreak = true,
						list = false,
						numberwidth = 1,
						signcolumn = "no",
						spell = false,
						wrap = true,
					},
				},
				---Customize how tokens are displayed
				---@param tokens number
				---@param adapter CodeCompanion.Adapter
				---@return string
				token_count = function(tokens, adapter)
					return " (" .. tokens .. " tokens)"
				end,
			},
			adapters = {
				llama3 = function()
					return require("codecompanion.adapters").extend("ollama", {
						name = "llama3.2",
						schema = {
							model = {
								default = "llama3.2:latest",
							},
						},
					})
				end,
				azure_openai = function()
					return require("codecompanion.adapters").extend("azure_openai", {
						env = {
							api_key = os.getenv("AZURE_OPENAI_API_KEY"),
							api_base = os.getenv("AZURE_OPENAI_ENDPOINT"),
						},
						schema = {
							model = {
								default = os.getenv("AZURE_OPENAI_MODEL"),
							},
						},
					})
				end,
			},
			strategies = {
				chat = {
					adapter = {
						name = "copilot",
						model = "gpt-4.1",
					},
					keymaps = {
						send = {
							modes = { n = "<C-s>", i = "<C-s>" },
							opts = {},
						},
						close = {
							modes = { n = "<C-c>", i = "<C-c>" },
							opts = {},
						},
					},
					roles = {
						llm = function(adapter)
							return "  CodeCompanion (" .. adapter.formatted_name .. ")"
						end,
						user = "  Me",
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
	},
}
