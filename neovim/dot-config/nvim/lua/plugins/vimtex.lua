return {
  {
    "lervag/vimtex",
    config = function()
      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
      vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
      vim.g.vimtex_compiler_method = "tectonic"
      vim.g.vimtex_view_method = "zathura"
    end,
    keys = {
      { "<localLeader>l", "", desc = "+vimtex", ft = "tex" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        texlab = {
          settings = {
            texlab = {
              build = {
                args = { "-X", "compile", "%f", "--synctex", "--keep-logs", "--keep-intermediates" },
                executable = "tectonic",
                forwardSearchAfter = false,
                onSave = false,
              },
            },
          },
        },
      },
    },
  },
}
