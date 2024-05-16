return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      keymaps = {
        ["<C-h>"] = false,
        ["<C-s>"] = false,
      },
      view_options = {
        show_hidden = true,
      },
    })
  end,
  keys = {
    { "-", "<CMD>Oil<CR>", { desc = "Open parent directory" } },
  },
}
