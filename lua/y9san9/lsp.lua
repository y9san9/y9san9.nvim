return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim' },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      -- FIXME: remove this LSP

      vim.lsp.config['kotlin-ls'] = {
        cmd = { "/Users/y9san9/Desktop/kotlin-lsp/kotlin-lsp.sh", "--stdio" },
        single_file_support = true,
        filetypes = { "kotlin" },
        root_markers = { "build.gradle", "build.gradle.kts", "pom.xml" },
      }
      vim.lsp.enable("kotlin-ls")

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          vim.diagnostic.config {
            -- signs = false,
            -- underline = false,
          }

          vim.keymap.set('n', '[d', function()
            vim.diagnostic.goto_prev()
          end, { desc = 'Goto Previous [D]iagnostic' })
          vim.keymap.set('n', ']d', function()
            vim.diagnostic.goto_next()
          end, { desc = 'Goto Next [D]iagnostic' })
          vim.keymap.set('n', '<leader>cd', function()
            vim.diagnostic.open_float()
          end)
          vim.keymap.set('n', '<leader>cD', function()
            vim.diagnostic.setloclist()
          end)

          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('grD', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('g0', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
      local diagnostic_signs = {}
      for type, icon in pairs(signs) do
        diagnostic_signs[vim.diagnostic.severity[type]] = icon
      end
      vim.diagnostic.config { signs = { text = diagnostic_signs } }

      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- :help lspconfig-all
      -- NOTE: Setup autoformat on 151 line
      local servers = {
        -- kotlin_language_server = {
        --   autostart = false,
        --   init_options = {},
        -- },
        gopls = {},
        -- ts_ls = {
        --   settings = {
        --     diagnostics = { ignoredCodes = { 6133 } },
        --   },
        -- },
        -- eslint = {},
        -- pyright = {},
        -- rust_analyzer = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }
      -- -- configure Swift serve here since it is not installed via Mason
      -- require('lspconfig').sourcekit.setup {
      --   -- capabilities = capabilities,
      --   capabilities = {
      --     workspace = {
      --       didChangeWatchedFiles = {
      --         dynamicRegistration = true,
      --       },
      --     },
      --   },
      -- }
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  {
    'williamboman/mason.nvim',
    opts = {
      registries = {
        'github:mason-org/mason-registry',
        'github:616b2f/mason-registry-bsp',
      },
    },
  },

  {
    -- This is for the lua code inside of vim config
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
}
