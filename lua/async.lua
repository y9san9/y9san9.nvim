-- Module to enable asynchronous make instead of the default synchronous one
local M = {}

function M.make()
    local makeprg = vim.o.makeprg
    local errorformat = vim.o.errorformat
    -- :make does this to expand % and other stuff
    local cmd = vim.fn.expandcmd(makeprg)

    local lines = {}

    function on_data(data)
        vim.list_extend(lines, data)
        for _, line in ipairs(data) do
            if not line:match("^%s*$") then
                vim.notify(line, vim.log.levels.TRACE)
            end
        end
    end

    vim.fn.jobstart(cmd, {
        on_stdout = function(_, data) on_data(data) end,
        on_stderr = function(_, data) on_data(data) end,
        on_exit = function()
            vim.fn.setqflist({}, "r", {
                lines = lines,
                efm = errorformat,
                title = "Asynchronous Make",
            })
            local n = #vim.fn.getqflist()
            vim.notify(string.format("Compile: %d error(s)", n))
        end,
    })

    vim.notify("Compile: " .. cmd)
end

return M
