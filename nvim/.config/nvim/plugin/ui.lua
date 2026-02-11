vim.pack.add({
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/brenoprata10/nvim-highlight-colors",
  "https://github.com/sainnhe/gruvbox-material",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/folke/snacks.nvim",
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
})

require("nvim-highlight-colors").setup({})

require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()

require("lualine").setup({
  sections = {
    lualine_b = { "branch", "diagnostics" },
    lualine_c = {
      { "filename", path = 1 },
    },
    lualine_x = {
      -- "encoding",
      -- { "fileformat", icons_enabled = false },
      "filetype",
    },
  },
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

require("catppuccin").setup({
  flavour = "mocha",
  integrations = {
    blink_cmp = true,
    snacks = true,
  },
})
vim.cmd.colorscheme("catppuccin")
