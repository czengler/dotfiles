vim.g.have_nerd_font = true

vim.o.backup = false
vim.o.cmdheight = 1
-- vim.o.completeopt = { 'menuone' }
vim.o.conceallevel = 0
vim.o.fileencoding = 'utf-8'
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.mouse = 'a'
vim.o.pumheight = 10
vim.o.showmatch = true
vim.o.showmode = false
vim.o.showtabline = 1
vim.o.smartcase = true
vim.o.inccommand = 'split'
vim.o.smartindent = true
vim.o.softtabstop = 4
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.timeoutlen = 300
vim.o.undofile = true
vim.o.updatetime = 100
vim.o.writebackup = false
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.cursorline = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 4
vim.o.signcolumn = 'yes'
vim.o.wrap = true
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.synmaxcol = 8096
vim.o.ve = 'all'
vim.o.confirm = true

vim.o.winborder = 'rounded'

vim.opt.shortmess:append 'I'

vim.cmd 'set whichwrap+=<,>,[,],h,l'
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]]
vim.cmd [[let $LANG='en_US.UTF-8']]
vim.cmd [[let $NVIM_TUI_ENABLE_TRUE_COLOR=1]]

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
