-- luacheck: globals vim
-- user config
Config = {
	with_nf = true,
}
-- check os
if vim.fn.has("win32") == 1 then
	Config.os_name = "win32"
elseif vim.fn.has("win64") == 1 then
	Config.os_name = "win64"
else
	local script_path = debug.getinfo(1).source:match("@?(.*/)")
	package.path = package.path .. ";" .. script_path .. "?.lua"
	Config.os_name = require("util").get_os_name()
end
-- system setting
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number,line"
vim.opt.encoding = "utf-8"
vim.opt.fileencodings = "utf-8,iso-2022-jp,ucs-bom,default"
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
if Config.os_name == "wsl" then
	vim.opt.clipboard = "unnamedplus"
	vim.g.clipboard = {
		name = "myClipboard",
		copy = {
			["+"] = "win32yank.exe -i",
			["*"] = "win32yank.exe -i",
		},
		paste = {
			["+"] = "win32yank.exe -o",
			["*"] = "win32yank.exe -o",
		},
		cache_enabled = 1,
	}
else
	vim.opt.clipboard = "unnamedplus"
end
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.matchtime = 1
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.pumheight = 10
vim.opt.laststatus = 3
vim.opt.completeopt = "menuone,noinsert"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.termguicolors = true
vim.opt.updatetime = 500
vim.opt.ttimeoutlen = 10
vim.opt.timeoutlen = 500

-- keymap
vim.g.mapleader = " "
vim.keymap.set("n", "Y", "yy", { silent = true, noremap = true })
vim.keymap.set("n", "<C-n>", ":bn<CR>", { silent = true })
vim.keymap.set("n", "<C-p>", ":bp<CR>", { silent = true })
vim.keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR>", { silent = true })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-N>", { noremap = true, silent = true })
-- custom commands
vim.api.nvim_create_user_command("ConfigUserInit", ":e " .. vim.fn.stdpath("config") .. "/lua/local/user_init.lua", {})
vim.api.nvim_create_user_command(
	"ConfigUserPlugins",
	":e " .. vim.fn.stdpath("config") .. "/lua/local/plugins/user_plugins.lua",
	{}
)
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false })
	end,
})
-- goto definition
vim.keymap.set("n", "gd", "<C-]>", { noremap = true, silent = true })
-- rename
vim.keymap.set("n", "gr", vim.lsp.buf.rename, { noremap = true, silent = true })
-- hover & scroll
vim.keymap.set("n", "gh", vim.lsp.buf.hover, { noremap = true, silent = true })
-- auto format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = {
		"*.c",
		"*.cc",
		"*.cpp",
		"*.h",
		"*.hpp",
		"*.cs",
		"*.md",
		"*.json",
		"*.py",
		"*.lua",
		"*.ts",
		"*.tsx",
		"*.js",
		"*.jsx",
	},
	callback = function()
		if vim.bo.filetype == "python" then
			vim.lsp.buf.code_action({
				context = {
					only = { "source.fixAll.ruff" },
				},
				apply = true,
			})
			vim.lsp.buf.code_action({
				context = {
					only = { "source.organizeImports.ruff" },
				},
				apply = true,
			})
		end
		vim.lsp.buf.format({ async = false })
	end,
})
-- tabwidth dynamic
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"c",
		"cpp",
		"h",
		"hpp",
		"lua",
		"javascript",
		"typescript",
		"html",
		"css",
		"json",
		"jsonc",
		"markdown",
		"mdx",
	},
	callback = function()
		vim.bo.tabstop = 2
		vim.bo.shiftwidth = 2
		vim.bo.expandtab = true
	end,
})

-- python
if Config.os_name == "win32" or Config.os_name == "win64" then
	vim.g.python3_host_prog = "~/.venv/nvim/Scripts/python.exe"
else
	vim.g.python3_host_prog = "~/.venv/nvim/bin/python3"
end
-- ruby
vim.g.loaded_ruby_provider = 0
-- perl
vim.g.loaded_perl_provider = 0

-- user config
local local_init = vim.fn.stdpath("config") .. "/lua/local/user_init.lua"
if vim.loop.fs_stat(local_init) then
	require("local.user_init")
end

-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local specs = {
	{ import = "plugins" },
}

local local_dir = vim.fn.stdpath("config") .. "/lua/local/plugins"
local has_local = vim.fn.isdirectory(local_dir) == 1 and #vim.fn.globpath(local_dir, "*.lua", false, true) > 0
if has_local then
	table.insert(specs, { import = "local.plugins" })
end

require("lazy").setup(specs)
