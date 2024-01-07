return {
    -- colorscheme ============================================================
    -- monokai ----------------------------------------------------------------
    {
        "tanvirtin/monokai.nvim",
        lazy = false,
        -- config = function()
        --     vim.cmd([[colorscheme monokai]])
        -- end
    },
    -- tokyonight -------------------------------------------------------------
    {
        'folke/tokyonight.nvim',
        lazy = false,
        -- config = function()
        --     vim.cmd([[colorscheme tokyonight-storm]])
        -- end
    },
    -- catppuccin -------------------------------------------------------------
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme catppuccin]])
        end
    },
    -- fuzzy finder ===========================================================
    -- telescope --------------------------------------------------------------
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        end
    },
    -- syntax =================================================================
    -- treesitter (syntax) ----------------------------------------------------
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {
                    "c",
                    "cpp",
                    "cmake",
                    "css",
                    "doxygen",
                    "git_config",
                    "html",
                    "htmldjango",
                    "javascript",
                    "jsdoc",
                    "lua",
                    "mermaid",
                    "python",
                    "rust",
                    "toml",
                    "tsx",
                    "typescript",
                    "vim",
                    "vimdoc"
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    -- terminal ===============================================================
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            local Terminal = require('toggleterm.terminal').Terminal
            local lazygit  = Terminal:new(
                { cmd = "lazygit", hidden = true, direction = "float" })

            function Lazygit_toggle()
                lazygit:toggle()
            end

            vim.api.nvim_set_keymap("n", "<leader>g",
                "<cmd>lua Lazygit_toggle()<CR>", { noremap = true, silent = true })
            require("toggleterm").setup(
                { direction = "float" })
            vim.api.nvim_set_keymap("n", "<C-t>",
                ": ToggleTerm<CR>", { silent = true, noremap = true })
        end
    },
    -- git ====================================================================
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end
    },
    -- auto pair
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {}
    },
    -- comment
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        lazy = false,
    },
    -- surround
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
            })
        end
    },
    -- easymotion
    {
        'phaazon/hop.nvim',
        config = function()
            local hop = require('hop')
            vim.keymap.set('n', "<Leader><Leader>s", function()
                hop.hint_char1()
            end, { noremap = true, silent = true })
            hop.setup({ keys = 'etovxqpdygfblzhckisuran' })
        end
    },
    -- coc --------------------------------------------------------------------
    {
        'neoclide/coc.nvim',
        branch = 'release',
        config = function()
            vim.api.nvim_create_user_command("Format",
                "call CocAction('format')", {})
            vim.api.nvim_set_keymap('n', "gd",
                ":call CocAction('jumpDefinition')<CR>",
                { silent = true, noremap = true })
            vim.api.nvim_set_keymap('n', "gr", ":call CocAction('rename')<CR>",
                { silent = true, noremap = true })
            vim.api.nvim_set_keymap('n', "gh", ":call CocAction('doHover')<CR>",
                { silent = true, noremap = true })
            vim.g.coc_global_extensions = {
                "coc-snippets",
                "coc-markdownlint",
                "coc-toml",
                "coc-rust-analyzer",
                "coc-pyright",
                "coc-tsserver",
                "coc-eslint",
                "coc-prettier",
                "coc-lua", }
        end
    },
    {
        'neoclide/coc-snippets',
        config = function()
            vim.api.nvim_set_keymap('i', '<C-l>', '<Plug>(coc-snippets-expand)', { noremap = false, silent = true })
        end
    },
    -- Markdown
    { 'fannheyward/coc-markdownlint' },
    -- Toml
    { 'kkiyama117/coc-toml' },
    -- Python
    {
        'fannheyward/coc-pyright',
        config = function()
            -- auto sort on save
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.py",
                callback = function()
                    vim.cmd("CocCommand python.sortImports")
                end
            })
        end
    },
    -- Rust
    { 'fannheyward/coc-rust-analyzer' },
    -- TypeScript / JavaScript
    { 'neoclide/coc-tsserver' },
    {
        'neoclide/coc-prettier',
        config = function()
            vim.api.nvim_create_user_command("Prettier",
                function()
                    vim.cmd("CocCommand prettier.forceFormatDocument")
                end
                , {})
        end
    },
    { 'neoclide/coc-eslint' },
    -- Lua
    { 'josa42/coc-lua' },
    -- fern -------------------------------------------------------------------
    {
        'lambdalisue/fern.vim',
        priority = 1000,
        config = function()
            vim.g["fern#renderer"] = "nerdfont"
            vim.g["fern#default_hidden"] = 1
            vim.keymap.set('n', '<C-b>', "<cmd> Fern . -reveal=% -drawer -toggle <CR>", ops)
        end
    },
    {
        "lambdalisue/fern-renderer-nerdfont.vim",
        dependencies = { "lambdalisue/nerdfont.vim" },
    },
    -- airline ----------------------------------------------------------------
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            config = function()
                require('nvim-web-devicons').setup(
                    {
                        override = {
                            toml = { icon = "" }
                        }
                    }
                )
            end
        },
        config = function()
            require('lualine').setup(
                {
                    options = { theme = "onedark" },
                    tabline = {
                        lualine_a = {
                            {
                                'buffers',
                                mode = 4,
                                icons_enabled = true,
                                show_filename_only = true,
                                hide_filename_extensions = false
                            }
                        },
                        lualine_b = {},
                        lualine_c = {},
                        lualine_x = {},
                        lualine_y = {},
                        lualine_z = { 'tabs' }
                    },

                }
            )
        end
    },
    -- preview ================================================================
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    }
}
