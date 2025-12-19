local M = {}

M.attach = function(options)
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

return M
