return {
    {
        "jupyter-vim/jupyter-vim",
        config = function()
            vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
                pattern = { "*.py" },
                callback = function()
                    vim.api.nvim_buf_set_keymap(0, "n", "<leader>r",
                        ":JupyterSendCell<CR>",
                        { silent = true, noremap = true })
                end
            })
            vim.g.jupyter_highlight_cells = 0
        end
    }
}
