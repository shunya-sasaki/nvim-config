# Nvim Config

Configuration files for Neovim.

## Required

- [Neovim](https://neovim.io)
- [Git](https://git-scm.com)
- [Node.js](https://nodejs.org/en)
- [Lazygit](https://github.com/jesseduffield/lazygit)

### Optional

- [PlemolJP](https://github.com/yuru7/PlemolJP) (Use Nerd Font synthetic edition)

## Plugins

In this configuration, the following plugins are used.
The plugin package is installed in the setup procedure,
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
- [neoclide/coc.nvim](https://github.com/neoclide/coc.nvim)
- [neoclide/coc-snippets](https://github.com/)
- [fannheyward/coc-markdownlint](https://github.com/fannheyward/coc-markdownlint)
- [kkiyama117/coc-toml](https://github.com/kkiyama117/coc-toml)
- [fannheyward/coc-pyright](https://github.com/fannheyward/coc-pyright)
- [fannheyward/coc-rust-analyzer](https://github.com/fannheyward/coc-rust-analyzer)
- [neoclide/coc-tsserver](https://github.com/neoclide/coc-tsserver)
- [neoclide/coc-prettier](https://github.com/neoclide/coc-prettier)
- [neoclide/coc-eslint](https://github.com/neoclide/coc-eslint)
- [josa42/coc-lua](https://github.com/josa42/coc-lua)
- [lambdalisue/fern.vim](https://github.com/lambdalisue/fern.vim)
- [fern-renderer-nerdfont.vim](https://github.com/)
- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- [iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)

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

## Shortcut keys and commands

| Mode     | Key and command       | Description                            | Plugin           |
| -------- | --------------------- | -------------------------------------- | ---------------- |
| -        | \<Space\>             | Leader key                             | -                |
| Normal   | Y                     | Yank line                              | -                |
| Normal   | \<C-n\>               | Go to next buffer                      | -                |
| Normal   | \<C-p\>               | Go to previous buffer                  | -                |
| Normal   | \<Esc\>\<Esc\>        | Stop the hilighting for the `hlsearch` | -                |
| Terminal | \<Esc\>               | Return to Normal mode                  | -                |
| Normal   | \<Leader\>ff          | Find files                             | telescope.nvim   |
| Normal   | \<Leader\>fg          | Live grep                              | telescope.nvim   |
| Normal   | \<Leader\>fb          | Buffers                                | telescope.nvim   |
| Normal   | \<Leader\>fh          | Help tags                              | telescope.nvim   |
| Normal   | \<Leader\>\<Leader\>s | Hint char1                             | hop.nvim         |
| Normal   | : Format              | Format a buffer document               | coc.nvim         |
| Normal   | gd                    | Jump to definition                     | coc.nvim         |
| Normal   | gh                    | Hover                                  | coc.nvim         |
| Normal   | gr                    | Rename                                 | coc.nvim         |
| Insert   | \<C-l\>               | Expand selected snippet                | coc-snippets     |
| Normal   | : Prettier            | Format a buffer document with Prettier | coc-snippets     |
| Normal   | \<C-b\>               | Toggle Fern buffer                     | fern.vim         |
| Normal   | : MarkdownPreview     | Open a markdown preview in web browser | markdown-preview |
| Normal   | \<Leader\>g           | Run lazygit on floating terminal       | toggleterm       |
| Normal   | \<C-t\>               | Open a floating terminal               | toggleterm       |

## License

[MIT](./LICENSE)
