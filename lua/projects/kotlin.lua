local M = {}

M.grep_import = function(identifier)
    vim.cmd.grep([["^import.*\<]] .. identifier .. [[\>"]])
end

M.grep_type = function(identifier)
    vim.cmd.grep(
        [["\<(enum|class|interface|typealias|object)\>\s+.*\<]] .. identifier .. [[\>"]]
    )
end

return M
