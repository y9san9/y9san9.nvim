--[[
=====================================================================
=====================================================================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||       @y9san9      ||   |-----|          ========
========         ||        from        ||   | === |          ========
========         ||   Kickstart.nvim   ||   |-----|          ========
========         ||                    ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================
--]]

-- Required Dependencies (the list might be incomplete)
-- - fd: brew install fd

vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.g.have_nerd_font = true

-- [[ Setting options ]]

vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.colorcolumn = '80'
vim.cmd.set 'nohlsearch'

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]

vim.keymap.set('n', '<leader>oc', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd 'J'
  vim.api.nvim_win_set_height(0, 10)
end, {
  desc = 'Open [C]onsole',
})

vim.keymap.set('n', '<leader>ot', function()
  vim.cmd.tabnew()
end, {
  desc = 'Open [T]ab',
})

vim.keymap.set('n', '<leader>ov', function()
  vim.cmd.e '$MYVIMRC'
end, {
  desc = 'Open $MY[V]IMRC',
})

vim.keymap.set('n', '<leader>le', function()
  vim.opt.iminsert = 0
end, {
  desc = 'Switch to English',
})

vim.keymap.set('n', '<leader>lr', function()
  vim.opt.keymap = 'russian-jcukenmac'
  vim.opt.iminsert = 1
end, {
  desc = 'Switch to Russian',
})

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  -- My plugins
  require 'y9san9.git',
  require 'y9san9.lsp',
  require 'y9san9.test',
  require 'y9san9.gradle',
  require 'y9san9.harpoon',
  require 'y9san9.markdown',

  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.opt.timeoutlen
      delay = 500,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
      },

      preset = 'helix',

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>g', group = '[G]it Hunk', mode = { 'n', 'v' } },
        { '<leader>l', group = 'Switch [L]anguage', mode = 'n' },
        { '<leader>dm', group = 'Document [M]arkdown', mode = 'n' },
        { '<leader>h', group = '[H]arpoon', mode = 'n' },
        { '<leader>o', group = '[O]pen', mode = 'n' },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-telescope/telescope-project.nvim' },
      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      local project_actions = require 'telescope._extensions.project.actions'
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          project = {
            on_project_selected = function(prompt_bufnr)
              project_actions.change_working_directory(prompt_bufnr, false)
              require('oil').open(vim.loop.cwd())
            end,
            cd_scope = { 'tab' },
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzy-native')
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'project')
      pcall(require('telescope').load_extension, 'fd')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      local utils = require 'telescope.utils'

      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch [B]uffers' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sc', builtin.resume, { desc = '[S]earch [C]ontinue' })
      vim.keymap.set('n', '<leader>s.', function()
        builtin.oldfiles { previewer = false }
      end, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>sl', builtin.lsp_workspace_symbols, { desc = '[S]earch [L]sp Symbols' })

      vim.keymap.set('n', '<leader>sp', function()
        require('telescope').extensions.project.project {
          display_type = 'full',
          hide_workspace = true,
        }
      end, { desc = '[S]earch [P]rojects' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
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
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      require('catppuccin').setup {}
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      -- require('mini.surround').setup()
    end,
  },

  {
    'wakatime/vim-wakatime',
  },

  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opts = {} },
    config = function()
      require('oil').setup {
        columns = {
          'icon',
        },
        win_options = {
          winbar = "%{v:lua.require('oil').get_current_dir()}",
        },
      }
      vim.keymap.set('n', '<leader>.', function()
        require('oil').open()
      end, { desc = 'Locate current file' })
      vim.keymap.set('n', '<leader><leader>', function()
        require('oil').open(vim.loop.cwd())
      end, { desc = '[ ] Find existing buffers' })
    end,
  },

  {
    'chentoast/marks.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    },
  },

  -- YANDEX-specific plugins
  -- {
  --   dir = '~/arcadia/junk/moonw1nd/lua/telescope-arc.nvim',
  --   config = function()
  --     require('telescope').load_extension 'arc'
  --     vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  --       pattern = '~/arcadia/*',
  --       desc = 'Activate under yandex folder',
  --       group = vim.api.nvim_create_augroup('yandex-telescope', { clear = true }),
  --       callback = function()
  --         print("SET TEST")
  --         vim.keymap.set('n', '<leader>oap', function ()
  --           require("telescope").extensions.arc.pr_list({
  --             flags = {"-i", "--shipper", "!moonw1nd"},
  --             prompt_title = "arc pr list"
  --           })
  --         end, { desc = 'Open Arcadia [P]ull Requests' })
  --       end,
  --     })
  --   end,
  -- },

  -- Kickstart Plugins
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.autopairs',
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>ou', vim.cmd.UndotreeToggle, { desc = 'Open [U]ndotree' })
    end,
  },
}
