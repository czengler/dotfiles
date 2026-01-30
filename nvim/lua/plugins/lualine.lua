return {
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    config = function()
      local hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end

      local diff = {
        'diff',
        colored = false,
        symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
        cond = hide_in_width,
      }

      local mode = {
        'mode',
        fmt = function(str)
          return '-- ' .. str .. ' --'
        end,
      }

      local filetype = {
        'filetype',
        icons_enabled = true,
        icon = nil,
      }

      local branch = {
        'branch',
        icons_enabled = true,
        icon = '',
      }

      local progress = function()
        local total_lines = vim.fn.line '$'
        local r = vim.api.nvim__buf_stats(0).current_lnum
        local c = vim.fn.getcurpos()[5]
        return r .. ':' .. c .. '/' .. total_lines
      end

      local lsp_server = function()
        local clients = vim.lsp.get_clients()
        if not clients or vim.tbl_isempty(clients) then
          return ''
        end
        local server_names = ' '
        for _, client in pairs(clients) do
          server_names = server_names .. client.name .. ' '
        end
        return server_names
      end

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'tokyonight',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = { 'dashboard', 'NvimTree', 'Outline' },
          always_divide_middle = true,
        },
        sections = {
          lualine_a = { mode },
          lualine_b = { branch, diff },
          lualine_c = { 'filename' },
          lualine_x = { lsp_server, filetype },
          lualine_y = { progress },
          lualine_z = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = {},
      }
    end,
  },
}
