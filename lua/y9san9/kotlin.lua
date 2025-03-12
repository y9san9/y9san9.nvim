return {
  'y9san9/kotlin-toolchain.nvim',
  -- dir = '~/IdeaProjects/kotlin-toolchain.nvim',
  config = function()
    vim.keymap.set('n', '<leader>f', function()
      if vim.bo.filetype == 'kotlin' then
        require('kotlin-toolchain').file.format {}
        return
      end
    end, { desc = '[F]ormat Buffer' })
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = { '*.kt' },
      callback = function()
        require('kotlin-toolchain').file.format {}
      end,
    })
  end,
}
