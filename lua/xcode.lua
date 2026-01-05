local M = {}

function M.make(options)
    vim.g.compiler_gcc_ignore_unmatched_lines = true
    vim.cmd.compiler('gcc')
    vim.opt.makeprg = options.command
    vim.cmd.make()
end

return M
