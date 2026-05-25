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
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.completeopt = 'menu,popup,noselect'

-- keymaps
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<Leader>ff', ':Pick files<CR>', { desc = '[f]ind [f]iles' })
vim.keymap.set('n', '<Leader>sg', ':Pick grep_live<CR>', { desc = '[s]earch with [g]rep' })
vim.keymap.set('n', '<Leader>os', ':edit $MYVIMRC<CR>', { desc = '[o]pen [s]ettings file' })
vim.keymap.set('n', '<Leader>ss', ':update<CR>:source<CR>', { desc = '[s]ave and [s]ource' })

-- plugins
vim.pack.add({
  { src = 'https://github.com/catppuccin/nvim' },
  { src = 'https://github.com/nvim-mini/mini.nvim' },
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = "https://github.com/arborist-ts/arborist.nvim" },
})

-- mini.nvim
local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    { mode = { 'n', 'x' }, keys = '<Leader>' },
    { mode = { 'i' }, keys = '<C-x>' },
  },

  clues = {
    miniclue.gen_clues.builtin_completion(),
  },
})
require('mini.comment').setup()
require('mini.diff').setup()
require('mini.icons').setup()
require('mini.pick').setup()
require('mini.git').setup()
require('mini.statusline').setup()
require('mini.tabline').setup()

require('mason').setup()
require('arborist').setup()

vim.cmd.colorscheme 'catppuccin-nvim'

-- lsp
vim.lsp.enable({ 'lua_ls' })
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
      },
    },
  },
})
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end
})

-- enable experimental ui2
require('vim._core.ui2').enable({ enable = true, msg = { targets = 'msg' }})

-- vim: ts=2 sts=2 sw=2 et
