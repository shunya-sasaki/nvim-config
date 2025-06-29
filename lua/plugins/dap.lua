return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			dap.adapters.codelldb = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
			}
			dap.configurations.cpp = {
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			}
			dap.adapters.python = function(cb, config)
				if config.request == "attach" then
					---@diagnostic disable-next-line: undefined-field
					local port = (config.connect or config).port
					---@diagnostic disable-next-line: undefined-field
					local host = (config.connect or config).host or "127.0.0.1"
					cb({
						type = "server",
						port = assert(port, "`connect.port` is required for a python `attach` configuration"),
						host = host,
						options = {
							source_filetype = "python",
						},
					})
				else
					cb({
						type = "executable",
						command = "path/to/virtualenvs/debugpy/bin/python",
						args = { "-m", "debugpy.adapter" },
						options = {
							source_filetype = "python",
						},
					})
				end
			end
			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					pythonPath = function()
						local cwd = vim.fn.getcwd()
						if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
							return cwd .. "/venv/bin/python"
						elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
							return cwd .. "/.venv/bin/python"
						else
							return "/usr/bin/python"
						end
					end,
				},
			}
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			{ "mason-org/mason.nvim" },
			{ "mfussenegger/nvim-dap" },
		},
		opts = function(_, opts)
			opts.automatic_installation = true
			opts.ensure_installed = {
				"codelldb",
				"python",
			}
			opts.handlers = {}
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		lazy = true,
		branch = "master",
		dependencies = {
			{ "mfussenegger/nvim-dap" },
		},
		opts = function()
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},
}
