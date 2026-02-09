vim.pack.add({
  "https://github.com/folke/snacks.nvim",
})

require("snacks").setup({
  picker = {
    win = {
      input = {
        keys = {
          ["<Esc>"] = { "close", mode = { "n", "i" } },
        },
      },
    },
  },
})
