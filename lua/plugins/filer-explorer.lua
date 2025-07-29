local dependencies = {
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
	"MunifTanjim/nui.nvim",
}
if (vim.fn.has("win32") == 0) and (vim.fn.has("win64") == 0) then
	table.insert(dependencies, "3rd/image.nvim")
end

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = dependencies,
	laxy = false,
	opts = function(opts, _)
		opts.window = {
			mappings = {
				["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
				["l"] = "focus_preview",
				["<C-b>"] = { "scroll_preview", config = { direction = 10 } },
				["<C-f>"] = { "scroll_preview", config = { direction = -10 } },
			},
		}
		vim.keymap.set("n", "<Leader>e", ":Neotree toggle position=float<CR>", { silent = true })
		vim.cmd([[cab nt Neotree]])
		vim.cmd([[cab ntf Neotree float]])
		vim.cmd([[cab ntb Neotree buffers]])
		vim.cmd([[cab ntg Neotree git_status]])
	end,
}
