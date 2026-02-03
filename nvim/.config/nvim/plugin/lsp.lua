vim.pack.add({
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/b0o/schemastore.nvim",
})

require("mason").setup()
require("mason-lspconfig").setup()

require("mason-tool-installer").setup({
  ensure_installed = {
    "ansiblels",
    "bashls",
    "jsonls",
    "lua_ls",
    "shellcheck",
    "shfmt",
    "stylua",
    "yamlls",
  },
})
