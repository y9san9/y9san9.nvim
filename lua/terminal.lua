local M = {}

function M.attach(options)
    local options = options or {}
    local prev_buf = vim.api.nvim_get_current_buf()
    vim.cmd.terminal(options.program)
    local term_buf = vim.api.nvim_get_current_buf()
    if options.command ~= nil then
        vim.api.nvim_chan_send(vim.bo.channel, options.command)
        vim.api.nvim_chan_send(vim.bo.channel, '\n')
    end
    if options.hide == true then
        vim.api.nvim_set_current_buf(prev_buf)
    end
    return term_buf
end

function M.scriptable(options)
    local options = options or {}
    local previous_buffer = vim.api.nvim_get_current_buf()
    vim.cmd.term(options.program)
    local terminal_buffer = vim.api.nvim_get_current_buf()
    local channel = vim.bo.channel
    if options.command ~= nil then
        vim.api.nvim_chan_send(channel, options.command)
        vim.api.nvim_chan_send(channel, '\n')
    end
    if options.hide == true then
        vim.api.nvim_set_current_buf(previous_buffer)
    end

    local Terminal = {}

    function Terminal.focus()
        vim.api.nvim_set_current_buf(terminal_buffer)
    end

    function Terminal.interrupt()
        vim.api.nvim_chan_send(channel, '')
    end

    function Terminal.send(options)
        vim.api.nvim_chan_send(channel, options.command)
        vim.api.nvim_chan_send(channel, '\n')
    end

    return Terminal
end

return M
