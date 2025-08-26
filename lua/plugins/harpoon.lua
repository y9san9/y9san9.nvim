vim.pack.add {
    {
        src = "https://github.com/ThePrimeagen/harpoon",
        version = "harpoon2",
    },
    "https://github.com/nvim-lua/plenary.nvim",
}

vim.keymap.set("n", "<leader>a", function()
    require("harpoon"):list():add()
end)

vim.keymap.set("n", "<leader>e", function()
    require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
end)

vim.keymap.set("n", "<C-h>", function()
    require("harpoon"):list():select(1)
end)

vim.keymap.set("n", "<C-j>", function()
    require("harpoon"):list():select(2)
end)

vim.keymap.set("n", "<C-k>", function()
    require("harpoon"):list():select(3)
end)

vim.keymap.set("n", "<C-l>", function()
    require("harpoon"):list():select(4)
end)

vim.keymap.set("n", "<C-b>", function()
    require("harpoon"):list():select(5)
end)

vim.keymap.set("n", "<C-n>", function()
    require("harpoon"):list():select(6)
end)

vim.keymap.set("n", "<C-m>", function()
    require("harpoon"):list():select(7)
end)

vim.keymap.set("n", "<C-m>", function()
    require("harpoon"):list():select(8)
end)
