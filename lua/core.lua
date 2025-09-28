-- This file only contains core settings that
-- are available without any plugins
vim.g.mapleader = ","
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes:1"
vim.opt.colorcolumn = "80"
vim.opt.completeopt = "menu,menuone,fuzzy,noinsert"
vim.opt.swapfile = false
vim.opt.confirm = true
vim.opt.wildoptions:append { 'fuzzy' }
vim.opt.path:append { '**' }

-- Only highlight with treesitter
vim.cmd("syntax off")

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.cmd.colorscheme('habamax')
