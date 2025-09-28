-- TODO: migrate from harpoon
local M = {}

M.attach = function(options)
    local bufnr = vim.api.nvim_create_buf(false, false)
    local win_height = vim.api.nvim_win_get_height(0)
    local win_width = vim.api.nvim_win_get_width(0)
    local win = nvim_open_win(bufnr, false, {
        relative = 'win',
        win = 0,
        width =
    })
    vim.api.nvim_open_win()
end

M.attach()

M.restore = function(options)
end

return M
