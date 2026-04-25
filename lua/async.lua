-- Module to enable asynchronous make instead of the default synchronous one
local M = {}

function M.make()
    local makeprg = vim.o.makeprg
    local errorformat = vim.o.errorformat
    -- :make does this to expand % and other stuff
    local cmd = vim.fn.expandcmd(makeprg)

    local lines = {}
    local progress = {
      kind = 'progress',
      source = 'y9san9.async',
      status = 'running',
      title = 'Compile',
    }

    function on_data(data)
        vim.list_extend(lines, data)
        for _, line in ipairs(data) do
            if not line:match("^%s*$") then
                vim.api.nvim_echo({{line}}, false, progress)
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
            if n == 0 then
                progress.status = 'success'
                vim.api.nvim_echo({{"0 errors"}}, false, progress)
            else
                progress.status = 'failed'
                if n == 1 then
                    local entry = vim.fn.getqflist()[1]
                    local full_name = vim.api.nvim_buf_get_name(entry.bufnr)
                    local name = vim.fn.fnamemodify(full_name, ":t")
                    local string = string.format("%s:%d:%d: %s", name, entry.lnum, entry.col, entry.text)
                    vim.api.nvim_echo({{string}}, false, progress)
                else
                    vim.api.nvim_echo({{string.format("%d error(s)", n)}}, false, progress)
                end
            end
        end,
    })

    progress.id = vim.api.nvim_echo({{ cmd }}, false, progress)
end

return M
