return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>a", function() require("harpoon"):list():add() end },
        { "<leader>e", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end },
        { "<C-h>", function() require("harpoon"):list():select(1) end },
        { "<C-j>", function() require("harpoon"):list():select(2) end },
        { "<C-k>", function() require("harpoon"):list():select(3) end },
        { "<C-l>", function() require("harpoon"):list():select(4) end },
        { "<C-b>", function() require("harpoon"):list():select(5) end },
        { "<C-n>", function() require("harpoon"):list():select(6) end },
        { "<C-m>", function() require("harpoon"):list():select(7) end },
        { "<C-m>", function() require("harpoon"):list():select(8) end },
    },
    opts = {},
}
