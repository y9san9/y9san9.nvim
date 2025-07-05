return {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
        defaults = {
            layout_strategy = 'vertical',
        },
    },
    keys = {
        { "<leader>.", ":Telescope<CR>" },
    },
}
