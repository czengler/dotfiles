return {
  'nvim-telescope/telescope.nvim',

  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    require('telescope').setup {
      defaults = {
        path_display = { 'smart' },
        mappings = {
          i = {
            ['<C-Up>'] = require('telescope.actions').cycle_history_prev,
            ['<C-Down>'] = require('telescope.actions').cycle_history_next,
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'smart_history')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require 'telescope.builtin'

    -- Find mappings
    vim.keymap.set('n', '<leader>b', builtin.buffers)
    vim.keymap.set('n', '<leader>f', builtin.find_files)
    vim.keymap.set('n', '<leader>g', builtin.live_grep)
    vim.keymap.set('n', '<leader>H', builtin.help_tags)
    vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find)

    -- Git mappings
    vim.keymap.set('n', '<leader>gb', builtin.git_branches)
    vim.keymap.set('n', '<leader>gc', builtin.git_commits)
    vim.keymap.set('n', '<leader>go', builtin.git_status)

    -- Code mappings
    vim.keymap.set('n', '<leader>cS', builtin.lsp_dynamic_workspace_symbols)
    vim.keymap.set('n', '<leader>cd', builtin.diagnostics)
    vim.keymap.set('n', '<leader>cs', builtin.lsp_document_symbols)
    vim.keymap.set('n', '<leader>cu', builtin.lsp_references)
  end,
}
