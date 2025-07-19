# Nvim Config

Configuration files for Neovim.

- [Required](#required)
  - [Optional](#optional)
- [Plugins](#plugins)
- [Setup](#setup)
  - [Set nvim as default editor for git](#set-nvim-as-default-editor-for-git)
  - [Set enable to add diff in git commit](#set-enable-to-add-diff-in-git-commit)
- [Shortcut keys and commands](#shortcut-keys-and-commands)
- [User configuration](#user-configuration)
  - [Confugiration user init file](#confugiration-user-init-file)
  - [Configure user plugins](#configure-user-plugins)
- [License](#license)

## Required

- [Neovim](https://neovim.io)
- [Git](https://git-scm.com)
- [Node.js](https://nodejs.org/en)
- [Lazygit](https://github.com/jesseduffield/lazygit)

### Optional

- [PlemolJP](https://github.com/yuru7/PlemolJP) (Use Nerd Font synthetic edition)
- [ripgrep](https://github.com/BurntSushi/ripgrep)

## Plugins

In this configuration, the following nice plugins are used.
The plugin packages are installed in the setup procedure,
so you don't have to install these manually.

<details>
<summary>Used Plugins List</summary>

- [tanvirtin/monkai.nvim](https://github.com/tanvirtin/monokai.nvim)
- [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
- [catppuccin/nvim](https://github.com/catppuccin/nvim)
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
- [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs)
- [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim)
- [kylechui/nvim-surround](https://github.com/kylechui/nvim-surround)
- [phaazon/hop.nvim](https://github.com/phaazon/hop.nvim)
- [lambdalisue/fern.vim](https://github.com/lambdalisue/fern.vim)
- [fern-renderer-nerdfont.vim](https://github.com/)
- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- [iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)
- [github/copilot.vim](https://github.com/github/copilot.vim)
- [olimorris/codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim)
- [MeanderingProgrammer/render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)

</details>

## Setup

First of all, clone this project files in your machine
with the following command in your terminal.

```shell
git clone https://github.com/shunya-sasaki/nvim-config.git ~/.config/nvim
```

After clone the project files, run `nvim`.
At the startup of the nvim, `lazy.nvim`, which is a plugin manager,
is installed and it installs the extensions.

### Set nvim as default editor for git

Run the following command to set Neovim as the default editor for git.

```shell
git config --global core.editor "nvim"
```

### Set enable to add diff in git commit

Run the following command to enable to add diff in git commit.
This helps the copilot to create a commit message.

```shell
git config --global commit.verbose true
```

## Shortcut keys and commands

| Mode     | Key and command       | Description                            | Plugin         |
| -------- | --------------------- | -------------------------------------- | -------------- |
| -        | \<Space\>             | Leader key                             | -              |
| Normal   | Y                     | Yank line                              | -              |
| Normal   | \<C-n\>               | Go to next buffer                      | -              |
| Normal   | \<C-p\>               | Go to previous buffer                  | -              |
| Normal   | \<Esc\>\<Esc\>        | Stop the hilighting for the `hlsearch` | -              |
| Terminal | \<Esc\>\<Esc\>        | Return to Normal mode                  | -              |
| Normal   | \<Leader\>ff          | Find files                             | telescope.nvim |
| Normal   | \<Leader\>fg          | Live grep                              | telescope.nvim |
| Normal   | \<Leader\>fb          | Buffers                                | telescope.nvim |
| Normal   | \<Leader\>fh          | Help tags                              | telescope.nvim |
| Normal   | \<Leader\>\<Leader\>s | Hint char1                             | hop.nvim       |
| Normal   | \<C-b\>               | Toggle Neotree buffer                  | neto-tree.nvim |
| Normal   | \<Leader\>g           | Run lazygit on floating terminal       | toggleterm     |
| Normal   | \<C-t\>               | Open a floating terminal               | toggleterm     |
| Normal   | \<Leader\>cc          | Toggle Codecomapnion chat              | codecompanion  |

## User configuration

### Confugiration user init file

You can change the user configuration that overrides the default settings.
To do this, run command `:ConfigUserInit` in command mode.
After that, you can edit the user configuration file, and add your own settings.

For example, you can change the options to make disable the nerd font.

```lua
Config.with_nf = false
```

And you can change the settings with vim.opt like the follwoings.

```lua
vim.opt.number = false -- defalut: true
vim.opt.tabstop = 2 -- defalut: 4
```

### Configure user plugins

You can changes the plugins settings in the user configuration file.
To do this, run command `:ConfigUserPlugins` in command mode.
After that, you can edit the user plugins file, and add your own settings.

For example, you can change the colorscheme to `kanagawa` like the following.

```lua
return {
	{
        "rebelot/kanagawa.nvim",
	    priority = 1000,
		opts = function(_, opts)
			vim.cmd([[colorscheme kanagawa]])
		end,
	},
}
```

And you can change the models settings for the codecompanion like the followings.

```lua
return {
	{
    "olimorris/codecompanion.nvim",
    opts = function(_, opts)
        opts.adapters = {
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
        }
        opts.strategies.chat.adapter = "llama3"
        opts.strategies.inline.adapter = "llama3"
        opts.strategies.cmd.adapter = "llama3"
    end,
    },
}
```

## License

[MIT](./LICENSE)
