return {
  'saghen/blink.cmp',
  version = '1.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = 'default' },

    appearance = {
      nerd_font_variant = 'mono'
    },

    completion = { documentation = { auto_show = true } },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },
  opts_extend = { "sources.default" }
}
