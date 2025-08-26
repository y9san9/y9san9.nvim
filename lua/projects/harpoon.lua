local M = {}

M.attach_terminal = function(options)
    vim.cmd.terminal()
    vim.fn.feedkeys("i")
    vim.fn.feedkeys(options.command)
    vim.fn.feedkeys("\n")
    vim.fn.feedkeys("")
    vim.fn.feedkeys("G")
    require("harpoon"):list():clear()
    require("harpoon"):list():add()
    vim.fn.feedkeys("", "x!")
end

return M
