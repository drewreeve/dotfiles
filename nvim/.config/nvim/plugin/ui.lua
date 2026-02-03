vim.pack.add({
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
  "https://github.com/sainnhe/gruvbox-material",
})

require("catppuccin").setup({
  flavour = "mocha",
  integrations = {
    blink_cmp = true,
    snacks = true,
  },
})
vim.cmd.colorscheme("catppuccin")
