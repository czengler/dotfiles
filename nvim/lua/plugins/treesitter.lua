return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'master',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'bash',
          'c',
          'csv',
          'elixir',
          'go',
          'lua',
          'gitignore',
          'vim',
          'query',
          'rust',
          'vue',
          'javascript',
          'typescript',
          'css',
          'html',
          'java',
          'kotlin',
          'yaml',
          'proto',
          'markdown',
          'markdown_inline',
          'zig',
        },
        sync_install = false,
        ignore_install = { '' },
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 5000 * 1024 -- 5 MB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize and lang ~= 'json' and lang ~= 'xml' then
              return true
            end
          end,
          additional_vim_regex_highlighting = { 'markdown' },
          -- additional_vim_regex_highlighting = true,
        },
        autopairs = {
          enable = true,
        },
        indent = { enable = true, disable = { 'yaml' } },
      }
    end,
  },
}
