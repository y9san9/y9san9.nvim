local M = {}

M.open = function()
  -- Temporarily include colons in filenames to capture the full URI
  local old_isfname = vim.opt.isfname:get()
  vim.opt.isfname:append ':' -- Allow colons in filenames

  -- Get the URI under the cursor
  local uri = vim.fn.expand '<cfile>'

  -- Restore the original isfname setting
  vim.opt.isfname = old_isfname

  -- Check if the URI starts with `file://`
  if uri:match '^file://' then
    -- Strip the `file://` prefix and decode URL-encoded characters (e.g., %20)
    local path_line_col = uri:sub(8) -- Remove "file://"
    local decoded = path_line_col:gsub('%%(%x%x)', function(hex)
      return string.char(tonumber(hex, 16))
    end)

    -- Extract line and column from the end of the string
    local col_pos = decoded:reverse():find ':' -- Find the last colon
    local col = decoded:sub(-col_pos + 1)
    local remaining = decoded:sub(1, -col_pos - 1)
    local line_pos = remaining:reverse():find ':' -- Find the second-to-last colon
    local line = remaining:sub(-line_pos + 1)
    local file_path = remaining:sub(1, -line_pos - 1)

    -- Handle Windows drive letters (e.g., `/C:/path` → `C:/path`)
    if vim.fn.has 'win32' == 1 and file_path:match '^/[A-Za-z]:' then
      file_path = file_path:sub(2) -- Remove the leading slash
    end

    -- Open the file and jump to the line:column
    vim.cmd('edit ' .. vim.fn.fnameescape(file_path))
    vim.api.nvim_win_set_cursor(0, { tonumber(line), tonumber(col) - 1 }) -- Lua uses 0-based columns
  else
    -- Fallback to default `gf` behavior
    pcall(vim.cmd, 'normal! gf')
  end
end

return M
