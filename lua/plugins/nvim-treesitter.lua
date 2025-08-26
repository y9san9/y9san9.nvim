return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    -- All parsers are like 250MB in size which is fine
    build = ':TSUpdate',
    config = function()
        require'nvim-treesitter.install'.prefer_git = false
        vim.api.nvim_create_autocmd('FileType', {
            callback = function()
                pcall(vim.treesitter.start)
            end
        })
    end,
}
