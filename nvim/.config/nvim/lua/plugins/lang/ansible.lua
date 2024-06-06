return {
  { "pearofducks/ansible-vim" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      settings = {
        servers = {
          ansiblels = {},
        },
      },
    },
  },
}
