local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

-- Normal mode --
-- Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- better inserting and deleting
keymap('n', '<leader>p', '"_dp', opts)
keymap('n', '<leader>P', '"_dP', opts)
keymap('v', '<leader>d', '"_d', opts)

-- better <C-d> and <C-u> movement
keymap('n', '<C-d>', '<C-d>zz', opts)
keymap('n', '<C-u>', '<C-u>zz', opts)

-- Better window navigation (including tmux)
keymap('n', '<C-h>', '<cmd>TmuxNavigateLeft<cr>', opts)
keymap('n', '<C-j>', '<cmd>TmuxNavigateDown<cr>', opts)
keymap('n', '<C-k>', '<cmd>TmuxNavigateUp<cr>', opts)
keymap('n', '<C-l>', '<cmd>TmuxNavigateRight<cr>', opts)
keymap('n', '<C-p>', '<cmd>close!<cr>', opts)

-- Resize with arrows
keymap('n', '<Up>', '<cmd>resize -2<cr>', opts)
keymap('n', '<Down>', '<cmd>resize +2<cr>', opts)
keymap('n', '<Left>', '<cmd>vertical resize -2<cr>', opts)
keymap('n', '<Right>', '<cmd>vertical resize +2<cr>', opts)

-- Navigate buffers
keymap('n', ']b', ':bnext<cr>', opts)
keymap('n', '[b', ':bprevious<cr>', opts)
keymap('n', '<leader>d', '<cmd>Bdelete!<cr>', opts)

-- Move single lines
keymap('n', '∆', ':m .+1<cr>==', opts)
keymap('n', '˚', ':m .-2<cr>==', opts)

-- Useful little normal mode mappings
keymap('n', '<leader>a', '<cmd>enew<cr>', opts)
keymap('n', '<leader>h', '<cmd>nohlsearch<cr>', opts)
keymap('n', '<leader>xd', '<cmd>:%s/ //g<cr>', opts) -- Delete whitespaces
keymap('n', '<leader>xc', '<cmd>:e ~/.config/nvim/init.lua<cr>', opts) -- Configure VIM
keymap('n', '<leader>p', '<cmd>Lazy<cr>', opts) -- Packagemanager (Lazy)
keymap('n', '<leader>gg', '<cmd>Git<cr>', opts) -- Fugitive

-- Formatting mappings
keymap('n', '<leader>xx', '<cmd>px :%!xmllint % --format<cr>', opts) -- Format xml
keymap('n', '<leader>xj', '<cmd>%!jq .<cr>', opts) -- Format json

-- Visual mode --
-- Indent & stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Move text up and down
keymap('v', '∆', ":m '>+1<cr>gv=gv", opts)
keymap('v', '˚', ":m '>-2<cr>gv=gv", opts)

-- Visual Block --
-- Move text up and down
keymap('x', 'J', ":move '>+1<cr>gv-gv", opts)
keymap('x', 'K', ":move '<-2<cr>gv-gv", opts)
keymap('x', '∆', ":move '>+1<cr>gv-gv", opts)
keymap('x', '˚', ":move '<-2<cr>gv-gv", opts)

-- Insert mode --
keymap('i', '<C-Enter>', '<C-o>A;', opts)

-- Terminal mode --
keymap('t', '<C-X>', '<C-\\><C-n>', opts)
