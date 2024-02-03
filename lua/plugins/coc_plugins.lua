return {
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
                "coc-css",
                "coc-eslint",
                "coc-prettier",
                "coc-lua", }
        end
    },
    {
        'neoclide/coc-snippets',
        config = function()
            vim.api.nvim_set_keymap('i', '<C-l>', '<Plug>(coc-snippets-expand)',
                { noremap = false, silent = true })
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
    -- HTML/CSS
    {'neoclide/coc-html'},
    {'yaegassy/coc-htmlhint'},
    { 'neoclide/coc-css' },
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
    { 'yaegassy/coc-tailwindcss3' },
    -- Lua
    { 'josa42/coc-lua' },
}
