local M = {}

M.make = function(options)
    vim.opt.makeprg = options.command
    vim.opt.errorformat = {
        -- Error with file location (start of multiline)
        '%E%t: file://%f:%l:%c %m',
        -- More specific continuation patterns for abstract member declarations
        '%Csuspend fun %m',
        '%Cfun %m(',
        -- Continuation lines for the error message
        '%C%m',
        -- End of multiline message (empty line or new error)
        '%Z',
        -- Ignore unknown lines
        '%-G%.%#'
    }
    vim.cmd.make()
end

return M
