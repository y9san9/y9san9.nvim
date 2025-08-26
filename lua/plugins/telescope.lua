vim.pack.add {
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
}

require("telescope").setup {
    defaults = {
        path_display = { "filename_first" },
        layout_strategy = "vertical",
    },
}
