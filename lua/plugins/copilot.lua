return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			suggestion = {
				enabled = false,
			},
			panel = {
				enabled = false,
			},
			copilot_model = "gpt-41-copilot",
		},
		copilot_node_command = "node",
		config = function(_, opts)
			require("copilot").setup(opts)
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = {
			"zbirenbaum/copilot.lua",
			"hrsh7th/nvim-cmp",
		},
		opts = {},
	},
	{
		"olimorris/codecompanion.nvim",
		version = "v17.*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"rcarriga/nvim-notify",
			"nvim-lualine/lualine.nvim",
			{
				"ravitemer/mcphub.nvim",
				build = "volta install mcp-hub@latest",
			},
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
				"MeanderingProgrammer/render-markdown.nvim",
				ft = { "markdown", "codecompanion" },
				opts = function(_, opts)
					vim.cmd([[cab md :lua require('render-markdown').buf_toggle()]])
					vim.api.nvim_create_autocmd("BufRead", {
						pattern = "*.md",
						callback = function()
							require("render-markdown").buf_disable()
						end,
					})
					sign = { enabled = false }
				end,
			},
			{
				"HakonHarnes/img-clip.nvim",
				opts = {
					filetypes = {
						codecompanion = {
							prompt_for_file_name = false,
							template = "[Image]($FILE_PATH)",
							use_absolute_path = true,
						},
					},
				},
			},
		},
		init = function()
			vim.keymap.set("n", "<Leader>cc", "<cmd>CodeCompanionChat Toggle<CR>", { noremap = true, silent = true })
			vim.keymap.set("n", "<Leader>ca", "<cmd>CodeCompanionActions<CR>", { noremap = true, silent = true })
			vim.cmd([[cab cc CodeCompanion]])
			vim.cmd([[cab ci CodeCompanion #{buffer}]])
			vim.cmd([[cab ca CodeCompanionActions]])
		end,
		opts = function(_, opts)
			local copilot_model = "gpt-5"
			local prompts = require("prompts.style-guide")
			local git_workflows = require("prompts.gitcommit")
			local workflows = {
				["Translate Buffer JP -> EN"] = require("workflows.buffer-translator").workflow("Japanese", "English"),
				["Translate Buffer EN -> JP"] = require("workflows.buffer-translator").workflow("English", "Japanese"),
			}
			opts.prompt_library = vim.tbl_deep_extend("force", prompts, git_workflows, workflows)
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
				},
				diff = {
					enabled = true,
					close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
					layout = "vertical", -- vertical|horizontal split for default provider
					opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
					provider = "mini_diff", -- default|mini_diff
				},
				action_palette = {
					-- width = 95,
					height = 50,
					prompt = "Prompt ",
					-- provider = "default",
					opts = {
						show_default_actions = false,
						show_default_prompt_library = true,
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
				http = {
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
				},
			}
			opts.strategies = {
				chat = {
					adapter = {
						name = "copilot",
						model = copilot_model,
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
							return "  (" .. adapter.formatted_name .. ")"
						end,
						user = "  Me",
					},
				},
				inline = {
					adapter = {
						name = "copilot",
						model = copilot_model,
					},
				},
				cmd = {
					adapter = {
						name = "copilot",
						model = copilot_model,
					},
				},
			}
			opts.extensions = {
				mcphub = {
					callback = "mcphub.extensions.codecompanion",
					opts = {
						make_vars = false,
						make_slash_commands = true,
						show_result_in_chat = true,
					},
				},
				vectorcode = {
					---@type VectorCode.CodeCompanion.ExtensionOpts
					opts = {
						make_vars = false,
						tool_group = {
							-- this will register a tool group called `@vectorcode_toolbox` that contains all 3 tools
							enabled = true,
							-- a list of extra tools that you want to include in `@vectorcode_toolbox`.
							-- if you use @vectorcode_vectorise, it'll be very handy to include
							-- `file_search` here.
							extras = {},
							collapse = false, -- whether the individual tools should be shown in the chat
						},
						tool_opts = {
							---@type VectorCode.CodeCompanion.ToolOpts
							["*"] = {},
							---@type VectorCode.CodeCompanion.LsToolOpts
							ls = {},
							---@type VectorCode.CodeCompanion.VectoriseToolOpts
							vectorise = {},
							---@type VectorCode.CodeCompanion.QueryToolOpts
							query = {
								max_num = { chunk = -1, document = -1 },
								default_num = { chunk = 50, document = 10 },
								include_stderr = false,
								use_lsp = false,
								no_duplicate = true,
								chunk_mode = false,
								---@type VectorCode.CodeCompanion.SummariseOpts
								summarise = {
									---@type boolean|(fun(chat: CodeCompanion.Chat, results: VectorCode.QueryResult[]):boolean)|nil
									enabled = false,
									adapter = nil,
									query_augmented = true,
								},
							},
							files_ls = {},
							files_rm = {},
						},
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
	{
		"Davidyz/VectorCode",
		version = "*", -- optional, depending on whether you're on nightly or release
		build = "uv tool upgrade vectorcode",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "VectorCode", -- if you're lazy-loading VectorCode
	},
}
