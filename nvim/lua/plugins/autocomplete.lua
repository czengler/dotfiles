return {
  {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      enabled = function()
        return not vim.tbl_contains({ 'markdown', 'json', 'xml' }, vim.bo.filetype)
      end,
      keymap = {
        preset = 'enter',
        ['<C-h>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<Tab>'] = {
          'snippet_forward',
          function()
            return require('sidekick').nes_jump_or_apply()
          end,
          -- function() -- if you are using Neovim's native inline completions
          --   return vim.lsp.inline_completion.get()
          -- end,
          'fallback',
        },
        ['<C-f>'] = false,
        ['<C-[>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-]>'] = { 'scroll_documentation_down', 'fallback' },
      },

      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      snippets = {
        preset = 'luasnip',
      },

      fuzzy = { implementation = 'prefer_rust_with_warning' },

      signature = { enabled = true },
    },
  },
}
