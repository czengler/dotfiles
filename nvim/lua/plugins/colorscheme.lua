return {
  {
    lazy = false,
    'f-person/auto-dark-mode.nvim',
    opts = {},
  },

  {
    'rose-pine/neovim',
    lazy = false,
    priority = 1000,
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup {
        variant = 'auto', -- auto, main, moon, or dawn
        dark_variant = 'moon', -- main, moon, or dawn
        dim_inactive_windows = false,
        extend_background_behind_borders = true,

        styles = {
          bold = true,
          italic = true,
          transparency = false,
        },
      }

      vim.cmd 'colorscheme rose-pine'
    end,
  },

  -- {
  --   'folke/tokyonight.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     ---@diagnostic disable-next-line: missing-fields
  --     require('tokyonight').setup {
  --       style = 'night',
  --       light_style = 'day',
  --       transparent = true,
  --       styles = {
  --         comments = { italic = true },
  --         keywords = { italic = false },
  --         sidebars = 'transparent',
  --         floats = 'transparent',
  --       },
  --       -- sidebars = { 'qf', 'help' }, -- darker background on sidebar-like windows
  --       -- day_brightness = 0.3,
  --       dim_inactive = false,
  --       lualine_bold = true,
  --     }
  --     vim.cmd.colorscheme 'tokyonight-night'
  --   end,
  -- },
}
