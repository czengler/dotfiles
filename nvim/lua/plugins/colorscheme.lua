return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        style = 'night', -- `storm`, `moon`, `night`, `day`
        light_style = 'day',
        transparent = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = false },
          sidebars = 'transparent',
          floats = 'transparent',
        },
        -- sidebars = { 'qf', 'help' }, -- darker background on sidebar-like windows
        -- day_brightness = 0.3,
        dim_inactive = false,
        lualine_bold = true,
      }
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },
}
