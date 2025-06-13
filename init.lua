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
--
vim.g.neovide_hide_mouse_when_typing = true

vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.g.have_nerd_font = true

-- [[ Setting options ]]

vim.opt.guicursor = 'n-v-c-i:block-Cursor'
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.colorcolumn = '80'
vim.opt.textwidth = 80
vim.opt.synmaxcol = 10000
vim.opt.wrapmargin = 2
vim.opt.linebreak = true
vim.opt.showtabline = 0

-- avoid stupid menu.vim (saves ~100ms)
vim.g.did_install_default_menus = 1
-- Disable netrw
vim.g.loaded_netrwPlugin = 0

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevelstart = 99

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

-- Automatically resize and show up to 5 icons in gutter
vim.opt.signcolumn = 'yes:2'

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

-- [[ Basic Keymaps ]]

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

vim.keymap.set('n', '<space>', 'ciw')

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
  require 'y9san9.git',
  -- require 'y9san9.lsp',
  require 'y9san9.test',
  -- require 'y9san9.gradle',
  require 'y9san9.harpoon',
  require 'y9san9.markdown',
  -- require 'y9san9.kotlin',
  require 'y9san9.presentation',
  require 'y9san9.open-file-uri',
  require 'y9san9.terminal',
  require 'y9san9.highlighting',
  require 'y9san9.statusline',
  require 'y9san9.colorscheme',
  -- require 'y9san9.autocomplete',

  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      delay = 2000,
      icons = {
        mappings = vim.g.have_nerd_font,
      },

      -- Document existing key chains
      spec = {
        { 'q', group = '[Q]uickFix', mode = { 'n' } },
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
      { 'nvim-telescope/telescope-live-grep-args.nvim' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-telescope/telescope-project.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
      { 'Marskey/telescope-sg' },
      { 'xiyaowong/telescope-emoji.nvim' },
    },
    config = function()
      local project_actions = require 'telescope._extensions.project.actions'
      local live_grep_args_actions = require 'telescope-live-grep-args.actions'

      require('telescope').setup {
        defaults = {
          horizontal = {
            prompt_position = 'top',
          },
          vertical = {
            prompt_position = 'top',
          },
          layout_strategy = 'vertical',
          path_display = { 'filename_first' },
        },
        pickers = {
          find_files = {
            previewer = false,
          },
          oldfiles = {
            previewer = false,
          },
          live_grep_args = {
            layout_strategy = 'vertical',
            additional_args = function()
              return { '--multiline' }
            end,
          },
          buffers = {
            mappings = {
              n = {
                ['d'] = 'delete_buffer',
              },
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          ast_grep = {
            command = {
              'sg',
              '--json=stream',
            },
          },
          live_grep_args = {
            auto_quoting = true,
            mappings = {
              i = {
                ["<C-k>"] = live_grep_args_actions.quote_prompt(),
              },
            },
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
      pcall(require('telescope').load_extension, 'emoji')
      pcall(require('telescope').load_extension, 'live_grep_args')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      -- local utils = require 'telescope.utils'

      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sb', function()
        builtin.buffers {
          sort_lastused = true,
        }
      end, { desc = '[S]earch [B]uffers' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', ':Telescope live_grep_args<cr>', { desc = '[S]earch by [G]rep', silent = true })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sc', builtin.resume, { desc = '[S]earch [C]ontinue' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })

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
  { 'MattesGroeger/vim-bookmarks' },
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
        watch_for_changes = true,
        keymaps = {
          ['<C-h>'] = false,
          ['`'] = {
            'actions.cd',
            opts = {
              scope = 'tab',
            },
          },
        },
        skip_confirm_for_simple_edits = true,
      }
      vim.keymap.set('n', '<leader>.', function()
        require('oil').open()
      end, { desc = 'Locate current file' })
      vim.keymap.set('n', '<leader><leader>', function()
        require('oil').open(vim.loop.cwd())
      end, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>oq', function()
        require('oil.actions').send_to_qflist.callback()
      end, { desc = '[o]il [q]uickfix' })
    end,
  },

  {
    'chentoast/marks.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  { 'editorconfig/editorconfig-vim' },

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
  {
    'nvzone/typr',
    dependencies = 'nvzone/volt',
    opts = {},
    cmd = { 'Typr', 'TyprStats' },
  },
  {
    'Aasim-A/scrollEOF.nvim',
    event = { 'CursorMoved', 'WinScrolled' },
    opts = {},
  },
}
