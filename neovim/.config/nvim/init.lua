-- Options
vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.writebackup = false

vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.cmdheight = 1
vim.opt.mouse = "a"
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.showmode = false
vim.opt.showtabline = 1
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.laststatus = 3
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.g.netrw_banner = 0
vim.g.netrw_mouse = 2

vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.guifont = "monospace:h17"
vim.opt.title = true

-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "tpope/vim-fugitive",
    "nvim-tree/nvim-web-devicons",
    { "lewis6991/gitsigns.nvim", config = true },

    { 
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup {
                term_colors = true,
                integrations = {
                    mason = true,
                },
            }

            vim.cmd.colorscheme "catppuccin"
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        name = "lualine",
        opts = {
            options = {
                theme = "catppuccin",
                section_separators = { left = '', right = '' },
                component_separators = { left = '', right = '' },
            },
        },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        main = "nvim-treesitter.configs",
        opts = {
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        },

        dependencies = {
            { "windwp/nvim-autopairs", opts = { check_ts = true } },
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>?", "<cmd>Telescope oldfiles<cr>", desc = "[?] Find recently opened files" },
            { "<leader><space>", "<cmd>Telescope buffers<cr>", desc = "[ ] Find existing buffers" },
            { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Search [G]it [F]iles" },
            { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "[S]earch [F]iles" },
        },
    },

    {
        "hrsh7th/nvim-cmp",
        name = "cmp",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            {
                "neovim/nvim-lspconfig",
                dependencies = {
                    { "williamboman/mason.nvim", config = true },
                    {
                        "williamboman/mason-lspconfig.nvim",
                        opts = {
                            ensure_installed = { "lua_ls", "pyright", "ruff_lsp" },
                            automatic_installation = true,
                            handlers = {
                                function (server_name)
                                    require("lspconfig")[server_name].setup {}
                                end,
                            },
                        },
                    },
                    "folke/neodev.nvim",
                },
            },
        },
        config = function()
	    local cmp = require "cmp"
	    cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }),
	    })
        end
    },
})

