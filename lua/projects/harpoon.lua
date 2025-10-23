local M = {}

M.attach_terminal = function(options)
    local options = options or {}
    vim.cmd.terminal()
    vim.fn.feedkeys("i")
    if options.command ~= nil then
        vim.fn.feedkeys(options.command)
    end
    vim.fn.feedkeys("\n")
    vim.fn.feedkeys("")
    vim.fn.feedkeys("G")
    require("harpoon"):list():clear()
    require("harpoon"):list():add()
    vim.fn.feedkeys("", "x!")
end

return M
