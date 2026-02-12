vim.pack.add({
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/tpope/vim-eunuch",
})

require("oil").setup({
  keymaps = {
    ["<C-h>"] = false,
    ["<C-s>"] = false,
  },
  view_options = {
    show_hidden = true,
  },
})
