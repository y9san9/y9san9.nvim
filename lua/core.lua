-- This file only contains core settings that
-- are available without any plugins
vim.g.mapleader = ","
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.guifont = "JetBrainsMono Nerd Font"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes:1"
vim.opt.colorcolumn = "80"

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})
