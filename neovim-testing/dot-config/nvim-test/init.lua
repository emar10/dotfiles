vim.loader.enable()

-- options
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.number = true
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.list = true
vim.o.inccommand = 'nosplit'
vim.o.cursorline = true

-- keymaps
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<Leader>ff', ':Pick files<cr>', { desc = '[f]ind [f]iles' })
vim.keymap.set('n', '<Leader>sg', ':Pick grep_live<cr>', { desc = '[s]earch with [g]rep' })

-- plugins
vim.pack.add({
  { src = 'https://github.com/catppuccin/nvim' },
  { src = 'https://github.com/nvim-mini/mini.pick' },
})
require('mini.pick').setup()

vim.cmd.colorscheme 'catppuccin-nvim'

-- enable experimental ui2
require('vim._core.ui2').enable({ enable = true, msg = { targets = 'msg' }})

-- vim: ts=2 sts=2 sw=2 et
