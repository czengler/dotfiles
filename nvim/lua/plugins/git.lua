return {
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'Gdiffsplit', 'Gread', 'Gwrite', 'Ggrep', 'GMove', 'GDelete', 'GBrowse' },
  },

  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    config = function()
      local gs = require 'gitsigns'
      gs.setup {
        signs = {
          add = { text = '' },
          change = { text = '▎' },
          delete = { text = '' },
          topdelete = { text = '' },
          changedelete = { text = '▎' },
        },
      }

      vim.keymap.set('n', '[g', '<cmd>Gitsigns prev_hunk<cr>')
      vim.keymap.set('n', ']g', '<cmd>Gitsigns next_hunk<cr>')
      vim.keymap.set('n', '<leader>gR', gs.reset_buffer)
      vim.keymap.set('n', '<leader>gd', '<cmd>Gitsigns diffthis HEAD<cr>')
      vim.keymap.set('n', '<leader>gj', gs.next_hunk)
      vim.keymap.set('n', '<leader>gk', gs.prev_hunk)
      vim.keymap.set('n', '<leader>gl', gs.blame_line)
      vim.keymap.set('n', '<leader>gp', gs.preview_hunk)
      vim.keymap.set('n', '<leader>gr', gs.reset_hunk)
      vim.keymap.set('n', '<leader>gs', gs.stage_hunk)
      vim.keymap.set('n', '<leader>gu', gs.undo_stage_hunk)
    end,
  },
}
