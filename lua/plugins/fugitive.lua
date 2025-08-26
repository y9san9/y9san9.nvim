return {
    'tpope/vim-fugitive',
    config = function()
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'fugitive',
            callback = function()
                vim.cmd("syntax on")
            end
        })
    end
}
