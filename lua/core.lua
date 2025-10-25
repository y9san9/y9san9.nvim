-- This file only contains core settings that
-- are available without any plugins
vim.g.mapleader = ","
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes:1"
vim.opt.colorcolumn = "80"
vim.opt.textwidth = 80
vim.opt.completeopt = "menu,menuone,fuzzy,noinsert"
vim.opt.swapfile = false
vim.opt.confirm = true
vim.opt.linebreak = true
vim.opt.wildoptions:append { 'fuzzy' }
vim.opt.path:append { '**' }
vim.opt.scrolloff = 999
vim.opt.smoothscroll = true

vim.opt.grepprg = "rg --vimgrep --no-messages --smart-case"

vim.opt.statusline = "[%n] %<%f %h%w%m%r%=%-14.(%l,%c%V%) %P"

-- Only highlight with treesitter
vim.cmd("syntax off")

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.cmd.colorscheme('habamax')
