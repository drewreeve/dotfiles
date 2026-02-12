vim.pack.add({
  "https://github.com/nvim-mini/mini.nvim",
})

require("mini.ai").setup()

require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()

require("mini.surround").setup()
