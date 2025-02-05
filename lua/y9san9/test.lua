return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'marilari88/neotest-vitest',
  },
  config = function()
    vim.keymap.set('n', '<leader>tn', function()
      require('neotest').run.run()
    end, { desc = '[T]est: Run [N]earest' })
    vim.keymap.set('n', '<leader>tf', function()
      require('neotest').run.run(vim.fn.expand '%')
    end, { desc = '[T]est: Run [F]ile' })
    vim.keymap.set('n', '<leader>ta', function()
      require('neotest').run.run(vim.fn.getcwd())
    end, { desc = '[T]est: Run [A]ll' })
    vim.keymap.set('n', '<leader>ts', function()
      require('neotest').summary.open()
    end, { desc = '[T]est: [S]ummary' })
    require('neotest').setup {
      adapters = {
        require 'neotest-vitest' {
          filter_dir = function(name, rel_path, root)
            return name ~= 'node_modules'
          end,
        },
      },
      highlights = {
        adapter_name = 'NeotestBorder',
        border = 'NeotestBorder',
        dir = 'NeotestBorder',
        expand_marker = 'NeotestBorder',
        failed = 'NeotestBorder',
        file = 'NeotestBorder',
        focused = 'NeotestBorder',
        indent = 'NeotestBorder',
        marked = 'NeotestBorder',
        namespace = 'NeotestBorder',
        passed = 'NeotestBorder',
        running = 'NeotestBorder',
        select_win = 'NeotestBorder',
        skipped = 'NeotestBorder',
        target = 'NeotestBorder',
        test = 'NeotestBorder',
        unknown = 'NeotestBorder',
        watching = 'NeotestBorder',
      },
    }
  end,
}
