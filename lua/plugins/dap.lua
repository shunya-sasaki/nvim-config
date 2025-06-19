return {

	{ "mfussenegger/nvim-dap" },
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
