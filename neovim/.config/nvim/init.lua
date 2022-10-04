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
local servers = {
    "sumneko_lua",
    "marksman"
}

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = servers
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require'lspconfig'.sumneko_lua.setup {
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
    capabilities = capabilities
}
require'lspconfig'.marksman.setup {
    capabilities = capabilities
}

