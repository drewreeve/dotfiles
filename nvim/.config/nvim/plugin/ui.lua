vim.pack.add({
  "https://github.com/brenoprata10/nvim-highlight-colors",
  "https://github.com/lewis6991/gitsigns.nvim",
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
  "https://github.com/sainnhe/gruvbox-material",
})

require("nvim-highlight-colors").setup({})

require("catppuccin").setup({
  flavour = "mocha",
  integrations = {
    blink_cmp = true,
    snacks = true,
  },
})
vim.cmd.colorscheme("catppuccin")
