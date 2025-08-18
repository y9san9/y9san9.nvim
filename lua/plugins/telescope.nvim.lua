return {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
        defaults = {
            path_display = { "filename_first" },
            layout_strategy = 'vertical',
        },
    },
    keys = {
        { "<leader>.", ":Telescope<CR>" },
    },
}
