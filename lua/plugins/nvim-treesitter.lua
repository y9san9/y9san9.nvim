vim.pack.add {
    {
        src = 'https://github.com/nvim-treesitter/nvim-treesitter',
        version = 'main',
    }
}

-- FIXME: as of now I don't see a clean way to call :TSUpdate
-- vim.cmd.TSUpdate()

require'nvim-treesitter.install'.prefer_git = false

vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        pcall(vim.treesitter.start)
    end
})

