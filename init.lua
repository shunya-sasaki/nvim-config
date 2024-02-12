-- luacheck: globals vim
local script_path = debug.getinfo(1).source:match("@?(.*/)")
package.path = package.path .. ';' .. script_path .. '?.lua'
local os_name = require("util").get_os_name()
local with_nf = true
-- system setting
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number,line"
vim.opt.encoding = "utf-8"
vim.opt.fileencodings = "utf-8,iso-2022-jp,ucs-bom,default"
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
if os_name == "wsl" then
    vim.opt.clipboard = "unnamedplus"
    vim.g.clipboard = {
        name = 'myClipboard',
        copy = {
            ['+'] = 'win32yank.exe -i',
            ['*'] = 'win32yank.exe -i',
        },
        paste = {
            ['+'] = 'win32yank.exe -o',
            ['*'] = 'win32yank.exe -o',
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

-- keymap
vim.g.mapleader = " "
vim.keymap.set("n", "Y", "yy", { silent = true, noremap = true })
vim.keymap.set("n", "<C-n>", ":bn<CR>", { silent = true })
vim.keymap.set("n", "<C-p>", ":bp<CR>", { silent = true })
vim.keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR>", { silent = true })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-N>", { noremap = true, silent = true })
vim.api.nvim_create_user_command("ConfigInit", ":e ~/.config/nvim/init.lua", {})
vim.api.nvim_create_user_command("ConfigPlugins", ":e ~/.config/nvim/lua/plugins.lua", {})

-- python
vim.g.python3_host_prog = "~/.venv/nvim/bin/python3"

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
if with_nf then
    require("lazy").setup({
        { import = "plugins" },
        { import = "plugins.extra" },
        { import = "plugins.with_nf" },
    })
else
    require("lazy").setup({
        { import = "plugins" },
        { import = "plugins.extra" },
        { import = "plugins.without_nf" },

    })
end
