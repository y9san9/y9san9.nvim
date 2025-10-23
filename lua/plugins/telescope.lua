vim.pack.add {
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
}

require("telescope").setup {
    defaults = {
        path_display = { "filename_first" },
        layout_strategy = "vertical",
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
    },
}

vim.keymap.set("n", "<leader>.", ":Telescope<CR>", { silent = true })
