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
        'vim-airline/vim-airline',
        config = function()
            vim.g.airline_theme = "term"
            vim.g['airline#extensions#tabline#enabled'] = 1
            vim.g['airline#extensions#tabline#formatter'] = 'default'
            vim.g['airline#extensions#virtualenv#enabled'] = 1

            if vim.g.airline_symbols == nil then
                vim.g.airline_symbols = {}
            end
            vim.g.airline_left_sep = '»'
            vim.g.airline_right_sep = '«'
            vim.g.airline_symbols.colnr = ' ㏇:'
            vim.g.airline_symbols.colnr = ' ℅:'
            vim.g.airline_symbols.crypt = '🔒'
            vim.g.airline_symbols.linenr = '☰'
            vim.g.airline_symbols.maxlinenr = ''
            vim.g.airline_symbols.branch = '⎇'
            vim.g.airline_symbols.paste = 'ρ'
            vim.g.airline_symbols.paste = '∥'
            vim.g.airline_symbols.spell = 'Ꞩ'
            vim.g.airline_symbols.notexists = '∄'
        end
    },
    { 'vim-airline/vim-airline-themes' }
}
