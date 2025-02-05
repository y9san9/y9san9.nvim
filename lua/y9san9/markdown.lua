return {
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function(plugin)
      vim.cmd('!cd ' .. plugin.dir .. ' && cd app && npx --yes yarn install')
    end,
    config = function()
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_theme = 'light'
      vim.g.mkdp_combine_preview = 1
      vim.g.mkdp_combine_preview_auto_refresh = 1
      vim.keymap.set('n', '<leader>dmp', '<cmd>MarkdownPreview<CR>', { desc = 'Document Markdown [P]review' })
    end,
  },
}
