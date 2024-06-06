return {
  "tpope/vim-rails",
  "vim-ruby/vim-ruby",

  {
    "neovim/nvim-lspconfig",
    opts = {
      settings = {
        servers = {
          ruby_lsp = {},
        },
      },
    },
  },
}
