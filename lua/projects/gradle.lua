local M = {}

M.make = function(options)
    local kotlin = "%t: file://%f:%l:%c %m"
    local ignoreUnknown = "%-G%.%#"
    vim.opt.makeprg = options.command
    vim.opt.errorformat = {
        kotlin,
        ignoreUnknown,
    }
    vim.cmd.make()
end

return M
