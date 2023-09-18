-- Base nvim options
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.mouse = "a"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.showmode = false
vim.opt.title = true
vim.opt.guifont = "Iosevka:h12"


-- Plugins
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'windwp/nvim-autopairs'
    use 'L3MON4D3/LuaSnip'
    use 'numToStr/Comment.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'feline-nvim/feline.nvim'
    use 'lewis6991/gitsigns.nvim'
    use 'tpope/vim-fugitive'
    use { "catppuccin/nvim", as = "catppuccin" }
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }

    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp'

    use 'nvim-treesitter/nvim-treesitter'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'neovim/nvim-lspconfig'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)


-- Colorscheme
require('catppuccin').setup()
vim.cmd [[colorscheme catppuccin]]


-- Setup Comment
require("Comment").setup()


-- Setup gitsigns
require'gitsigns'.setup()


-- Setup feline
local ctp_feline = require('catppuccin.groups.integrations.feline')
require("feline").setup({
    components = ctp_feline.get(),
})


-- Setup luasnip
require("luasnip.loaders.from_vscode").lazy_load()


-- cmp configuration
local cmp = require'cmp'
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
    }),
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = true })
    })
})


-- Setup telescope
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { silent = true })
vim.keymap.set("n", "<leader>fh", ":Telescope find_files hidden=true<CR>", { silent = true })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { silent = true })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { silent = true })


-- Setup Treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    ignore_install = { "phpdoc" },
    highlight = { enable = true },
    autopairs = { enable = true },
    indent = { enable = true },
}


-- autopairs configuration
local autopairs = require'nvim-autopairs'
autopairs.setup({
    check_ts = true,
})
local cmp_autopairs = require'nvim-autopairs.completion.cmp'
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done {})


-- LSP Config
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { noremap = true })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap = true })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap = true })
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { noremap = true })

local on_attach = function(client, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local servers = {
    "clangd",
    "jedi_language_server",
    "lua_ls",
    "marksman",
    "omnisharp",
    "ruff_lsp",
    "rust_analyzer",
    "texlab",
}

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = servers
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require'lspconfig'.clangd.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
require'lspconfig'.jedi_language_server.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}
require'lspconfig'.ruff_lsp.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}
require'lspconfig'.marksman.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}
require'lspconfig'.omnisharp.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { "omnisharp" },
    enable_editorconfig_support = true,
    enable_roslyn_analyzers = true,
    enable_import_completion = true,
}
require'lspconfig'.rust_analyzer.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}
require'lspconfig'.lua_ls.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true)
            },
            telemetry = {
                enable = false
            }
        }
    },
    capabilities = capabilities,
    on_attach = on_attach,
}
require'lspconfig'.texlab.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        texlab = {
            build = {
                executable = "tectonic",
                args = { "-X", "compile", "%f", "--synctex", "--keep-logs", "--keep-intermediates" }
            }
        }
    }
}

