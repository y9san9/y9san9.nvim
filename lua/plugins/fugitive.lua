vim.pack.add {
    'https://github.com/tpope/vim-fugitive',
}

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'fugitive', 'git' },
    callback = function()
        vim.cmd("syntax on")
    end
})
