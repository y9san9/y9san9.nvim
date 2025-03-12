local open_file_uri = vim.fn.stdpath 'config' .. '/plugins/open-file-uri'

return {
  dir = open_file_uri,
  keys = {
    {
      'gf',
      function()
        require('open-file-uri').open()
      end,
      desc = 'Open File under cursor',
    },
  },
}
