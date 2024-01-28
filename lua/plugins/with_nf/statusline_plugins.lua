return {

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
                    globalstatus = true,
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
}
