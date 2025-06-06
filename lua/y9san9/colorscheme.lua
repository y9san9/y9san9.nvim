return {
  {
    'p00f/alabaster.nvim',
    config = function()
      -- vim.cmd.colorscheme 'alabaster'
    end,
  },

  {
    'huyvohcmc/atlas.vim',
    config = function()
      -- vim.cmd.colorscheme 'atlas'
    end,
  },

  {
    'kdheepak/monochrome.nvim',
    config = function()
      -- vim.cmd.colorscheme 'monochrome'
    end,
  },

  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme 'gruvbox'
    end,
  },

  {
    'blazkowolf/gruber-darker.nvim',
    config = function()
      vim.cmd.colorscheme 'gruber-darker'
    end,
  },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      -- require('catppuccin').setup {
      --   integrations = {
      --     cmp = true,
      --     gitsigns = true,
      --     treesitter = true,
      --     harpoon = true,
      --     neotest = true,
      --     which_key = true,
      --   },
      -- }
      -- vim.cmd.colorscheme 'catppuccin'
    end,
  },

 
}
