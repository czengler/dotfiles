return {
  {
    'ThePrimeagen/harpoon',
    lazy = false,
    branch = 'harpoon2',
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      vim.keymap.set('n', '<leader>m', function()
        harpoon:list():add()
      end)

      vim.keymap.set('n', '<leader>l', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      local conf = require('telescope.config').values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end

      vim.keymap.set('n', '<leader>t', function()
        toggle_telescope(harpoon:list())
      end, { desc = 'Open harpoon window' })

      for _, idx in ipairs { 1, 2, 3, 4, 5, 6, 7, 8, 9 } do
        vim.keymap.set('n', string.format('<leader>%d', idx), function()
          harpoon:list():select(idx)
        end)
      end
    end,
  },
}
