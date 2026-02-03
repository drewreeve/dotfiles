vim.pack.add({
  "https://github.com/stevearc/oil.nvim",
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

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
