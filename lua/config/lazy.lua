-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local specs = {
	{ import = "plugins" },
}

local local_dir = vim.fn.stdpath("config") .. "/lua/local/plugins"
local has_local = vim.fn.isdirectory(local_dir) == 1 and #vim.fn.globpath(local_dir, "*.lua", false, true) > 0
if has_local then
	table.insert(specs, { import = "local.plugins" })
end

require("lazy").setup({
	checker = { enabled = false },
	spec = specs,
	rocks = { hererocks = true },
	install = { colorscheme = { "tokyonight" } },
	checker = { enabled = false },
})
