return {
  'voldikss/vim-floaterm',
  keys = {
    {
      '<leader>oc',
      '<cmd>FloatermToggle<cr>',
      desc = 'Open [C]onsole',
    },
  },
  config = function()
    vim.g.floaterm_autoinsert = false
    vim.g.floaterm_width = 0.99
    vim.g.floaterm_height = 0.99
  end,
}
