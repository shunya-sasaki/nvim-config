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
        -- config = function()
        --     vim.cmd([[colorscheme catppuccin]])
        -- end
    },
    -- nightfox ---------------------------------------------------------------
    {
        "EdenEast/nightfox.nvim",
        config = function()
            vim.cmd([[colorscheme nightfox]])
        end
    },
}
