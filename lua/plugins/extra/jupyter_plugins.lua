return {
    {
        'jpalardy/vim-slime',
        config = function()
            vim.g.slime_target = "tmux"
            vim.g.slime_python_ipython = 1
            vim.g.slime_default_config = {
                socket_name = vim.fn.get(vim.fn.split(vim.env.TMUX, ","), 0),
                target_pane = ":.1"
            }
            vim.g.slime_dont_ask_default = 1
        end
    },
    {
        'hanschen/vim-ipython-cell',
        config = function()
            vim.api.nvim_create_autocmd("FileType",
                {
                    pattern = "python",
                    callback = function()
                        vim.api.nvim_buf_set_keymap(0, "n", "<leader>r",
                            ":IPythonCellExecuteCell<CR>",
                            { silent = true, noremap = true })
                        vim.api.nvim_buf_set_keymap(0, "n", "<leader><S-r>",
                            ":IPythonCellExecuteCellJump<CR>",
                            { silent = true, noremap = true })
                    end
                })
        end
    }
}
