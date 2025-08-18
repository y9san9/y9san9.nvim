-- Mini-plugin to attach harpoon with terminal
local M = {}

-- @param cmd string: command that is executed in the terminal
M.attach = function(cmd)
    vim.cmd.terminal()
    vim.fn.feedkeys("i")
    vim.fn.feedkeys(cmd)
    vim.fn.feedkeys("\n")
    vim.fn.feedkeys("")
    vim.fn.feedkeys("G")
    require("harpoon"):list():clear()
    require("harpoon"):list():add()
    vim.fn.feedkeys("", "x!")
end

return M
