return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = {
        setup = function(ctx)
          if vim.fn.exists ':NoMatchParen' ~= 0 then
            vim.cmd [[NoMatchParen]]
          end
          Snacks.util.wo(0, { foldmethod = 'manual', statuscolumn = '', conceallevel = 0 })
          vim.b.completion = false
          vim.b.minianimate_disable = true
          vim.b.minihipatterns_disable = true
          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(ctx.buf) then
              vim.bo[ctx.buf].syntax = ctx.ft
            end
            Snacks.indent.disable()
          end)
        end,
      },
      debug = {},
      input = {},
      indent = {
        animate = { enabled = false },
      },
      picker = {},
      notifier = {},
      quickfile = {},
      words = {},
    },
  },
}
