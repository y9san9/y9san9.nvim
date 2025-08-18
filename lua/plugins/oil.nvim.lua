return {
    'stevearc/oil.nvim',
    lazy = false,
    opts = {
        keymaps = {
            ["`"] = "actions.tcd",
            -- disable consflicting shortcuts with harpoon
            ["<C-h>"] = false,
            ["<C-j>"] = false,
            ["<C-k>"] = false,
            ["<C-l>"] = false,
            ["<C-b>"] = false,
            ["<C-n>"] = false,
            ["<C-m>"] = false,
            ["<C-,>"] = false,
        },
        columns = {
            "icon",
            -- "permissions",
            "size",
            "mtime",
        },
        delete_to_trash = true,
        -- watchForChanges = true,
        skip_confirm_for_simple_edits = true,
    },
    keys = {
        { "<leader><leader>", ":Oil<CR>", silent = true },
    },
}
