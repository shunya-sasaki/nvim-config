return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local sign = vim.fn.sign_define
			-- Regular breakpoint
			sign("DapBreakpoint", {
				text = "",
				texthl = "DapBreakpoint",
				linehl = "",
				numhl = "",
			})
			vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e06c75", bold = true })
			-- Conditional breakpoint
			sign("DapBreakpointCondition", {
				text = "",
				texthl = "DapBreakpoint",
				texthl = "DapBreakpointCondition",
			})
			vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#c678dd", bold = true })
			-- Breakpoint rejected by adapter
			sign("DapBreakpointRejected", {
				text = "",
				texthl = "DiagnosticError", -- reuse existing highlight if you like
			})
			vim.api.nvim_set_hl(0, "DapBreakPointRejected", { fg = "#be5046", bold = true })
			-- Current execution point
			sign("DapStopped", {
				text = "",
				texthl = "DapStopped",
				linehl = "CursorLine",
			})
			vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379", bold = true })
			-- C++ configuration
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
						elseif vim.fn.executable(cwd .. "/venv/Scripts/python.exe" == 1) then
							return cwd .. "venv/Scripts/python.exe"
						elseif vim.fn.executable(cwd .. "/.venv/Scripts/python.exe" == 1) then
							return cwd .. ".venv/Scripts/python.exe"
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
			vim.keymap.set("n", "<F5>", function()
				require("dap").continue()
			end)
			vim.keymap.set("n", "<F10>", function()
				require("dap").step_over()
			end)
			vim.keymap.set("n", "<F11>", function()
				require("dap").step_into()
			end)
			vim.keymap.set("n", "<F12>", function()
				require("dap").step_out()
			end)
			vim.keymap.set("n", "<Leader>b", function()
				require("dap").toggle_breakpoint()
			end)
			vim.keymap.set("n", "<Leader>B", function()
				require("dap").set_breakpoint()
			end)
			vim.keymap.set("n", "<Leader>lp", function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end)
			vim.keymap.set("n", "<Leader>dr", function()
				require("dap").repl.open()
			end)
			vim.keymap.set("n", "<Leader>dl", function()
				require("dap").run_last()
			end)
			vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
				require("dap.ui.widgets").hover()
			end)
			vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
				require("dap.ui.widgets").preview()
			end)
			vim.keymap.set("n", "<Leader>df", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end)
			vim.keymap.set("n", "<Leader>ds", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end)
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		branch = "master",
		dependencies = {
			{ "mfussenegger/nvim-dap" },
			{ "nvim-neotest/nvim-nio" },
			{ "theHamsta/nvim-dap-virtual-text", opts = {} },
		},
		event = "VeryLazy",
		opts = function()
			vim.api.nvim_set_keymap(
				"n",
				"<Leader>d",
				":lua require('dapui').toggle()<CR>",
				{ noremap = true, silent = true }
			)
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
