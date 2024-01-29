return {
    -- fern -------------------------------------------------------------------
    {
        'lambdalisue/fern.vim',
        priority = 1000,
        config = function()
            vim.g["fern#renderer"] = "default"
            vim.g["fern#default_hidden"] = 1
            vim.keymap.set('n', '<C-b>', "<cmd> Fern . -reveal=% -drawer -toggle <CR>", ops)
        end
    },
    -- statusline --------------------------------------------------------
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup(
                {
                    globalstatus = true,
                    icons_enabled = false,
                    options = { theme = "onedark",
                    component_separators = { left = '»', right = '«'},
                    section_separators = { left = '»', right = '«'},
                    },
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
