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
			"rcarriga/nvim-notify",
			"nvim-lualine/lualine.nvim",
			{
				"echasnovski/mini.diff",
				config = function()
					local diff = require("mini.diff")
					diff.setup({
						source = diff.gen_source.none(),
						mappings = {
							apply = "",
							reset = "",
							textobject = "",
						},
					})
				end,
			},
			{
				{
					"MeanderingProgrammer/render-markdown.nvim",
					ft = { "markdown", "codecompanion" },
					opts = {
						sign = { enabled = false },
					},
				},
			},
		},
		init = function()
			vim.keymap.set("n", "<Leader>cc", "<cmd>CodeCompanionChat Toggle<CR>", { noremap = true, silent = true })
			vim.cmd([[cab cc CodeCompanion]])
			vim.cmd([[cab ci CodeCompanion #{buffer}]])
		end,
		opts = function(_, opts)
			opts.display = {
				chat = {
					-- Change the default icons
					icons = {
						pinned_buffer = " ",
						watched_buffer = "👀 ",
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
						layout = "float", -- float|vertical|horizontal|buffer
						position = nil, -- left|right|top|bottom (nil will default depending on vim.opt.splitright|vim.opt.splitbelow)
						border = "single",
						height = 0.8,
						width = 0.8,
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
						intro_message = "Welcome to CodeCompanion ✨! Press ? for options",
						show_header_separator = true, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
						separator = "─", -- The separator between the different messages in the chat buffer
						show_references = true, -- Show references (from slash commands and variables) in the chat buffer?
						show_settings = false, -- Show LLM settings at the top of the chat buffer?
						show_token_count = false, -- Show the token count for each response?
						start_in_insert_mode = false, -- Open the chat buffer in insert mode?
					},
					diff = {
						enabled = true,
						close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
						layout = "vertical", -- vertical|horizontal split for default provider
						opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
						provider = "mini_diff", -- default|mini_diff
					},
					action_palette = {
						width = 95,
						heihgt = 10,
						prompt = "Prompt ",
						provider = "default",
						opts = {
							show_default_actions = true,
							show_default_prompt_library = true,
						},
					},
				},
				---Customize how tokens are displayed
				---@param tokens number
				---@param adapter CodeCompanion.Adapter
				---@return string
				token_count = function(tokens, adapter)
					return " (" .. tokens .. " tokens)"
				end,
			}
			opts.adapters = {
				gemini = function()
					return require("codecompanion.adapters").extend("gemini", {
						env = {
							api_key = os.getenv("GEMINI_API_KEY"),
						},
						schema = {
							model = {
								default = "gemini-2.5-pro",
							},
						},
					})
				end,
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
			}
			opts.strategies = {
				chat = {
					adapter = {
						name = "copilot",
						model = "gpt-4.1",
					},
					keymaps = {
						send = {
							callback = function(chat)
								require("components.chat_spinner"):init()
								vim.cmd("stopinsert")
								chat:submit()
								chat:add_buf_message({ role = "llm", content = "" })
							end,
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
							return "  (" .. adapter.formatted_name .. ")"
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
			}
			-- hooks
			local spinner_symbols = {
				"⠋",
				"⠙",
				"⠹",
				"⠸",
				"⠼",
				"⠴",
				"⠦",
				"⠧",
				"⠇",
				"⠏",
			}
			local group = vim.api.nvim_create_augroup("CodeCompanionNotify", {})
			local notify = require("notify")
			local request_notify = nil
			local notify_title = "CodeCompanion"
			local timer = vim.loop.new_timer()
			local spinner_symbols_len = 10
			local i_spinner = 1
			vim.api.nvim_create_autocmd({ "User" }, {
				pattern = "CodeCompanion*",
				group = group,
				callback = function(request)
					-- Notify when CodeCompanion request starts.
					local function start_request()
						request_notify = notify(" CodeCompanion Request Started", "info", {
							title = notify_title,
							timeout = false,
						})
						timer:start(
							0,
							50,
							vim.schedule_wrap(function()
								if not request_notify then
									timer:stop()
									return
								end
								i_spinner = (i_spinner % #spinner_symbols) + 1
								request_notify = notify(
									" " .. spinner_symbols[i_spinner] .. " CodeCompanion Processing...",
									"info",
									{
										title = notify_title,
										replace = request_notify,
										timeout = false,
									}
								)
							end)
						)
					end
					local function finish_request()
						notify(" CodeCompanion Request Finished", "info", {
							title = notify_title,
							replace = request_notify,
							timeout = 5000,
						})
						request_notify = nil
					end
					local notify = require("notify")
					if request.match == "CodeCompanionRequestStarted" then
						start_request()
					elseif request.match == "CodeCompanionRequestFinished" then
						finish_request()
					end
				end,
			})
		end,
	},
}
