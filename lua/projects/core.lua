local M = {}

-- Limitations:
-- * Deleting this command is undefined behaviour
-- * This implementation overrides existing global commands forever
M.nvim_tabpage_create_user_command = function(name, command, options)
    local tab = vim.api.nvim_get_current_tabpage()

    vim.api.nvim_create_user_command(name, command, options)

    local enterId = vim.api.nvim_create_autocmd('TabEnter', {
        callback = function()
            local enter = vim.api.nvim_get_current_tabpage()
            if enter ~= tab then
                return
            end
            vim.api.nvim_create_user_command(name, command, options)
        end
    })

    local leaveTab = false

    local leaveId = vim.api.nvim_create_autocmd('TabLeave', {
        callback = function()
            local leave = vim.api.nvim_get_current_tabpage()
            leaveTab = leave == tab
            if not leaveTab then
                return
            end
            vim.api.nvim_del_user_command(name)
        end
    })

    local closeId = nil

    closeId = vim.api.nvim_create_autocmd('TabClosed', {
        callback = function()
            if not leaveTab then
                return
            end
            vim.api.nvim_del_autocmd(enterId)
            vim.api.nvim_del_autocmd(leaveId)
            vim.api.nvim_del_autocmd(closeId)
        end
    })
end

return M
